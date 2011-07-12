# Documentation and tutorials for the Rascal #

The Rascal is a small, open-source computer designed for connecting sensors, motors, and whatever else you can build to the internet. It's about 5 cm x 10 cm (2 inches by 4 inches).

## Hardware summary ##

The Rascal is based around the Atmel AT91SAM9G20 microprocessor. This is an ARM processor from the ARM926EJ/S family. It's similar to, though slightly less powerful than, the ARM processors used in many smartphones.

<img src="/img/pinout.png" alt="What's on each pin of the connectors on the Rascal">

## Software summary ##

The Rascal runs the Linux operating system. If you're planning on using the Rascal in conventional ways, you won't need to mess with any of this software-- it's already installed on your Rascal when you get it. But, if you want to do something weird with the Rascal, you might want to change some of the details of how the software works, so we provide the code for tweaking.

If you want more details about how the code fits together, take a look at the [software guts][1] page. If you are one of the beta testers who wants to build a new system image, look at the [build guide][2]. Note that the build guide will be outdated soon, when we pull the building of the Linux kernel and the bootloaders into OpenEmbedded.

## Hardware and software sources ##

All of the Rascal hardware and software is open source. For more details, check the [sources][3] page.

[1]: http://rascalmicro.com/docs/software-guts.html
[2]: http://rascalmicro.com/docs/build-guide.html
[3]: http://rascalmicro.com/docs/sources.html
