## Source documents ##

The Rascal is open source hardware. This means that you are free to build off of my work, provided that you also allow me to build off of your work, as is specified in the licenses described below.

For now, the hardware is under the [Creative Commons BY-SA license][1], and all of the Rascal-Micro-written code is under the GPL. The remainder of the code is GPL or BSD licensed, with a few other open source licenses sprinkled in. If you're looking for something but can't find it, post something in the forums or email Brandon.

### Rascal hardware sources ###
 * Schematic diagram as [Altium .schdoc][2] or [PDF][3]
 * PCB layout as [Altium .pcbdoc][4] or [PDF][5]

### Rascal software releases ###
 * [Software release: <unnamed beta>][15] (*52 MB*) used on Rascals built November 2, 2011. MD5 sum: cd01e5103ad10de439547a0a7356b3f8
 * [Software release: Anthrax][42] (*103 MB*) used on Rascals sold before September 1, 2012
 * [Software release: Beriberi][43] (*136 MB*) used on Rascals sold after September 1, 2012

### Bootloaders ###
 * [AT91Bootstrap Project 3.0 ELF][8] for loading via JTAG
 * [AT91Bootstrap Project 3.0 binary][9] for writing into serial flash
 * [U-boot-2010.09 ELF][10] (*688 kB*) for loading via JTAG
 * [U-boot-2010.09 binary][11] (*188 kB*) for writing into serial flash
 * [Rascal fork of U-boot][12] on Github

### Linux code and source ###
 * [Linux kernel uImage][13] (*2.9 MB*) MD5 sum: 0cae4fb2cf94e9af8bfc73328eb38a1b
 * [Rascal fork of Linux kernel][14]
 * [Rascal fork of OpenEmbedded][16] for building an Angstrom filesystem image for a microSD card
 
### Mechanical drawings ###
 * Mechanical drawing of PCB (version 1.2) as [PDF][17] (*130 kB*)
 * [Zip file of Solidworks files][18] used for drawing above

### Mirror of relevant datasheets ###
 * [Atmel AT91SAM9G20 microcontroller][30] (*12 MB*)
 * [Bel Fuse L829-1X1T-91 RJ45 jack][31] (*184 kB*)
 * [CTS 74x resistor arrays][32] (*191 kB*)
 * [FCI dual USB port][29] (*276 kB*)
 * [Fox FXO-HC73 oscillator][34] (*67 kB*)
 * [JAE SJ107021 microSD card socket][33] (*138 kB*)
 * [Macronix MX25L3205D 4 MB serial flash][35] (*3.2 MB*)
 * [Micrel KSZ8051RNL Ethernet transceiver][36] (*569 kB*)
 * [Micron MT48LCxxMxxA2 SDRAM][37] (*2.5 MB*)
 * [NXP PMBT2222 transistor][38] (*146 kB*)
 * [On Semi MC78xx regulators][39] (*290 kB*)
 * [TI TPS60500 adjustable buck charge pump][40] (*743 kB*)
 * [TI TPS71710 LDO regulator][41] (*1.1 MB*)

[1]: http://creativecommons.org/licenses/by-sa/3.0/us/
[2]: /files/rascal-1.2.schdoc
[3]: /files/rascal-1.2-schematic.pdf
[4]: /files/rascal-1.2.pcbdoc
[5]: /files/rascal-1.2-pcb.pdf
[6]: /files/rascal-0.4-gerbers.zip
[7]: /files/rascal-0.4-bom.xlsx
[8]: /files/boot-rascal-serialflash2sdram.elf
[9]: /files/boot-rascal-serialflash2sdram.bin
[10]: /files/u-boot.elf
[11]: /files/u-boot.bin
[12]: https://github.com/rascalmicro/u-boot-rascal
[13]: /files/linux-2.6.36-rascal-2011-11-02.bin
[14]: https://github.com/rascalmicro/linux-2.6
[15]: /files/rascal-filesystem-2011-11-02.tar.gz
[16]: https://github.com/rascalmicro/openembedded-rascal
[17]: /files/rascal-mechanical-drawing-2012-05-30.pdf
[18]: /files/rascal-mechanical-cad-2012-05-30.zip
[29]: /files/datasheets/FCI%20dual%20USB%20port.pdf
[30]: /files/datasheets/Atmel%20AT91SAM9G20%20microcontroller.pdf
[31]: /files/datasheets/Bel%20Fuse%20L829-1X1T-91%20RJ45%20jack.pdf
[32]: /files/datasheets/CTS%2074x%20resistor%20arrays.pdf
[33]: /files/datasheets/JAE%20SJ107021%20microSD%20card%20socket.pdf
[34]: /files/datasheets/Fox%20FXO-HC73%20oscillator.pdf
[35]: /files/datasheets/Macronix%20MX25L3205D%204%20MB%20serial%20flash.pdf
[36]: /files/datasheets/Micrel%20KSZ8051RNL%20Ethernet%20transceiver.pdf
[37]: /files/datasheets/Micron%20MT48LCxxMxxA2%20SDRAM.pdf
[38]: /files/datasheets/NXP%20PMBT2222%20transistor.pdf
[39]: /files/datasheets/On%20Semi%20MC78xx%20regulators.pdf
[40]: /files/datasheets/TI%20TPS60500%20adjustable%20buck%20charge%20pump.pdf
[41]: /files/datasheets/TI%20TPS71710%20LDO%20regulator.pdf
[42]: /docs/release-anthrax.html
[43]: /docs/release-beriberi.html





