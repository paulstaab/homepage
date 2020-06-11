---
title: Pickle, ONNX and PMML - A comparison of storage formats for ML models
type: post
layout: post
author: Paul Staab
categories: [Machine Learning]
tags: [ML Serving, Python, sklearn]
published: True
---

Management Summary:

- I compare three different formats for storing scikit-learn models: Pickle, ONNX and PMML
- Pickle is fast and easy to use, but has security concerns and models may be incompatible with updated scikit-learn versions
- ONNX shines for neural networks and works well for other ML models but is more difficult to use
- Try to avoid using PMML when doing the inference with Python

<!--more-->

## Storing ML Models

The life-cycle of a Machine Learning model roughly consists of four stages:

1. Training: The model created during a training step, often on special training servers.
2. Deployment: The model is deployed into a production environment.
3. Inference: The model is used to generate predictions or to infer unknown information with
   the production data.
4. Retirement: The model is eventually turned off or replaced by a newer model.

In this post, we will focus on the deployment and inference steps for models generated with the popular
Python library `scikit-learn`. In order to deploy a model, we need to save it as a file and copy the file
to the production servers. The process of copying the file has received a lot of attention in the last years
and now usually involves modern DevOps practices like continuous integration pipelines, automatic tests and 
docker containers. In comparison, the process of saving the model as a file seems to be straight forward, 
and in case of scikit-learn, many practitioners often just use the 
[recommended approach of storing the model in Python's pickle format](https://scikit-learn.org/stable/modules/model_persistence.html).
However, this approach has some potentially problematic limitations for the inference stage later, which are also
[mentioned in scikit-learns documenation](https://scikit-learn.org/stable/modules/model_persistence.html#security-maintainability-limitations):

    * Never unpickle untrusted data as it could lead to malicious code
      being executed upon loading.
    * While models saved using one version of scikit-learn might load 
      in other versions, this is entirely unsupported and inadvisable. 
      It should also be kept in mind that operations performed on such 
      data could give different and unexpected results.

In my current project, we recently hit the second limitation. We could not load all of our models with newer versions of
scikit-learn, and where consequently force to stick with the old version or to completely retrain all the models (which
turned out to be impossible in our case). 

Both concerns can be mitigated by storing the model together with its serving logic in a docker container - or they 
can be completely removed by using a different storage format. For this purpose, we will compare Pickle with two other 
popular formats.

## Pickle

## PMML

## ONNX

| model     |   runtime_sklearn |   runtime_onnx |   rel_runtime_onnx |   diff_onnx |
|:----------|------------------:|---------------:|-------------------:|------------:|
| rf_small  |             0.25s |           0.3s |               +20% |          0% |
| rf_medium |             2.75s |          5.18s |               +88% |          0% |
| rf_large  |            19.83s |        106.09s |              +435% |          0% |
| lr        |             0.01s |          0.1s  |              +588% |          0% |
| knn       |            17.45s |         49.6s  |              +184% |          0% |
| nn_small  |             0.74s |          0.23s |               -68% |          0% |
| nn_medium |             3.36s |          1.14s |               -66% |          0% |

## Benchmarks



## References
- [JIRA-Ticket][1]
- [Implementation description][3]
- [Blogpost: Spark Dynamic Partition Inserts — Part 1](https://medium.com/nmc-techblog/spark-dynamic-partition-inserts-part-1-5b66a145974f)
- [Blogpost: Spark Dynamic Partition Inserts and AWS S3 — Part 2][2]

[1]: https://issues.apache.org/jira/browse/SPARK-20236
[2]: https://medium.com/nmc-techblog/spark-dynamic-partition-inserts-and-aws-s3-part-2-9ba0c97ad2c0
[3]: https://github.com/apache/spark/blob/master/core/src/main/scala/org/apache/spark/internal/io/HadoopMapReduceCommitProtocol.scala
