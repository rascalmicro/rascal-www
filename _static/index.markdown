# Documentation and tutorials for the Rascal #

The Rascal is a small, open-source computer designed for connecting sensors, motors, and whatever else you can build to the internet. It's about 5 cm x 10 cm (2 inches by 4 inches).

## Hardware summary ##

The Rascal is based around the Atmel AT91SAM9G20 microprocessor. This is an ARM processor from the ARM926EJ/S family. It's similar to, though slightly less powerful than, the ARM processors used in many smartphones.

<img src="/img/pinout.png" alt="What's on each pin of the connectors on the Rascal">

## Software summary ##

The Rascal runs the Linux operating system. If you're planning on using the Rascal in conventional ways, you won't need to mess with any of this software-- it's already installed on your Rascal when you get it. But, if you want to do something weird with the Rascal, you might want to change some of the details of how the software works, so we provide the code for tweaking.

If you want more details about how the code fits together, take a look at the [software guts][37] page. If you are one of the beta testers who wants to build a new system image, look at the [build guide][38]. Note that the build guide will be outdated soon, when we pull the building of the Linux kernel and the bootloaders into OpenEmbedded.

## Source documents ##

The Rascal is open hardware. This means that you are free to build off of my work, provided that you also allow me to build off of your work, as is specified in the licenses described below.

For now, the hardware is under the [Creative Commons BY-SA license][33], and the software is either GPL or BSD licensed. Some of the software source code for the bootloaders is missing below, but only because I'm changing it every day. Once we have stable releases, they'll be posted here. In the meantime, if you want sources, post something in the forums or email Brandon.

### Rascal 0.4 hardware sources ###
 * Schematic diagram as [Altium .schdoc][1] or [PDF][31]
 * PCB layout as [Altium .pcbdoc][2] or [PDF][32]
 * [Gerber files][34]
 * [Bill of materials][35]

### Bootloaders ###
 * [AT91Bootstrap Project 3.0 ELF][4] for loading via JTAG
 * [AT91Bootstrap Project 3.0 binary][5] for writing into serial flash

*For Rascal 0.3*

 * [U-boot-2010.09 ELF][6] (*717 kB*) for loading via JTAG
 * [U-boot-2010.09 binary][7] (*180 kB*) for writing into serial flash

*For Rascal 0.4* (different Ethernet pinout from 0.3)

 * [U-boot-2010.09 ELF][8] (*688 kB*) for loading via JTAG
 * [U-boot-2010.09 binary][9] (*188 kB*) for writing into serial flash
 * [Rascal fork of U-boot][28] on Github

### Linux code and source for all Rascal versions ###
 * [Linux kernel 2.6.30 binary][10] (*1.7 MB*), [patches][11] (*377 kB*), and [config file][12] (*37 kB*) for [vanilla 2.6.30 kernel][13] (*57 MB*)
 * [Linux kernel 2.6.36 binary][27] (*1.9 MB*), built from [the Rascal fork of the Linux kernel][29] (sorry this is a little sloppy at present)
 * [Angstrom Linux 2008.1 JFFS2 filesystem image][14] (*20.8 MB*)
 * [Rascal fork of OpenEmbedded][30] for building an Angstrom filesystem image for a microSD card

### Mirror of relevant datasheets ###
 * [Atmel AT91SAM9G20 microcontroller][15] (*12 MB*)
 * [Bel Fuse L829-1X1T-91 RJ45 jack][16] (*184 kB*)
 * [CTS 74x resistor arrays][17] (*191 kB*)
 * [JAE SJ107021 microSD card socket][18] (*138 kB*)
 * [Fox FXO-HC73 oscillator][36] (*67 kB*)
 * [Macronix MX25L3205D 4 MB serial flash][19] (*3.2 MB*)
 * [Micrel KSZ8041TL Ethernet transceiver][20] (*430 kB*)
 * [Micron MT48LCxxMxxA2 SDRAM][21] (*2.5 MB*)
 * [NXP PMBT2222 transistor][22] (*146 kB*)
 * [On Semi MC78xx regulators][23] (*290 kB*)
 * [TI TPS60500 adjustable buck charge pump][24] (*743 kB*)
 * [TI TPS71710 LDO regulator][25] (*1.1 MB*)

