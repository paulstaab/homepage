---
layout:      post
author:      Paul
title:       "Benchmarking C++ Compilers. A Real World Example."
description: 
categories:  
- Open Source
tags:        [compiler, benchmark, scrm]
image:
  feature: 
  credit: 
  creditlink: 
---

I was curios how different compilers and the optimization options affect the
speed of my DNA simulation program scrm. There are almost no hard computations
in scrm; the bottleneck when running the program is reading and modifying
memory, so there might not be much for compilers to optimize. 
<!--more-->

I benchmarked the runtime of 
{% highlight bash %}
scrm 10 10 -r 1000 1000000 -seed 20
{% endhighlight %}
using the C++ version of gcc 4.8.2 and clang 3.4 with different optimization levels. 
The results are:

|    |  g++ | clang++ |
| -- | ---- | ------- |
| O0 | 152s |    150s |
| O1 |  31s |     78s |
| O2 |  26s |     34s |
| O3 |  25s |     34s |

Seems that increasing the optimization level up to `O2` really helps on both
compilers, and further increasing it to `O3` only gives a minor speed boost. On
high optimization levels, g++ is about 25% faster than clang++, so using the gcc
whenever possible seems to be a good idea.
