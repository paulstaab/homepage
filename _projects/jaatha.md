---
layout: project
title: "Jaatha"
author: Paul
categories: projects
role: "Main Developer"
description: "A simulation-based parameter estimation method"
date_start: 2012-01-01
type: R Package
languages: R
img: jaatha.png
website: https://cran.r-project.org/package=jaatha
github: statgenlmu/jaatha
---

Jaatha is an estimation method that can use computer simulations to approximate
maximum-likelihood estimates even when the likelihood function can not be
evaluated directly. It can be applied whenever it is feasible to conduct many
simulations, but works best when the data is approximately Poisson distributed.
It was originally designed for demographic inference in evolutionary biology. It
has optional support for conducting coalescent simulation using the 'coala'
package.
