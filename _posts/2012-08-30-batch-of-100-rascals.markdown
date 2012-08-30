---
format: markdown
date: 2012/08/30 00:00:00
title: Batch of 100 Rascals on the way
categories: rascal
---

There are a lot of small bits of news since the last update a couple of weeks ago.

### 100 Rascals at the assembler ###

Last week, I sent a large box of components and bare PCBs off to the assembler-- over 10 kg in all. I'll get the first two Rascals back in a few weeks; if they work, the remaining 98 will be assembled and get shipped back to me. I'll put the new software release, codenamed "Beriberi," on them and put them up in the store. All I have to do in the meantime is *finish* the new software release!

### SPI transmission working from Python ###

The oscilloscope screenshot below shows the results of <code>pytronics.spiWrite('aaron burr')</code>, which was the first data transmission via SPI by the Rascal with the new Python SPI code that I wrote last week. This week, I figured out how to slow the bus down from 15 MHz so that it can operate slowly enough to talk to an Arduino. (If you send data too fast, the Arduino can't process characters fast enough. I'm not sure if it's a limitation of the SPI hardware on the Arduino missing edges or the processor getting overwhelmed by the characters arriving too fast. Anyway, it works fine at 528 kHz.)

<img src="/img/spi-first-transfer-aaron-burr-2012-08-17.png">

### Battery tutorial ###

I made [new tutorial about running a Rascal off batteries][1] recently. Along with the [wifi success][2] from 3 weeks back, it's been very exciting to be able to run a Rascal with no tether whatsoever. I've been quite impressed with how well the Rascal handles running off batteries-- I haven't been able to detect any difference from wall power yet.

### Come to World Maker Faire in New York ###

More news when the new batch arrives. I'm getting ready for the [World Maker Faire in New York][3] at the end of September; I hope to have new Rascals ready by then. I'm always interested to meet Rascal users and enthusiasts, so stop by the booth on Saturday or Sunday and ask me all your Rascal questions!

[1]: http://rascalmicro.com/docs/basic-tutorial-batteries.html
[2]: http://rascalmicro.com/blog/2012/08/09/testing-the-rascal-with-a-wireless-adapter-and-battery/
[3]: http://makerfaire.com/newyork/2012/index.html