[1]: http://rascalmicro.com/files/rascal-0.4/rascal-0.4.schdoc
[2]: http://rascalmicro.com/files/rascal-0.4/rascal-0.4.pcbdoc
[3]: http://rascalmicro.com/files/rascal-0.2/rascal-0.2-gerbers.zip
[4]: http://rascalmicro.com/files/rascal-0.x/boot-rascal-serialflash2sdram.elf
[5]: http://rascalmicro.com/files/rascal-0.x/boot-rascal-serialflash2sdram.bin
[6]: http://rascalmicro.com/files/rascal-0.3/u-boot.elf
[7]: http://rascalmicro.com/files/rascal-0.3/u-boot.bin
[8]: http://rascalmicro.com/files/rascal-0.4/u-boot.elf
[9]: http://rascalmicro.com/files/rascal-0.4/u-boot.bin
[10]: http://rascalmicro.com/files/rascal-0.x/linux-2.6.30.bin
[11]: http://rascalmicro.com/files/rascal-0.x/rascal-linux-2.6.30-patchset.zip
[12]: http://rascalmicro.com/files/rascal-0.x/rascal_defconfig
[13]: http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.30.tar.bz2
[14]: http://rascalmicro.com/files/rascal-0.x/angstrom.jffs2
[15]: http://rascalmicro.com/files/datasheets/Atmel%20AT91SAM9G20%20microcontroller.pdf
[16]: http://rascalmicro.com/files/datasheets/Bel%20Fuse%20L829-1X1T-91%20RJ45%20jack.pdf
[17]: http://rascalmicro.com/files/datasheets/CTS%2074x%20resistor%20arrays.pdf
[18]: http://rascalmicro.com/files/datasheets/JAE%20SJ107021%20microSD%20card%20socket.pdf
[19]: http://rascalmicro.com/files/datasheets/Macronix%20MX25L3205D%204%20MB%20serial%20flash.pdf
[20]: http://rascalmicro.com/files/datasheets/Micrel%20KSZ8041TL%20Ethernet%20transceiver.pdf
[21]: http://rascalmicro.com/files/datasheets/Micron%20MT48LCxxMxxA2%20SDRAM.pdf
[22]: http://rascalmicro.com/files/datasheets/NXP%20PMBT2222%20transistor.pdf
[23]: http://rascalmicro.com/files/datasheets/On%20Semi%20MC78xx%20regulators.pdf
[24]: http://rascalmicro.com/files/datasheets/TI%20TPS60500%20adjustable%20buck%20charge%20pump.pdf
[25]: http://rascalmicro.com/files/datasheets/TI%20TPS71710%20LDO%20regulator.pdf
[26]: http://rascalmicro.com/files/rascal-0.3/at91bootstrap.bin
[27]: http://rascalmicro.com/files/rascal-0.x/linux-2.6.36.bin
[28]: https://github.com/rascalmicro/u-boot-rascal
[29]: https://github.com/rascalmicro/linux-2.6
[30]: https://github.com/rascalmicro/openembedded-rascal
[31]: http://rascalmicro.com/files/rascal-0.4/rascal-0.4-schematic.pdf
[32]: http://rascalmicro.com/files/rascal-0.4/rascal-0.4-pcb.pdf
[33]: http://creativecommons.org/licenses/by-sa/3.0/us/
[34]: http://rascalmicro.com/files/rascal-0.4/rascal-0.4-gerbers.zip
[35]: http://rascalmicro.com/files/rascal-0.4/rascal-0.4-bom.xlsx
[36]: http://rascalmicro.com/files/datasheets/Fox%20FXO-HC73%20oscillator.pdf
[37]: http://rascalmicro.com/docs/software-guts.html
[38]: http://rascalmicro.com/docs/build-guide.html
