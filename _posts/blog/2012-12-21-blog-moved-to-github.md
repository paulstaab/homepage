--- 
title: My blog just moved to GitHub
categories: [Personal]
type: post
layout: post
img: /img/posts/2012-12-21-blog-moved-to-github.png
img-desc: Screenshot of my homepage
img-copyright: Paul Staab (CC-3.0-BY).
---

Yesterday I relaunched my blog; I used the popular Back-End software
wordpress before, but never really liked it. It was quite annoying to
permanently updated plugins and to backup the database. And the html produced by
the wysiwyg editor was really ugly, even when using the html mode...

Now I use [Jekyll](http://www.jekyll.com "Jekyll Homepage"), which is a
generator for static html pages. You can generate your homepage locally on your
computer and then just copy the resulting HTML files to your server. No
database, no outdated plugins, no potential SQL-injections, "automatic" local
backup.
But its USP is that it is the system used by [GitHub pages](http://pages.github.com). 
If you place a Jekyll project in a git repository on GitHub, it will
automatically build **and host** the site for you.

How to create a site with Jekyll and host it on GitHub is nicely explained in
[Brian Scaturro\'s Blog](http://brianscaturro.com/2012/06/12/blog-with-jekyll-and-github.html).
You can also look at the complete source code in 
[his](https://github.com/brianium/brianium.github.com) or 
[my](https://github.com/paulstaab/paulstaab.github.com) GitHub repo.

I chose to build my blog completely from scratch. It is not completely ready
yet. I still need to cleanup the messy HTML of my old posts, give them some nice
pictures and look for a solutions for comments. Finally something to do for my
Christmas holidays... 
