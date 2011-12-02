---
author: Brandon Stafford
categories: hardware
date: 2010/07/28 15:29:00
format: markdown
title: First prototypes in hand
---

The first batch of Rascals arrived fresh from the assembler a few days ago (July 14, 2010, for the historical record). I had [an assembly house in Colorado][1] solder all of the large chips, including the slightly scary BGA package. Thanks to a microscope from GreenMountain, I was able to solder the rest of the passive components myself. Initial power-up went well-- both of the switching DC/DC converters worked, and the power LEDs lit up. I discovered I had two pins switched on the linear regulator, but I was able to cut some traces with an X-acto knife and rewire the pins correctly.

After the regulator was working, I connected to the processor using the JTAG connector (that big gray thing) and was able to download and
execute code. I believe this instilled exultation at the time.

<img class="span14" src="/img/rascal-0.1-2010-07-28.jpg" alt="Picture of Rascal 0.1">

Then, I was able to locate more precisely the limits of my soldering capabilities – I verified that I am not able to solder arrays of 4 x 0402 resistors without bridging adjacent traces. As I was investigating the effects of this on the memory buses, I noticed that I had also invented a new
method of counting to eight: 1, 2, 3, 4, 5, 7, 6, 8. The results of this novel method were that two of the bus lines were swapped for all
14 resistor arrays. I decided to save this brilliant form of hardware encryption for later development.

Hence Rascal version 0.2, which I just released for fabrication last night. It was a little discouraging to have to turn the crank again,
but I was able to loosen up a lot of the manufacturing tolerances and shrink the board by 30% or so. The result is that I think I can now
get bare PCBs for $9.16 in a batch of 100, which is lower than I previously expected.

The next Rascals should be at least semi-functional by mid-August. If things go well, I'll have beta units for testing in September. Prepare your internet monitoring and control projects!

[1]: http://aapcb.com
