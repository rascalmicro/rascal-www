# Documentation and tutorials for the Rascal #

The Rascal is a small, open-source computer designed for connecting sensors, motors, and whatever else you can build to the internet. It's about 5 cm x 10 cm (2 inches by 4 inches).

## Source documents ##

### Rascal 0.2 ###
 * [Schematic diagram][1]
 * [PCB layout][2]

## Hardware summary ##

The Rascal is based around the Atmel AT91SAM9G20 microprocessor. This is an ARM processor from the ARM926EJ/S family. It's similar, though slightly less powerful, to the ARM processors used in many smartphones.

## Software summary ##

The Rascal runs the Linux operating system. If you're planning on using the Rascal in conventional ways, you won't need any of this software-- it's already installed on your Rascal when you get it. But, if you want to do something weird with the Rascal, you might want to change some of the details of how the software works, so we provide the code for tweaking. (At this point, the source code for the Angstrom Linux filesystem image is not included, as we're using the stock pre-compiled binary built by Atmel, who make the AT91 processors.)

### Rascal 0.2 code ###
 * [AT91Bootstrap 1.16 ELF binary][4] (*29 kB*) and [source code][5] (*86 kB*) for booting U-boot from SDRAM
 * [AT91Bootstrap 1.16 ELF binary][6] (*29 kB*) and [source code][7] (*86 kB*) for booting U-boot from Flash
 * [U-boot 2010.06 bootloader ELF binary][8] (*717 kB*) and [source code][9] (*17.6 MB*) for loading Linux
 * [Linux kernel 2.6.30 binary][10] (*1.7 MB*), [patches][11] (*377 kB*), and [config file][12] (*37 kB*) for [vanilla 2.6.30 kernel][13] (*57 MB*)
 * [Angstrom Linux 2008.1 JFFS2 filesystem image][14] (*20.8 MB*)

[1]: http://rascalmicro.com/files/rascal-0.2/rascal-0.2-schematic.pdf
[2]: http://rascalmicro.com/files/rascal-0.2/rascal-0.2-pcb.pdf
[3]: http://rascalmicro.com/files/rascal-0.2/rascal-0.2-gerbers.zip
[4]: http://rascalmicro.com/files/rascal-0.2/rascal-no-nand-read.elf
[5]: http://rascalmicro.com/files/rascal-0.2/rascal-at91bootstrap-no-nand-read.zip
[6]: http://rascalmicro.com/files/rascal-0.2/rascal-read-flash.elf
[7]: http://rascalmicro.com/files/rascal-0.2/rascal-at91bootstrap-read-flash.zip
[8]: http://rascalmicro.com/files/rascal-0.2/u-boot
[9]: http://rascalmicro.com/files/rascal-0.2/rascal-u-boot-2010.06.zip
[10]: http://rascalmicro.com/files/rascal-0.2/linux-2.6.30.bin
[11]: http://rascalmicro.com/files/rascal-0.2/rascal-linux-2.6.30-patchset.zip
[12]: http://rascalmicro.com/files/rascal-0.2/rascal_defconfig
[13]: http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.30.tar.bz2
[14]: http://rascalmicro.com/files/rascal-0.2/angstrom.jffs2
