## Building the Rascal code ##

If you're particularly enthusiastic, and you have access to a computer that can run Linux (perhaps in a VM), you can build all of the code for the Rascal yourself.

(It's probably possible to build all of the code on Windows or OS X, but it hasn't been done yet. All you need is a compiler that can generate code for the ARM architecture. For Windows, a good start would be the free CodeSourcery Lite toolchain.)

The code is stored in [Git repositories][5] on Github.com. Before you try building anything, you'll want to understand the basic layout of the software on the Rascal. Take a look at the Git repositories and read over where all the code belongs on the Rascal, as detailed on the [software guts][6] page.

## Software setup ##

First, you need a compiler and a few related build tools. You'll need to install the [Embedded Linux Development Kit][4], which is a precompiled collection of build tools--a compiler (GCC), make, and so forth-- maintained by Denx, the folks who make U-boot. You'll also need to install git.

## Installing the ELDK build tools on Linux ##
The ELDK uses its own copy of the Redhat Package Manager (RPM) to install itself. The simplest approach is to burn a copy of the 4.2 release [arm-2008-11-24.iso][12] to CD and install from that.

*Install the ELDK*
$$code(lang=bash)
brandon@milo:~$ sudo mkdir /opt/eldk
brandon@milo:~$ sudo chmod a+rwx /opt/eldk/
brandon@milo:~$ cd /media/arm-2008-11-24/
brandon@milo:/media/arm-2008-11-24$ ./install -d /opt/eldk arm
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

## Installing git ##

You'll also need [git][8] installed. You might also want a graphical Git client, but you only need two git commands (clone and checkout), so it's not required. Installing git is a straightforward process by now, and the fine people at Github have produced a series of guides that explain how to do it.

 * [Installing git on Ubuntu Linux][9]
 * [Installing git on OS X][10]
 * [Installing git on Windows][11]

## Test your tools ##

After installation, you need to set a few environment variables to make sure your OS can find your build tools. On Linux, these commands will do the trick, assuming you installed the ELDK to /opt/eldk. 
$$code(lang=bash)
export CROSS_COMPILE=arm-linux-
PATH=$PATH:/opt/eldk/usr/bin:/opt/eldk/bin
$$/code

Now you should be able to test your ARM compiler and git. Here's what a successful test looks like.

*Check git*
$$code(lang=bash)
brandon@milo:~$ git help
usage: git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]
           [-p|--paginate|--no-pager] [--no-replace-objects]
           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
           [--help] COMMAND [ARGS]
The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
...
<list of commands snipped>
...
See 'git help COMMAND' for more information on a specific command.
brandon@milo:~$ 
$$/code

*Check arm-linux-gcc*
$$code(lang=bash)
brandon@milo:~$ which arm-linux-gcc
/opt/eldk/usr/bin/arm-linux-gcc
$$/code

(Need to add a test here that tests that $CROSS_COMPILE is set correctly.)

## Building AT91Bootstrap, the primary bootloader ##

(Need to add AT91Bootstrap 3.0 repo and build instructions)

*Build the code* (BIN_SIZE and FROM_ADDR may be wrong)
$$code(lang=bash)
make CHIP=at91sam9g20 BOARD=at91sam9g20-ek ORIGIN=serialflash DESTINATION=sdram BIN_SIZE=0x30000 FROM_ADDR=0x10000 DEST_ADDR=0x23F00000 TRACE_LEVEL=5 clean all
$$/code


## Building U-boot, the secondary bootloader ##
You need to have $PATH and $CROSS_COMPILE defined from the ELDK install above.

*Download the code*
$$code(lang=bash)
git clone git@github.com:rascalmicro/u-boot-rascal.git
cd u-boot-rascal
git checkout rascal # switches to the Rascal branch
$$/code

*Build the code*
$$code(lang=bash)
brandon@milo:~/u-boot-2010.06$ make distclean
Generating include/autoconf.mk
Generating include/autoconf.mk.dep
brandon@milo:~/u-boot-2010.06$ make rascal_config
... 9G20 Variant
Configuring for rascal board...
brandon@milo:~/u-boot-2010.06$ make all
$$/code

## Building the Linux kernel ##

*Download the code*
$$code(lang=bash)
git clone git@github.com:rascalmicro/linux-2.6.git
cd linux-2.6
git checkout rascal # switches to the Rascal branch
$$/code

*Build the code*
$$code(lang=bash)
make ARCH=arm uImage
$$/code

If the toolchain builds the kernel successfully, you'll find the kernel image at arch/arm/boot/uImage.

## Building OpenEmbedded filesystem image ##
*Download the code*
$$code(lang=bash)
git clone git@github.com:rascalmicro/openembedded-rascal.git
cd openembedded-rascal
git checkout rascal # switches to the Rascal branch
$$/code

(There are some steps missing here. Need bitbake and env.sh script. TODO: Fix this.)

*Build the code*
$$code(lang=bash)
source env.sh # sets some environment variables, like BBPATH
bitbake rascal-image
$$/code

## Hardware setup ##
For development, you need 4 connections to the Rascal.

