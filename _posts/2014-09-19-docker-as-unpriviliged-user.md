---
layout: post
title: "Using Unprivileged Users in Docker Containers"
date: 2014-09-19 16:54:46
author: Paul
description: "Increase the security of docker containers by switching to an unprivileged user."
categories:  
  - blog
  - Linux & Open Source
thumb:
---

Last month Jérôme Petazzoni 
[gave a talk](http://www.slideshare.net/jpetazzo/docker-linux-containers-and-security-does-it-add-up)
about the security of [Docker](https://docker.io) containers. The maybe most important
message of his talk was that one should avoid running applications as root in
containers wherever possible. Otherwise, it might be possible or at least easier
for an malicious application to free itself from the containers restrictions and
mess with the host system. Unfortunately, up to now not many people seem to
bother, and most images at the [Dockerhub](https://registry.hub.docker.com) (at
least the ones I looked at...) seem to be running as root anyway.
<!--more-->

It is quite easy to create an unprivileged user in an docker file. Just create
the user using the utils of the underlying distribution, e.g. 

    RUN useradd -ms /bin/bash testuser

on Debian/Ubuntu. Then you can switch to the users account with a 

    USER testuser

Every command afterwards will be executed as testuser. If you start an image
interactively, you will be the testuser:

    docker run -t -i nonroot_user_base
    testuser@131b7ad86360:~$

This is fine if you are shipping an application with docker, as I do with my
simulation program
[scrm](https://github.com/scrm/scrm-docker/blob/master/Dockerfile). It however
also has a few drawbacks:

- It is much more difficult for someone to modify the container, especially when
  running it interactively. One could allow password-less sudo for the user, but
  this would then again undermine security. It would be better using a password, 
  but then this password would have to be somehow communicated to the user.
- If you derive an image from an image with has switched to an
  unprivileged user, you first need to switch back to root before you can
  use commands that require root privilege. This seems to be pretty obvious, but
  one often does not known about the exact internal of the image he is building
  upon, and hence it might be quite confusing to have commands like `apt-get
  update` throwing an error.

Some tests I made about unprivileged users in docker are available at
GitHub.
