---
format: markdown
date: 2012/01/17 00:00:00
title: The first production Rascals sell out, plus some Color Kinetics action
categories: rascal
---

The first production run of 15 Rascals sold out a few days ago. Thanks to all of you who bought them-- the revenue will go directly back into making the next run.

The next batch of Rascals will be nearly identical to the previous batch. The hardware changes are:

1. Added second USB host port and stacked USB connector
2. Cheaper, newer, less power-hungry Ethernet controller (Micrel KSZ8051RNL)
3. Moved the I2C/TWI pins to the Arduino-compatible location
4. Added I2S port for streaming audio
5. Changed JTAG and serial debug footprints to work with pogo pins more easily

The software will also be improved for the next batch, in part thanks to the people who have been tweaking the code on their Rascals. The editor will have some new features and the set of tested libraries on the Rascal will be much larger. Because the hardware changes are minor, it's likely that the new software will run fine on old Rascals.

The next batch will be delayed because of Chinese New Year, which runs from January 20 - February 5 this year. In the meantime, if you're interested in buying a Rascal, sign up for the [announcement list][6] to get alerted when they're ready.

### Making the Rascal work with Color Kinetics lights ###

Most of my time has been devoted to PCB layout, but I've also been working on some Rascal-controlled light displays around Boston with a [group of public artists][1] operating out of [Artisan's Asylum][2]. Dan Taub of [CEMMI][5] was kind enough to lend me a Color Kinetics light for testing. I've been using a [Python library written by Giles Hall][3] that wraps DMX512 data in UDP packets using the KiNet protocol. I created a quick demo page consisting of a color picker on a web page. You pick a color and the Rascal tells the light to turn that color.

Here's a short video that shows the demo in action. If you happen to be on Artisan's Asylum's wireless network, you're welcome to [test it out][7] yourself-- just look for the light near the Rascal Micro space (#16).

<iframe class="span14" src="http://player.vimeo.com/video/35173486?title=0&amp;byline=0&amp;portrait=0&amp;color=C6433C" height="461" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

[1]: http://newamericanpublicart.com
[2]: http://artisansasylum.com
[3]: https://github.com/vishnubob/kinet
[5]: http://cemmi.org
[6]: http://store.rascalmicro.com
[7]: http://rascal14.local/ck.html