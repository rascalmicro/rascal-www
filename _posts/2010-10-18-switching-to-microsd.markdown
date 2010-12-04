---
format: markdown
date: 2010/10/18 00:00:00
title: Adding a microSD card to the Rascal
categories: rascal, microsd, flash
draft: false
---
I've decided that it's time to get rid of the NAND flash chip on the Rascal. The new idea is that the Rascal will have a microSD card slot on it. The bootloaders and the Linux kernel will continue to reside on the serial flash, but the filesystem, which previously lived on the NAND flash, will instead live on the microSD card. This means that we can start to develop different filesystems preconfigured for different applications. If you want to switch from one configuration to another, you just swap out the microSD card and reboot.

<img src="http://rascalmicro.com/img/microsd-on-quarter.jpg">

SD cards are just NAND flash chips packaged with a memory controller. They have several advantages: the memory controller takes care of correcting errors common to NAND flash and can probably do some caching of recent data. Also, SD cards are something like 10x cheaper per byte than NAND flash (because I can't buy NAND flash in quantities of 10 million). Furthermore, there are lots of sources of standard cards; I don't have to worry about sourcing a single chip. There's also the modularity of the system-- being able to swap out the filesystem by mechanical means is just beautiful.

The disadvantage is that at a basic level, microSD cards use a 4-bit bus, while the NAND flash on the Rascal uses an 8-bit bus. Even if the clocking limit on the two buses were identical, a microSD card has to be half as fast as NAND flash, and in reality, you probably can't clock a card as fast because of the connector in the circuit. The AT91SAM9G20 MCI controller, which is what talks to the card, peaks at 25 MHz, while the NAND flash can in theory handle 50 MHz. But I suspect all of these metrics are swamped by considerations like how your data is stored. I've seen a decent embedded Linux system that took 2 seconds to serve a 20 kB web page off of an SD card, but that could could be caused by all sorts of different things-- maybe each byte was stored in a different block of memory, or something like that.

<img src="http://rascalmicro.com/img/microsd-in-socket.jpg">

Once a filesystem is loaded onto an SD card, it behaves transparently to the rest of the world, but writing a new filesystem to a card can be a dangerous process, as I learned a few years ago. I was trying to write a filesystem image to the microSD card pictured above using the Linux command "dd," which is used to copy bytes from one place to another. It's a dangerous command.

I think I typed something like:
$$code(lang=bash)
dd if=/sd-card-image.bin of=/dev/sda1
$$/code

I thought that I was copying the 256 MB filesystem image to the SD card at /dev/sdb1, but I accidentally hit *sda1* rather than *sdb1*. Unfortunately, this copied the image over the first 256 MB of my hard drive, which I believe includes valuable elements like the master boot record. At the time, I thought, "Ohhh, this could be bad," but my computer kept working, so I forgot about it.

A few weeks later, I tried to reboot my computer; it failed utterly. After lots of mucking around, but no remembering of my previous error, I ended up on the phone with Linux support at Dell. They had me run hardware diagnostics; the drive passed with no errors. Eventually, they sent me a replacement hard drive in the mail. A few hours after hanging up, I was thinking about trying a fresh install of Linux, which got me thinking about wiping the master boot record, which reminded me of the SD card incident.

In the end, I offered to return the drive to Dell, but they refused.

## Comments ##

If you want to comment on this post, use [this topic][1] on the forums.

[1]: http://rascalmicro.com/forum/viewtopic.php?f=7&t=13
