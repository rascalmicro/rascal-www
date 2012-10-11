---
format: markdown
date: 2012/10/11 00:00:00
title: Manufacturing disruption
categories: rascal
---
This dramatic story is entirely true.

A few days before the Maker Faire in New York, two large boxes arrived from the assembler containing a total of 104 Rascals. I unpacked the first bubble-wrapped pack of 6 and plugged one in. Nothing. No cheery green power LEDs. Something was wrong.

On the second Rascal, one LED turned on, suggesting that the 5 V regulator was working. The second LED stayed dark, meaning that the microprocessor was not powered up. On a working Rascal, the second LED comes on while the Rascal is booting and then turns off as soon as the Linux kernel takes control of the Rascal's output pins.

I checked a few more boards and gathered some statistics on what was going wrong. Around 80% of the batch had at least one power supply failing to deliver power. At this point, late on Tuesday afternoon, I was starting to freak out-- thousands of dollars of boards with no visible defects that utterly failed to function.

The next day, I had accepted that a problem existed and that I needed to figure out what was wrong. (The hierarchy of responsibility tends to be pretty clear in one-man operations.) I measured the impedance between the power and ground buses on some of the broken Rascals. The impedance was below 1 ohm, suggesting that one of the components spanning the two buses had an internal short. On a working Rascal, the buses are spanned by enough capacitors that most ohmmeters will read a rapidly rising resistance, which is actually result of the meter charging up the capacitors. In any case, I knew that at least one component was shorting out the power circuitry.

Lacking any better alternative, I started desoldering components. First, I lifted the output leg of the 5 V voltage regulator to see if it would work when it was disconnected from whatever torturous load the rest of the Rascal was applying. I didn't realize it at the time, but the voltage regulator on this Rascal had been cooked, probably because I stupidly left the Rascal plugged in while I was trying to figure out what was amiss.

After reviewing the schematic, I started removing the regulator's output filter capacitors. When I desoldered the second one, I discovered something amazing and horrifying, pictured below. (Sorry for the bad quality-- the picture was taken by aiming a camera through a microscope eyepiece by hand. I was surprised that it worked at all.)

<img src="/img/c37-solder-bridge.jpg">

At the bottom of the picture, you can see where I did a messy job of removing a capacitor. What remained after the cap was removed was a spidery web of bridges between the two pads. After I soaked the bridges up with some solder braid, the impedance between the two buses jumped into the megaohm range.

So, a box of 86 Rascals is on the way back to the assembler to have the capacitors X-rayed and reworked as necessary. I have a few working Rascals on hand that will go up for sale soon, but I plan on releasing Beriberi, the next big Rascal software milestone, first. Once the rest of the Rascals are ready for sale, I'll advertise far and wide-- on the blog, Twitter, and the mailing list.

As usual, thanks for all the support and enthusiasm, both with this manufacturing trial and at Maker Faire.