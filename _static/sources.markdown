## Source documents ##

The Rascal is open source hardware. This means that you are free to build off of my work, provided that you also allow me to build off of your work, as is specified in the licenses described below.

For now, the hardware is under the [Creative Commons BY-SA license][1], and the software is either GPL or BSD licensed. Some of the software source code for the bootloaders is missing below, but only because I'm changing it every day. Once we have stable releases, they'll be posted here. In the meantime, if you want sources, post something in the forums or email Brandon.

### Rascal hardware sources ###
 * Schematic diagram as [Altium .schdoc][2] or [PDF][3]
 * PCB layout as [Altium .pcbdoc][4] or [PDF][5]
 * [Gerber files][6]
 * [Bill of materials][7]

### Bootloaders ###
 * [AT91Bootstrap Project 3.0 ELF][8] for loading via JTAG
 * [AT91Bootstrap Project 3.0 binary][9] for writing into serial flash
 * [U-boot-2010.09 ELF][10] (*688 kB*) for loading via JTAG
 * [U-boot-2010.09 binary][11] (*188 kB*) for writing into serial flash
 * [Rascal fork of U-boot][12] on Github

### Linux code and source ###
 * [Linux kernel uImage][13] (*2.9 MB*) MD5 sum: 0cae4fb2cf94e9af8bfc73328eb38a1b
 * [Rascal fork of Linux kernel][14]
 * [Tarball of Linux filesystem][15] (*52 MB*) used on Rascals built November 2, 2011. MD5 sum: cd01e5103ad10de439547a0a7356b3f8
 * [Rascal fork of OpenEmbedded][16] for building an Angstrom filesystem image for a microSD card

### Mechanical drawings ###
 * Mechanical drawing of PCB as [PDF][17] (*130 kB*)
 * [Zip file of Solidworks files][18] used for drawing above

### Mirror of relevant datasheets ###
 * [Atmel AT91SAM9G20 microcontroller][30] (*12 MB*)
 * [Bel Fuse L829-1X1T-91 RJ45 jack][31] (*184 kB*)
 * [CTS 74x resistor arrays][32] (*191 kB*)
 * [JAE SJ107021 microSD card socket][33] (*138 kB*)
 * [Fox FXO-HC73 oscillator][34] (*67 kB*)
 * [Macronix MX25L3205D 4 MB serial flash][35] (*3.2 MB*)
 * [Micrel KSZ8041TL Ethernet transceiver][36] (*430 kB*)
 * [Micron MT48LCxxMxxA2 SDRAM][37] (*2.5 MB*)
 * [NXP PMBT2222 transistor][38] (*146 kB*)
 * [On Semi MC78xx regulators][39] (*290 kB*)
 * [TI TPS60500 adjustable buck charge pump][40] (*743 kB*)
 * [TI TPS71710 LDO regulator][41] (*1.1 MB*)

[1]: http://creativecommons.org/licenses/by-sa/3.0/us/
[2]: http://rascalmicro.com/files/rascal-0.4.schdoc
[3]: http://rascalmicro.com/files/rascal-0.4-schematic.pdf
[4]: http://rascalmicro.com/files/rascal-0.4.pcbdoc
[5]: http://rascalmicro.com/files/rascal-0.4-pcb.pdf
[6]: http://rascalmicro.com/files/rascal-0.4-gerbers.zip
[7]: http://rascalmicro.com/files/rascal-0.4-bom.xlsx
[8]: http://rascalmicro.com/files/boot-rascal-serialflash2sdram.elf
[9]: http://rascalmicro.com/files/boot-rascal-serialflash2sdram.bin
[10]: http://rascalmicro.com/files/u-boot.elf
[11]: http://rascalmicro.com/files/u-boot.bin
[12]: https://github.com/rascalmicro/u-boot-rascal
[13]: http://rascalmicro.com/files/linux-2.6.36-rascal-2011-11-02.bin
[14]: https://github.com/rascalmicro/linux-2.6
[15]: http://rascalmicro.com/files/rascal-filesystem-2011-11-02.tar.gz
[16]: https://github.com/rascalmicro/openembedded-rascal
[17]: http://rascalmicro.com/files/rascal-mechanical-drawing-2010-11-14.pdf
[18]: http://rascalmicro.com/files/rascal-mechanical-cad-2010-11-14.zip
[30]: http://rascalmicro.com/files/datasheets/Atmel%20AT91SAM9G20%20microcontroller.pdf
[31]: http://rascalmicro.com/files/datasheets/Bel%20Fuse%20L829-1X1T-91%20RJ45%20jack.pdf
[32]: http://rascalmicro.com/files/datasheets/CTS%2074x%20resistor%20arrays.pdf
[33]: http://rascalmicro.com/files/datasheets/JAE%20SJ107021%20microSD%20card%20socket.pdf
[34]: http://rascalmicro.com/files/datasheets/Fox%20FXO-HC73%20oscillator.pdf
[35]: http://rascalmicro.com/files/datasheets/Macronix%20MX25L3205D%204%20MB%20serial%20flash.pdf
[36]: http://rascalmicro.com/files/datasheets/Micrel%20KSZ8041TL%20Ethernet%20transceiver.pdf
[37]: http://rascalmicro.com/files/datasheets/Micron%20MT48LCxxMxxA2%20SDRAM.pdf
[38]: http://rascalmicro.com/files/datasheets/NXP%20PMBT2222%20transistor.pdf
[39]: http://rascalmicro.com/files/datasheets/On%20Semi%20MC78xx%20regulators.pdf
[40]: http://rascalmicro.com/files/datasheets/TI%20TPS60500%20adjustable%20buck%20charge%20pump.pdf
[41]: http://rascalmicro.com/files/datasheets/TI%20TPS71710%20LDO%20regulator.pdf





