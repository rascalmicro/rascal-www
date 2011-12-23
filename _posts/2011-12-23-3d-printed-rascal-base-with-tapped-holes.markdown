---
format: markdown
date: 2011/12/23 00:00:00
title: 3D printed Rascal base with tapped holes
categories: rascal
---
If you want to mount the Rascal in a metal enclosure, you need a way to hold the board away from the enclosure, so the electronics don't get shorted out. For most of the history of electronics, this sort of task has been accomplished using small, annoying posts called "standoffs." They work, but they're more expensive and fiddly than you'd like.

Now that consumer-grade 3D printers like the [Makerbot][1] Thing-O-Matic are available, printing custom brackets to hold your circuit board is plausible. I've taken a first cut at the design and uploaded the [source files][2] to Thingiverse. If you'd like some brackets for your Rascal and you have access to a 3D printer, you're welcome to download the files and print out some brackets. The print time is around 8 minutes per bracket. They'll work with either #4-40 or M3 fasteners. If you're not sure, use M3 because the metric system is better.

If you'd like to try this out, but you can't find a 3D printer, you might try checking with your local hackerspace, which you can find on the [Hackerspaces.org][3] map.

<img src="/img/3d-printed-rascal-bases.jpg" alt="4 handsome pieces of plastic with small fasteners protruding">

## Drilling and tapping 3D printed brackets ##

The holes in the brackets won't have threads in them straight out of the printer. To make  threads in the plastic, you need to drill out the holes to the right diameter and then use a tap to cut the threads.

It would be nice if you didn't need to predrill the holes before tapping. In the model, the holes are set to 2.26 mm in diameter, which theoretically shouldn't need predrilling, but with parts printed on my local Thingomatic, the actual diameter was smaller, so predrilling was required.

### M3 fasteners ###

For M3 fasteners, I use a 0.100" drill (AKA drill size #39). You could certainly use a 2.5 mm drill. I suspect that a 3/32" drill would also work. For mounting the Rascal, a M3 x 6 stainless steel socket head cap screw, such as McMaster part number 91292A111, works great.

### #4-40 fasteners ###

For #4-40 fasteners, I use a 0.089" drill (AKA drill size #43). I suspect that a 3/32" drill would also work. For mounting the Rascal, a #4-40 x 1/4" stainless steel socket head cap screw, such as McMaster part number 92196A106, works great.

[1]: http://www.makerbot.com/
[2]: http://www.thingiverse.com/thing:14894
[3]: http://hackerspaces.org/wiki/List_of_Hacker_Spaces