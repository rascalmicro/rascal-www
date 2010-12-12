---
format: markdown
date: 2010/11/20 00:00:00
title: Building a custom AT91 bootloader with AT91Bootstrap
categories: rascal, bootloader, at91, software
draft: false
---
Rascal development is continuing at a furious pace. Rascal 0.4, which has a cheaper, more awesome memory arrangement than previous versions, arrived from the assembler recently. I've been working on rebuilding the bootloaders properly so they work with the new memory. To do this I've had to understand some of the details of Atmel's bootloader, AT91Bootstrap. For the benefit of the internet, and for my own benefit once I pass into the shadowlands beyond the bounds of my short-term memory (next week), I thought I should record the details here.

(For those readers whose eyes are beginning to glaze over, have no fear. You don't need to know this stuff to use the Rascal. Go back to your web browsing.)

## Rascal memory setup ##

Let's start with a little background about the Rascal's memory setup.

The Rascal has four pools of memory on board. Two of them, a tiny chunk of RAM in the processor and two 32 MB external RAM chips, lose their contents when the board is unplugged. The other two are nonvolatile, i.e. they remember their contents even when powered down. One of the two nonvolatile memory elements is a microSD card. It can hold several GB of data, which is enough for an operating system and a lot of datalogging. The other is a small, simple chip called a serial flash, only 4 MB in size. (In 2010, fancy cameras take pictures that won't fit in 4 MB, so I think "small" is fair.) The serial flash holds all the code other than the filesystem that the Rascal needs to start operating-- bootloaders and the Linux kernel. This is the code that you don't want to mess with unless you know what you're doing.

The first code that gets read out of the serial flash is called AT91Bootstrap. It loads a general-purpose bootloader called U-boot, which loads, decompresses, and runs the Linux kernel. I could make it so that AT91Bootstrap loaded Linux directly, but U-boot makes things a little easier for programmers like me by letting us load new kernels through the Ethernet port, or move code around from one part of memory to another.

For reasons that I don't get, Atmel has released two different branches of AT91Bootstrap. One is the version that you find if you google "AT91Bootstrap" and [click on the first link][1]. However, for several of their more powerful processors, Atmel provides versions of AT91Bootstrap that have more code for talking to different peripherals. These expanded versions are contained within what Atmel calls the "Software Package" for each chip. For the Rascal's AT91SAM9G20, I'm building AT91Bootstrap from the [revision C software package][2]. Within that zip file, there is a smaller file called _at91bootstrap-at91sam9g20-ek-gnu.zip_ that contains AT91Bootstrap.

The documentation provided by Atmel is a little weak, containing aspiring sentences like, "By default, this array contains only one line whose all data is C precompilator defines." ("Precompilator" is almost a word in French; I think a lot of the work for the AT91 chips happens at [the Atmel office just west of Versailles, France][3] (you can just make out the Atmel logo on the sign).)

To build the bootloader, I used the [2010q1 release of the CodeSourcery arm-none-eabi toolchain][4]. The "none" means that the binary is being built for use without an operating system; the "eabi" means that the executable will use the [standard compilation conventions][5] for ARM processors.

## The build command ##

Atmel provides a peculiar build script in the software package-- even though the package is specific to the AT91SAM9G20, it builds binaries for a long list of Atmel processors. The script is aptly named "make\_all."

To build the bootloader for the Rascal, you can customize this script, but I found it easier to just copy out the command used to build the Rascal code and forget the rest.

The structure of the build command is: *make \[lots of flags to the compiler\] clean all*, which basically means "clean out the old binaries and make new ones with these options."

Some of the flags are mandatory; some are optional. The details are below.

### Mandatory ###
 * CHIP = at91sam9g20
 * BOARD = at91sam9g20-ek
 * ORIGIN = serialflash
 * DESTINATION = sdram

### Mandatory, but not necessarily on the command line ###
These flags are only given on the command line if there is only one module to load. If there is more than one module to load, you need to modify the array _tabDesc_ in boot.h.

 * BIN_SIZE -- The bootloader's main job is to copy a more powerful bootloader like U-boot somewhere useful This flag tells the bootloader how much data to read out of memory. It's OK if it's bigger than the binary.
 * FROM_ADDR -- In the Rascal, this is the address in the serial flash where the bootloader will look for U-boot.
 * DEST_ADDR -- In the Rascal, this is the address in RAM of the start of the code that will be executed when AT91Bootstrap is finished. For U-boot, this should be 0x23F00000, because that's where U-boot is expecting to be loaded. By "expecting," I mean that U-boot does not use relative addressing.

### Optional ###
 * TRACE_LEVEL = 1-5. 5 is the most verbose.

### Optional but not very interesting ###
 * BOOTNAME
 * FILE_NAME (only used for SDcard boot)
 * STR_DESCR ("optional user data")

Here's the command that I've been using for the Rascal.
$$code(lang=bash)
make CHIP=at91sam9g20   BOARD=at91sam9g20-ek   ORIGIN=serialflash   DESTINATION=sdram
BIN\_SIZE=0x30000   FROM\_ADDR=0x10000   DEST\_ADDR=0x23F00000 TRACE\_LEVEL=5 clean all
$$/code

If you don't provide a name for the output file as "BOOTNAME", one will be constructed for you from the options you've supplied. In the case of the Rascal, the auto-generated binary name will be *boot-at91sam9g20-ek-serialflash2sdram.elf* or *.bin*.

## The last step ##

Once you've compiled the program, you load it onto the processor via a JTAG pod. There are a few ways of doing this. If you just want to test the code, you can use the executable in ELF format, which can be loaded with GDB. If the code works, you'll want to copy the raw binary (not the ELF file) to the serial flash with Atmel's "boot assistant," SAM-BA.

Unfortunately, there is a catch. To make the AT91SAM9G20 acknowledge the binary as valid, it requires valid ARM interrupt vectors in the first seven 32-bit words of the binary. The compiler takes care of this for you, but there is one exception: the sixth vector. The sixth vector must contain the size of the binary in hex. (There might be a way to get the compiler to do this for you, but I don't know of one.) Thus, you have to edit the binary size with a hex editor to make the processor recognize it as a valid boot program.

## Comments ##
If you want to comment on this post, use [this post][6] on the forums.

[1]: http://www.google.com/search?q=at91bootstrap&btnI
[2]: http://www.atmel.com/dyn/resources/prod_documents/at91sam9g20-revC-ek-softpack-1.8.zip
[3]: http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=Atmel+Europe,+Montigny-le-Bretonneux,+France&sll=48.79239,2.037964&sspn=0.59349,1.83609&ie=UTF8&hq=Atmel+Europe,&hnear=Montigny-le-Bretonneux,+Yvelines,+Ile-de-France,+France&ll=48.792164,2.035904&spn=0.074187,0.229511&t=h&z=13&layer=c&cbll=48.792243,2.035943&panoid=1V_zVDQapbFPad8XBsE4Sw&cbp=12,126.27,,1,8.4
[4]: http://www.codesourcery.com/sgpp/lite/arm/portal/release1294
[5]: http://en.wikipedia.org/wiki/Application_binary_interface
[6]: http://rascalmicro.com/forum/viewtopic.php?f=7&t=15
