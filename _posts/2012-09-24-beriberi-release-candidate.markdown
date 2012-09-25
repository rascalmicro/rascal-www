---
format: markdown
date: 2012/09/14 00:00:00
title: Preparing to inflict Beriberi
categories: rascal
---

There's a new batch of Rascals at the assembler right now. When they're ready, I'll be putting new, better software on them. In the Rascal tradition of alphabetized ailments, the new release will be called "Beriberi." (The last release was "Anthrax;" up next is "Cooties.")

If you have an older Rascal, you can download the new software. Beriberi should be compatible with all existing Rascals, though this release candidate has only been tested on Rascal 1.2's. The point of release candidates is to test the software before we send it out to newly-minted Rascal zealots, so please let us know if you run into difficulties with Anthrax.

More details are on the [Beriberi release page][3]; a few highlights are summarized below.

### Wireless connections via USB ###

Beriberi comes with precompiled wireless drivers that can be loaded into the Rascal kernel automatically when the Rascal boots. The process is still less polished than we'd like, but at least it works. Currently, two wireless adapters are supported: the Iogear GWU523 and the Edimax EW-7811UN. The Edimax is cheaper and smaller, but also a bit flakier-- it's worth the few extra bucks for the Iogear if it's available in your country. In theory, other adapters that use the zd1211rw or 8192cu driver should work too. If you get an adapter working, please drop brandon at rascalmicro dot com and email and share the details.

### Useful libraries ###

A lot of the libraries on the Rascal have been updated, but there are also a few new ones. One of the more exciting ones is the OpenCV library. Here's an image of a Rascal that was run through an edge detection algorithm found in OpenCV.

<img src="/img/rascal-laplace-edge-detection.png">

[Templeton Automation][5] has been using the Rascal for benchmarking image processing performance on an ARM processor for their [touch table project][4]

### Controlling SPI port from Python ###

Beriberi also contains a new version of [Pytronics][6], the Python library for controlling the Rascal hardware. The new version has added functions for talking to the SPI port on the Rascal. (SPI is a digital communication protocol similar to I2C or RS-232, but faster. The latter two top out at a few hundred kbps, while SPI can reach the Mbps range. (Someday, I'll write a blog post that explains the tradeoffs between the different protocols that the Rascal uses, but today is not that day.)) The Python code still needs a lot of testing. Sending data and adjusting transmission speed is working well, but receiving data and full duplex communication still need to be written.

### The bootloader now saves settings ###

New Rascal user [Dave Hylands][1] contributed a [patch][2] to the Rascal's bootloader setup that allows the Rascal to store boot settings back to the serial flash chip. This vastly increases the customizability of the Rascal, as you can now configure it to load a custom kernel over the network. Previously, you could make the Rascal load a custom kernel, but only by interrupting the boot process manually on a serial console.

Being able to load a custom kernel is a big deal because it means that the Rascal can learn to support more hardware after it leaves the factory (where "factory" is a euphemism for this table I'm sitting at).

The real release of Beriberi will occur in a few weeks; the first release candidate is up on the [Beriberi release page][7] now.

[1]: http://davehylands.com/
[2]: https://github.com/rascalmicro/u-boot-rascal/commit/450ab49bf8346f54ccad7402b3b3f2194fb28ea1
[3]: /docs/release-beriberi.html
[4]: http://www.kickstarter.com/projects/472263971/playsurface-the-affordable-multi-touch-computing-t
[5]: http://templemanautomation.com/
[6]: https://github.com/rascalmicro/pytronics
[7]: /docs/release-beriberi.html