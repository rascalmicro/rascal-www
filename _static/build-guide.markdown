Note that the build guide will be outdated soon, when we pull the building of the Linux kernel and the bootloaders into OpenEmbedded.

## Building the Rascal code ##

If you're particularly enthusiastic, and you have access to a computer that can run Linux (perhaps in a VM), you can build all of the code for the Rascal yourself. The rest of this page assumes you're using Linux. (It's probably possible on Windows or OS X. All you need is a compiler that can generate code for the ARM architecture. For Windows, a good start would be the free CodeSourcery Lite toolchain.)

The code is stored in [Git repositories][5] on Github.com. Before you try building anything, you'll want to understand the basic layout of the software on the Rascal. Take a look at the Git repositories and read over where all the code belongs on the Rascal, as detailed on the [software guts][6] page.

### Software setup ###

First, you need a compiler (or possibly two) and a few related build tools. The primary bootloader requires a compiler (arm-none-eabi-gcc) that can run on a bare processor; the rest of the code uses the Linux ABI, so it uses a different version of GCC (arm-linux-gcc). The installations are not particularly arduous; installing both compilers is fine.

For the first compiler, you'll need a tarball from CodeSourcery. For the second compiler, you'll need to install the [Embedded Linux Development Kit][4], which is a precompiled collection of build tools--a compiler (GCC), make, and so forth-- maintained by Denx, the folks who make U-boot. You'll also need to install the source code management software [git][8]. Strictly speaking, you could get by without git, but git simplifies the instructions, and it's a great tool worth learning.

### Installing the CodeSourcery toolchain ###

To build the bootloader, use the [2010q1 release of the CodeSourcery arm-none-eabi toolchain][13]. The "none" means that the binary is being built for use without an operating system; the "eabi" means that the executable will use the [standard compilation conventions][14] for ARM processors.

Unpack the tools where you like; I've put them in /opt/cs, which generally requires root privileges. You can put them elsewhere if you prefer.
$$code(lang=bash)
cd /opt
sudo wget http://www.codesourcery.com/sgpp/lite/arm/portal/package6493/public/arm-none-eabi/arm-2010q1-188-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
sudo tar xjvf arm-2010q1-188-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
sudo mv arm-2010q1 /opt/cs
sudo rm arm-2010q1-188-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
$$/code

### Installing the ELDK build tools on Linux ###
The ELDK uses its own copy of the Redhat Package Manager (RPM) to install itself. The simplest approach is to burn a copy of the 4.2 release [arm-2008-11-24.iso][12] to CD and install from that. If you know how, you could also mount the .iso file directly and install from that.

*Install the ELDK*
$$code(lang=bash)
cd /opt
sudo mkdir eldk
sudo chmod a+rwx /opt/eldk/
cd /media/arm-2008-11-24/
./install -d /opt/eldk arm
Do you really want to install into /opt/eldk directory[y/n]?: y
Creating directories
Done
Installing cross RPMs
Preparing...                ########################################### [100%]
   1:rpm                    ########################################### [100%]
Preparing...                ########################################### [100%]
   1:rpm-build              ########################################### [100%]
...
<middle snipped out>
...
Preparing...                ########################################### [100%]
   1:ppp-arm_trg            ########################################### [100%]
Done
$$/code

### Installing git ###

Next, install git. You might also want a graphical Git client, but to build the code, you only need two git commands (clone and checkout), so it's not required. Installing git is a straightforward process by now, and the fine people at Github have produced a series of guides that explain how to do it.

 * [Installing git on Ubuntu Linux][9]
 * [Installing git on OS X][10]
 * [Installing git on Windows][11]

### Test your tools ###

After installation, you need to set a few environment variables to make sure your OS can find your build tools. On Linux, these commands will do the trick, assuming you installed the ELDK to /opt/eldk and the CodeSourcery toolchain to /opt/cs. 
$$code(lang=bash)
export CROSS_COMPILE=arm-linux-
PATH=$PATH:/opt/eldk/usr/bin:/opt/eldk/bin:/opt/cs/bin
$$/code

Now you should be able to test your ARM compiler and git. Here's what successful tests look like.

*Check that git is installed*
$$code(lang=bash)
brandon@milo:~$ git --version
git version 1.7.1 # You don't necessarily need the same version of git.
$$/code

*Check that arm-linux-gcc is installed*
$$code(lang=bash)
brandon@milo:~$ which arm-linux-gcc
/opt/eldk/usr/bin/arm-linux-gcc
$$/code

*Check that cross-compiling will work*
$$code(lang=bash)
brandon@milo:~$ eval ${CROSS_COMPILE}gcc --version
arm-linux-gcc (GCC) 4.2.2
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
$$/code

*Check that the CodeSourcery tools are installed*
$$code(lang=bash)
brandon@milo:~$ which arm-none-eabi-gcc
/opt/cs/bin/arm-none-eabi-gcc
$$/code

### Building AT91Bootstrap, the primary bootloader ###
You need to have the CodeSourcery tools on your PATH.

*Download the code*
$$code(lang=bash)
git clone git://github.com/rascalmicro/at91bootstrap-rascal.git
cd at91bootstrap-rascal
git checkout rascal # Switches to the Rascal branch
$$/code

Atmel provides a peculiar build script in the software package-- even though the package is specific to the AT91SAM9G20, it builds binaries for a long list of Atmel processors. The script is aptly named "make_all." To build the bootloader for the Rascal, you can customize this script, but I found it easier to just copy out the command used to build the Rascal code and forget the rest. The structure of the build command is: *make [lots of flags to the compiler] clean all*, which basically means "clean out the old binaries and make new ones with these options."

*Build the code*
$$code(lang=bash)
cd at91bootstrap
make CHIP=at91sam9g20 BOARD=at91sam9g20-ek ORIGIN=serialflash DESTINATION=sdram \\
BIN_SIZE=0x30000 FROM_ADDR=0x10000 DEST_ADDR=0x23F00000 TRACE_LEVEL=5 clean all
$$/code

The build should take just a minute or two. If this works, you'll find the binary for loading onto the serial flash with SAM-BA at at91bootstrap-rascal/at91bootstrap/bin/boot-at91sam9g20-ek-serialflash2sdram.bin. For executing the code in RAM with JTAG, you'll want to use at91bootstrap-rascal/at91bootstrap/bin/boot-at91sam9g20-ek-serialflash2sdram.elf instead.

### Building U-boot, the secondary bootloader ###
You need to have $PATH and $CROSS_COMPILE defined from the ELDK install above.

*Download the code*
$$code(lang=bash)
git clone git://github.com/rascalmicro/u-boot-rascal.git
cd u-boot-rascal
git checkout rascal # switches to the Rascal branch
$$/code

*Build the code*
$$code(lang=bash)
make distclean
make rascal_config
make all
$$/code

The build should take 1-10 minutes, depending on your build computer. If the build works, you'll find the binary for loading onto the serial flash with SAM-BA in u-boot-rascal/u-boot.bin. For executing the code in RAM with JTAG, you'll want to use u-boot-rascal/u-boot, which is actually an ELF file.

### Building the Linux kernel ###
You need to have $PATH and $CROSS_COMPILE defined from the ELDK install above.

*Download the code*
$$code(lang=bash)
git clone git://github.com/rascalmicro/linux-2.6.git
cd linux-2.6
git checkout rascal # Switches to the Rascal branch
$$/code

*Build the code*
$$code(lang=bash)
make ARCH=arm uImage # Note that case matters here. "arch=ARM" won't work.
$$/code

If the toolchain builds the kernel successfully, you'll find the kernel image at arch/arm/boot/uImage.

### Building OpenEmbedded filesystem image ###

*Install some software on Ubuntu Linux*
$$code(lang=bash)
sudo apt-get install build-essential chrpath cvs diffstat gawk git libglu1-mesa-dev libgl1-mesa-dev libsdl1.2-dev subversion texinfo texi2html
$$/code

*Download the Rascal fork of the OpenEmbedded code and Bitbake*
$$code(lang=bash)
git clone git://github.com/rascalmicro/openembedded-rascal.git
cd openembedded-rascal
git checkout rascal # Switches to the Rascal branch
git clone git://openembedded.org/bitbake.git # Downloads Bitbake inside OpenEmbedded directory
$$/code

(Will need to do 'sudo ln -s i386-linux-gnu/ i686-linux-gnu' if on x86 with Ubuntu 11.04+.) 

*Build the code*
$$code(lang=bash)
source env.sh # Sets some environment variables, like BBPATH
bitbake --version # Tests that the bitbake to be called is version 1.10.2 or higher.
bitbake rascal-image
$$/code

## Loading code onto the Rascal ##

### Hardware setup ###
For development, you need 4 connections to the Rascal.

1. Power: any DC power supply with a voltage in the 7.5-15 V range with a center-positive, 2.1 mm barrel connector should work. Supplies that work with the Arduino will also work with the Rascal. 

2. Serial: when the Rascal boots, it sends a stream of messages out a serial port to help you with debugging. There are a few ways to connect to this; the easiest is probably connecting the debug serial port to a PC running a terminal program like Kermit with a [Sparkfun FT232R breakout board][1] and a USB cable. You could also use a [Bus Pirate][2], a [Rascal Developer's Shield][3], or a MAX232 chip on a breadboard and a serial cable.

3. Ethernet: strictly speaking, you don't actually need this for development, but it's the quickest way to load a kernel onto the board at boot, which is convenient when you're testing new kernels.

4. JTAG: You also don't *really* need JTAG, but it makes writing new code into the serial flash less risky. You can, in theory, use U-boot to rewrite the serial flash, but if you screw it up, only a JTAG connection can fix the problem. JTAG is also great for debugging, as it can pause the processor while it's running. The only disadvantage to JTAG is the cost-- it requires a Segger JTAG pod, plus a special adapter to connect to the Secret JTAG Port on the bottom of the Rascal.

I'll document the setup that I'm using, but it's not optimal, as I'm using two computers, and the GDB server is a little clumsy. But, it's all I've been able to get to work so far.
The first machine is running Windows 7, but it could in theory be running Linux or Windows XP. The following software is installed on it:

 * The drivers for the Atmel SAM-ICE JTAG pod
 * Segger J-Link GDB server
 * All of the binaries that will be loaded via JTAG, namely AT91Bootstrap and U-boot

The GDB server talks to the Rascal through the JTAG pod, which is plugged into one of the Windows machine's USB ports and into the Rascal's JTAG connector. The server gets its commands from a GDB client, which I was running on a Linux machine, but it could be anywhere.

The second machine is running Ubuntu Linux 10.04. The following software is installed on it:

 * GDB 7.1-ubuntu debugger (default version for Ubuntu 10.04)
 * Kermit 8.0.211 terminal emulator (default version for Ubuntu 10.04)
 * Tftpd-hpa TFTP server (default version for Ubuntu 10.04)

### Loading the Linux kernel via TFTP ###

You can use U-boot to load the Linux kernel via TFTP. The address 0x2200 0000 is arbitrary-- RAM starts at 0x2000 0000. I don't know where U-boot resides, but 0x2200 0000 is safe, at least for a 1.7 MB kernel.
$$code(lang=bash)
U-Boot> tftpboot 0x22000000 linux-2.6.30.bin
macb0: Starting autonegotiation...
macb0: Autonegotiation complete
macb0: link up, 100Mbps full-duplex (lpa: 0xcde1)
Using macb0 device
TFTP from server 192.168.1.57; our IP address is 192.168.1.20
Filename 'linux-2.6.30.bin'.
Load address: 0x22000000
Loading: #####################################
done
Bytes transferred = 1729512 (1a63e8 hex)
U-Boot> bootm 0x22000000
$$/code

### Loading Linux via Kermit ###

If TFTP isn't working for some reason, you can load Linux over the DBGU port with Kermit. Here's an example. Note the somewhat weird way that Kermit works-- after issuing the loadb command to U-boot, you type Ctrl-\C (that's Ctrl-\ followed by C) to return to the machine running Kermit. Then, you send the file, wait for it to transfer, and type connect again to return to U-boot.
Loading the kernel this way takes around 4 minutes for a 1.7 MB kernel.
$$code(lang=bash)
    U-Boot> loadb 0x20200000 115200
    ## Ready for binary (kermit) download to 0x20200000 at 115200 bps...
    (Back at milo)
    ----------------------------------------------------
    (/home/brandon/Desktop/Dropbox/Rascal/Software/Rascal bootstrap/) C-Kermit>send linux.bin
    (/home/brandon/Desktop/Dropbox/Rascal/Software/Rascal bootstrap/) C-Kermit>connect
    Connecting to /dev/ttyUSB0, speed 115200
     Escape character: Ctrl-\ (ASCII 28, FS): enabled
    Type the escape character followed by C to get back,
    or followed by ? to see other options.
    ----------------------------------------------------
    ## Total Size      = 0x001a79a4 = 1735076 Bytes
    ## Start Addr      = 0x20200000
$$/code

[1]: http://www.sparkfun.com/products/718
[2]: http://dangerousprototypes.com/bus-pirate-manual/
[3]: https://github.com/mgoelzer/RascalDevShield
[4]: http://www.denx.de/wiki/view/DULG/ELDKAvailability
[5]: https://github.com/rascalmicro/
[6]: /docs/software-guts.html
[7]: /2010/10/18/adding-a-microsd-card-to-the-rascal/
[8]: http://git-scm.com/
[9]: http://help.github.com/linux-git-installation/
[10]: http://help.github.com/mac-git-installation/
[11]: http://help.github.com/win-git-installation/
[12]: http://ftp.denx.de/pub/eldk/4.2/arm-linux-x86/iso/
[13]: http://www.codesourcery.com/sgpp/lite/arm/portal/release1294
[14]: http://en.wikipedia.org/wiki/Application_binary_interface