1. Power: any DC power supply with a voltage in the 7.5-15 V range with a center-positive, 2.1 mm barrel connector should work. Supplies that work with the Arduino will also work with the Rascal. 

2. Serial: when the Rascal boots, it sends a stream of messages out a serial port to help you with debugging. There are a few ways to connect to this; the easiest is probably connecting the debug serial port to a PC running a terminal program like Kermit with a [Sparkfun FT232R breakout board][1] and a USB cable. You could also use a [Bus Pirate][2], a [Rascal Developer's Shield][3], or a MAX232 chip on a breadboard and a serial cable.

3. Ethernet: strictly speaking, you don't actually need this for development, but it's the quickest way to load a kernel onto the board at boot, which is convenient when you're testing new kernels.

4. JTAG: You also don't *really* need JTAG, but it makes writing new code into the serial flash less risky. You can, in theory, use U-boot to rewrite the serial flash, but if you screw it up, only a JTAG connection can fix the problem. JTAG is also great for debugging, as it can pause the processor while it's running. The only disadvantage to JTAG is the cost-- it requires a Segger JTAG pod, plus a special adapter to connect to the Secret JTAG Port on the bottom of the Rascal.

I’ll document the setup that I’m using, but it’s not optimal, as I’m using two computers, and the GDB server is a little clumsy. But, it’s all I’ve been able to get to work so far.
The first machine is running Windows 7, but it could in theory be running Linux or Windows XP. The following software is installed on it:

 * The drivers for the Atmel SAM-ICE JTAG pod
 * Segger J-Link GDB server
 * All of the binaries that will be loaded via JTAG, namely AT91Bootstrap and U-boot

The GDB server talks to the Rascal through the JTAG pod, which is plugged into one of the Windows machine’s USB ports and into the Rascal’s JTAG connector. The server gets its commands from a GDB client, which I was running on a Linux machine, but it could be anywhere.

The second machine is running Ubuntu Linux 10.04. The following software is installed on it:

 * GDB 7.1-ubuntu debugger (default version for Ubuntu 10.04)
 * Kermit 8.0.211 terminal emulator (default version for Ubuntu 10.04)
 * Tftpd-hpa TFTP server (default version for Ubuntu 10.04)

## Loading the Linux kernel via TFTP ##

You can use U-boot to load the Linux kernel via TFTP. The address 0x2200 0000 is arbitrary-- RAM starts at 0x2000 0000. I don’t know where U-boot resides, but 0x2200 0000 is safe, at least for a 1.7 MB kernel.
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

## Loading Linux via Kermit ##

If TFTP isn’t working for some reason, you can load Linux over the DBGU port with Kermit. Here’s an example. Note the somewhat weird way that Kermit works-- after issuing the loadb command to U-boot, you type Ctrl-\C (that’s Ctrl-\ followed by C) to return to the machine running Kermit. Then, you send the file, wait for it to transfer, and type connect again to return to U-boot.
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

## Wiping microSD card and copying on OpenEmbedded image ##

First, you have to figure out the name of the card that you want to wipe in your device hierarchy. To do this, check dmesg, insert the card, and then check dmesg again. The new text that shows up at the end should tell you where the card you inserted was mounted-- it's often something like /dev/sdb1.

(Note [cautionary tale][7] about accidentally wiping hard drive's boot sector at the end of blog post.)

*Wipe the card clean*
(Warning: this, uh, wipes the card clean.)
$$code(lang=bash)
brandon@milo:/oe$ sudo -s # become the superuser.
[sudo] password for brandon: 
root@milo:/oe# umount /dev/sdb1 # unmount the card
root@milo:/oe# mkfs.ext3 -L transcend-ext3 /dev/sdb1 # wipe everything and make a new EXT3 filesystem
mke2fs 1.41.12 (17-May-2010)
Filesystem label=transcend-ext3
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
246512 inodes, 984320 blocks
49216 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=1010827264
31 block groups
32768 blocks per group, 32768 fragments per group
7952 inodes per group
Superblock backups stored on blocks: 
    32768, 98304, 163840, 229376, 294912, 819200, 884736
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
This filesystem will be automatically checked every 29 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
$$/code

Now, pull the card out and reinsert it so that it gets remounted.

Then:
$$code(lang=bash)
root@milo:/oe# ls /media # check that the card is mounted
transcend-ext3
root@milo:/oe# cp -r /oe/tmp/rootfs/* /media/transcend-ext3/ # copy the filesystem onto the card
$$/code

[1]: http://www.sparkfun.com/products/718
[2]: http://dangerousprototypes.com/bus-pirate-manual/
[3]: https://github.com/mgoelzer/RascalDevShield
[4]: http://www.denx.de/wiki/view/DULG/ELDKAvailability
[5]: https://github.com/rascalmicro/
[6]: http://rascalmicro.com/docs/software-guts.html
[7]: http://rascalmicro.com/2010/10/18/adding-a-microsd-card-to-the-rascal/
[8]: http://git-scm.com/
[9]: http://help.github.com/linux-git-installation/
[10]: http://help.github.com/mac-git-installation/
[11]: http://help.github.com/win-git-installation/
[12]: http://ftp.denx.de/pub/eldk/4.2/arm-linux-x86/iso/
