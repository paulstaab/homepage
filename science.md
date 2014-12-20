---
layout: 
title: Science
permalink: /science/
layout: default
image:
  feature: science.jpg
  credit: chasblackman 
  creditlink: https://secure.flickr.com/photos/chasblackman 
---

I am currently doing a Phd in Statistical Genetics. You can find my publications, 
software and scientific blog articles on this page.

## Publications
- **Why to account for finite sites in population genetic studies and 
  how to do this with Jaatha 2.0.**
  Lisha A. Mathew, Paul R. Staab, Laure E. Rose, and Dirk Metzler.
  Ecology and Evolution 2013.
  [LINK](http://onlinelibrary.wiley.com/doi/10.1002/ece3.722/abstract)
  [PDF](/dl/science/mathew_2013.pdf)
- **Muller’s ratchet with compensatory mutations.**
  Peter Pfaffelhuber, Paul R Staab and Anton Wakolbinger. 
  Ann. Appl. Probab. Volume 22, Number 5 (2012), 2108-2132. 
  [LINK](http://projecteuclid.org/euclid.aoap/1350067996)
  [PDF](/dl/science/PfaffelhuberEtAl_2012.pdf)
- **Muller’s ratchet with compensatory mutations.**
  Paul R Staab. Diploma thesis. 2011. 
  [PDF](/dl/science/Diplomarbeit.pdf)
- **SynBioWave – a real-time communication platform for molecular and synthetic
  biology.**
  Paul R Staab, Jorg Walossek, David Nellessen, Raik Grunberg, Katja M. Arndt
  and Kristian M. Müller. 
  Bioinformatics 2010.
  [LINK](http://bioinformatics.oxfordjournals.org/content/early/2010/09/13/bioinformatics.btq518.abstract.html?ijkey=2dVEdcoPiWNOXnW&amp;keytype=ref)
  [PDF](http://bioinformatics.oxfordjournals.org/content/early/2010/09/13/bioinformatics.btq518.full.pdf?ijkey=2dVEdcoPiWNOXnW&amp;keytype=ref)

More information on my articles is available at my 
[Google Scholar Profile](http://scholar.google.de/citations?user=aRPHGTAAAAAJ).



## Software
- [**Jaatha**](http://evol.bio.lmu.de/_statgen/software/jaatha/). 
  A simulation based composite-likelihood method to fix an evolutionary model to genetic data.
- [**scrm**](https://scrm.github.io).
  An efficient coalescent simulator for genome-scale sequences.
- **mrj – Muller’s ratchet in Java**. 
  Simulates a population of haploids undergoing 
  [Muller's Ratchet](https://secure.wikimedia.org/wikipedia/en/wiki/Muller%27s_ratchet)
  Capable of compensatory mutations. [Runnable jar file](/dl/science/mrj.jar) – [Source Code](/dl/science/mrj-src.tar.gz)
- [**SynBioWave**](http://www.synbiowave.org).
    A collaborative synthetic biological software suite, based on
    discontinued Google Wave.


## Articles
<div id="index" style="width:100%;">
{% for post in site.categories.science limit:5 %}
{% include article.html %}
{% endfor %}
</div>
