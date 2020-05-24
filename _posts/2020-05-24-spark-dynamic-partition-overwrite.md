---
title: Use Dynamic Partition Overwrite for ETL with Apache Spark
type: post
layout: post
author: Paul Staab
categories: [Big Data]
tags: [ETL, Spark]
published: True
---

After not using Apache Spark at all in 2019, I am currently catching up on 
features and improvements I missed since version 2.1. 
While pandas UDFs are certainly the most prominent improvement, a colleague pointed me towards 
a less well-known and almost undocumented feature which dramatically simplifies
the creation of Extract-Transform-Load (ETL) jobs with Spark: 
**Dynamic partition overwrite mode**.
<!--more-->


## The problem: ETL logic should be idempotent

Dynamic partition overwrite mode was [added in Spark 2.3][1] and solves a 
problem that often occurs when saving new data into an existing table (or 
data stored in a tabular format like Parquet, which I am going to refer to as tables 
as well here). 
To understand the problem, let's first look at Spark's four modes for writing data: 

- **error**: Throws an error if we are trying to write into an existing table.
- **ignore**: Does not write any data if the table exists.
- **overwrite**: Overwrites the complete table with the new data.
- **append**: Appends the data to the table.

All of them are useful in some circumstances, but for ETL jobs the data often 
comes in incremental deliveries containing one or more complete partitions of 
the data. For example, assume we have a table with information about which items
our online shop sold per day. We get a new data delivery every morning, and
the delivery normally contains all items we sold on the previous day. As long
as everything works well, we can use the *append* write mode to add data to
the table. In reality however, things tend to not always work so well. Our
job will fail from time to time, maybe because the data was not accessible when
the job tried to read it, our job crashed because of a bug or 
the whole Spark cluster had an outage while our job was running. 
When rerunning the failed job, the *append* option tends to cause data duplication
issues when the data was already partially loaded in the failed first run and 
is now added again.

To deal with such errors, it is desirable that re-executions of 
a job with an old delivery does not change the target table if this delivery was already loaded, 
but fixes any existing problems with the data for this delivery. 
This is property is often referred to as *idempotency*. And so far, 
Spark's only write mode for incremental loads - *append* - was not
idempotent.


## The solution: Idempotency by overwriting partitions

To obtain idempotency for ETL jobs, we first require that the deliveries
contain complete partitions of the data. If purchases from a given day
are included in a delivery, then it must contain all purchases from this
day.

This requirements gives us the possibility to obtain idempotent updates to 
our table by implementing the following logic:

(1) keep all days which are already in the table, but not in the new delivery 
(2) delete any days contained in the new delivery from the table
(3) append all data from the new delivery to the table

We had to implement this logic by hand in previous versions of Spark, and I did
so in at least one project. Doing this in an efficient manner was difficult and 
required error-prone fiddling with low-level implementation details of the storage
format. Since Spark 2.3, we get exactly this behavior when we set the option 
`spark.sql.sources.partitionOverwriteMode` to `dynamic` and overwrite the stored
data.

Assume our table is partitioned by `DATE` and currently contains three purchases:

| ITEM|QUANTITY|      DATE|
|-----|--------|----------|
|ITEM1|       5|2020-05-23|
|ITEM2|       1|2020-05-23|
|ITEM2|       3|2020-05-24|

We get a new get a new delivery for `2020-05-24` with and additional item which
was missing before:

| ITEM|QUANTITY|      DATE|
|-----|--------|----------|
|ITEM2|       3|2020-05-24|
|ITEM1|       2|2020-05-24|

We can now use dynamic partition overwrite to the data for the 24th, but keep the 
purchases from the previous day: 

```python
spark.conf.set('spark.sql.sources.partitionOverwriteMode', 'dynamic')
delivery \
    .write \
    .mode('overwrite') \
    .partitionBy('DATE') \
    .parquet('./pruchases')  
```

Now our data contains all four items and no item was duplicated:

```python
spark.read.parquet('./pruchases') \
    .orderBy('DATE')  \
    .show()
```

| ITEM|QUANTITY|      DATE|
|-----|--------|----------|
|ITEM1|       5|2020-05-23|
|ITEM2|       1|2020-05-23|
|ITEM2|       3|2020-05-24|
|ITEM1|       2|2020-05-24|


## Implementation Details

To implement the logic described above, Sparks first writes the new partitions into 
a temporary folder, then deletes the partitions from the old table and finally moves 
the new partitions to the correct place. This is described in 
[Spark's Score Code][3]:

```
 * @param dynamicPartitionOverwrite If true, Spark will overwrite partition directories at runtime
 *                                  dynamically, i.e., we first write files under a staging
 *                                  directory with partition path, e.g.
 *                                  /path/to/staging/a=1/b=1/xxx.parquet. When committing the job,
 *                                  we first clean up the corresponding partition directories at
 *                                  destination path, e.g. /path/to/destination/a=1/b=1, and move
 *                                  files from staging directory to the corresponding partition
 *                                  directories under destination path.
```

This implementation assumes that moving files is a fast and atomic operation. This is 
generally true for file systems like HDFS, but is not necessary for object storage.
Consequently, there are reports [that dynamic partition overwrite can be slow on S3][2].


## References
- [JIRA-Ticket][1]
- [Implementation description][3]
- [Blogpost: Spark Dynamic Partition Inserts — Part 1](https://medium.com/nmc-techblog/spark-dynamic-partition-inserts-part-1-5b66a145974f)
- [Blogpost: Spark Dynamic Partition Inserts and AWS S3 — Part 2][2]

[1]: https://issues.apache.org/jira/browse/SPARK-20236
[2]: https://medium.com/nmc-techblog/spark-dynamic-partition-inserts-and-aws-s3-part-2-9ba0c97ad2c0
[3]: https://github.com/apache/spark/blob/master/core/src/main/scala/org/apache/spark/internal/io/HadoopMapReduceCommitProtocol.scala
