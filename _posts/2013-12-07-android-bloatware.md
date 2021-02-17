---
layout:      post
author: Paul
title:       "Disabling Android Bloatware"
description: "Most Android devices ship with a lot of pre-installed crap. This
              Article deals with getting rid of it."
modified:    2013-12-07
categories:  
- Open Source
tags:        [Android, Bloatware]
img:
---

Most Android devices today ship with a lot of apps pre-installed by Google and
the device's vendor. These apps are often useless (at least for me), require a lot of permissions, and cannot
be easily deinstalled. Such "Bloatware" was one of many reasons for me to switch from
Windows to Linux 8 years ago. Now the situation on Linux-based Android feels 
even worse than it was/is with Windows, were you could at least deinstall the
programs, or -- even better -- go for a clean installation. 
<!--more-->

I don't use many Google services, as I run my own mail server and my contacts
and calendars are synced with my private ownCloud instance. So I don't need the
apps for Gmail, Goolge Contact/Calendar Sync, Google Picasa and so on. My
Samsung Galaxy Node 10.1 table also came with A LOT of crap from Samsung,
including their own app/media store, cloud sync stuff for files, contacts and
calendars, their own push service and video & music players. Most of these
always run in background, are a useless waste of battery, memory, disk space and data
transfer, and undermine my privacy. So lets try to get rid of them. 

## Deinstalling bloatware apps
It is not possible to deinstall apps that are included in our android firmware
unless you have a rooted device. If you do, one of simplest ways is to use
[Titanium Backup](https://play.google.com/store/apps/details?id=com.keramidas.TitaniumBackup) 
to deinstall the apps. I strongly recommend that you back
everything up beforehand, just in case you notice that something important is
not working afterwards. 

However, I have not rooted my tablet by now, so that this is not an option
there. And additional problem with this method is that the deinstalled apps tend
to come back with every firmware update you do (if you are lucky and still get
some...).

## Disabling bloatware apps
I recently found a more convenient way to get rid of Android bloatware. There is
an build in feature in Android that allows you to "disable" system apps.
Disabling means that the app is still on your device, but no longer executed and
updated, so all it costs you afterwards is a bit of disk space. 

To disable an app, go to

    Settings -> Apps -> All 

select the app, and click on *Disable*. On my Samsung tablet, I first have to
deinstall all updates before it shows me the "Disable" button. You can enable
them again similarly later by going to

    Settings -> Apps -> Disabled

if you like to. 

So far, I disabled most of the Google apps (com.google.\*) without noticing any
unwanted side effects, as well as everything with Samsung in its name. Be careful with
system apps (com.android.\*), as they might be actually useful for something. 
My tablet and in particular my phone -- which as only little memory -- feel much faster now. 
Disabled apps also seem to stay disabled after firmware upgrades. If you have
any reinstalled apps that you don't use, I recommend that you give it a try.
