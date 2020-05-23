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
While pandas UDFs are certainly the most prominent improvement, a collegue pointed me towards 
a less well-known and almost undocument feature which daramatically simplifies
the creation of Extract-Transform-Load (ETL) jobs with Spark: 
**Dynamic partition overwrite mode**.
<!--more-->

## Creating idempotent ETL logic

Dynamic partition overwrite mode was [added in Spark 2.3][1] and solves a 
problem that often occured when saving new data into an existing table. 
To understand the problem, let's first look at Spark's four modes for writing data: 

- **error**: Throws an error if we are trying to write into an existing table.
- **ignore**: Does not write any data if the table exists.
- **overwrite**: Overwrites the complete table with the new data.
- **append**: Appends the data to the table.

All of them are useful in some circumstances, but for ETL jobs the data often 
comes in incremental deliveries containing on or more complete partitions of 
the data. For example, assume we have a table with information about which items
where bought in our online shop. We get a new data deliviery every morning, and
the delivery normally contains all items we sold on the previous day. As long
as everything works well, we can use the *append* write mode to add data to
the table. In reality however, things tend to not always work so well. Our
job will fail from time to time, maybe because the data was not accesible when
the job tried to read it, our job crashed because of a bug or 
the whole Spark cluster had an outage while our job was running. 
When rerunning the failed job, the *append* option tends to cause data duplication
issues, because the data was already partially loaded in the failed first run and 
is now added again. 

To deal with such errors, it is desiarable that re-executions of 
a job with an old delivery does not change the target table if this delivery was already loaded, 
but fixes any existing problems with the data for this delivery. 
This is property is often refered to as *idempotency*, and while all of Spark's write modes but 
*append* are idempotent, only *append* is suitable for incremental loads.




## References
[1]: https://issues.apache.org/jira/browse/SPARK-20236

- [Blogpost: Spark Dynamic Partition Inserts — Part 1](https://medium.com/nmc-techblog/spark-dynamic-partition-inserts-part-1-5b66a145974f)
- [Blogpost: Spark Dynamic Partition Inserts and AWS S3 — Part 2](https://medium.com/nmc-techblog/spark-dynamic-partition-inserts-and-aws-s3-part-2-9ba0c97ad2c0)
- https://gist.github.com/roitvt/0d5b1a9d09f73036689dd022d197d6ca#file-hadoopmapreducecommitprotocol-scala

