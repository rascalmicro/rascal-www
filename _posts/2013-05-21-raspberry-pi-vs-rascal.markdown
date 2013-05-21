---
format: markdown
date: 2013/05/21 00:00:00
title: The Raspberry Pi vs the Rascal
categories: rascal
---

When I talk to people about the Rascal, they often ask about the differences between a Raspberry Pi and a Rascal.

Summary: if you want the cheapest possible computer, buy a Raspberry Pi. If you want to control some Arduino-style hardware from your web browser and you're a busy person, buy a Rascal.

<img src="/img/raspberry-pi-and-rascal.jpg">
##### The Raspberry Pi on the left, the Rascal on the right #####

The two boards have a lot of similarities, but a few major differences as well. Let's run through the similarities quickly.

### Similarities ###

* Both the Raspberry Pi and the Rascal run Linux.
* Both store their filesystems on SD cards.
* Both use ARM processors.
* Both have an Ethernet port (Raspberry Pi Model B only) and two USB host ports.

### Differences ###

I'll get to the specifics of the differences shortly, but let me explain what drives most of the differences: the two boards are intended for different purposes.

The Raspberry Pi is made by a nonprofit foundation in the United Kingdom for the purpose of teaching kids to program. To quote their website, "We want to see it being used by kids all over the world to learn programming. . . . Our main function is a charitable one – we’re trying to build the cheapest possible computer that provides a certain basic level of functionality . . ." The Raspberry Pi has connections for a monitor and keyboard.

The Rascal came from my work as an embedded systems engineer. I was frustrated that I couldn't buy an embedded Linux board that was preconfigured for controlling Arduino-style hardware from the web. I designed the Rascal so that I could plug Arduino shields directly into it, and I wrote the software using a modern web framework so that I wouldn't have to set that stuff up every time I started a new project. Then I added a code editor and wrote a Python library to make it even easier. The Rascal doesn't use a monitor-- you interact with it through your web browser.

Here's a summary of the differences.

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr><th>&nbsp;</th><th>Raspberry Pi</th><th>Rascal</th></tr>
    </thead>
    <tbody>
        <tr><td>CPU</td><td>Broadcom BCM2835</td><td>Atmel AT91SAM9G20</td></tr>
        <tr><td>ARM processor</td><td>ARM1176JZF-S @ 700 MHz</td><td>ARM926EJ/S @ 400 MHz</td></tr>
        <tr><td>Graphics processor</td><td>VideoCore IV</td><td>None</td></tr>
        <tr><td>RAM</td><td>512 MB</td><td>64 MB</td></tr>
        <tr><td>Video</td><td>HDMI and analog</td><td>None</td></tr>
        <tr><td>Audio</td><td>3.5 mm</td><td>Pins for I<sup>2</sup>S</td></tr>
        <tr><td>Open source software</td><td>Some</td><td>All</td></tr>
        <tr><td>Open source hardware</td><td>No</td><td>Yes</td></tr>
        <tr><td>Hardware interface</td><td>26 male pins, plus 23 holes you can solder to</td><td>Arduino headers</td></tr>
        <tr><td>Price (with SD card and power supply)</td><td>$52.66</td><td>$199</td></tr>
        <tr><td>Webserver</td><td>None, but you can install one</td><td>Nginx</td></tr>
        <tr><td>Python WSGI server</td><td>None, but you can install one</td><td>uWSGI</td></tr>
        <tr><td>Code editor</td><td>None, but you can install one</td><td>Red</td></tr>
        <tr><td>Web hardware API</td><td>None</td><td>Pytronics/Rascal API</td></tr>
    </tbody>
</table>

### Wait, if the Rascal has a slower processor, why would I pay more for it? ###

In the end, the decision comes down to the value of your time. Almost anything you could do with a Rascal, you could eventually do with a Raspberry Pi, if you're willing to learn a lot of Linux programming. If you're a Linux-savvy person just playing around with embedded computers, and tweaking the Linux kernel sounds interesting, you can save some money with the Raspberry Pi. If you're new to embedded computers or you just need to get something done quickly, I think the extra cost of the Rascal is worth it.
