# Building the Rascal codebase #

The Rascal is a small, open-source computer designed for connecting sensors, motors, and whatever else you can build to the internet. It's about 5 cm x 10 cm (2 inches by 4 inches).

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
 * The Embedded Linux Development Kit (ELDK) 4.2 from DENX, who make U-boot

The ELDK is a precompiled collection of build tools--GCC, make, and so forth. I burned a copy to CD and installed from that.

## Installing the compiler ##
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
<snip out the middle>
...
Preparing...                ########################################### [100%]
   1:ppp-arm_trg            ########################################### [100%]
Done
brandon@milo:/opt/eldk$ export CROSS_COMPILE=arm-linux-
brandon@milo:/opt/eldk$ PATH=$PATH:/opt/eldk/usr/bin:/opt/eldk/bin
$$/code

## AT91Bootstrap: primary bootloader ##

## U-boot: secondary bootloader ##
You need to have $PATH and $CROSS_COMPILE defined from the ELDK install above.
*Download the code*
$$code(lang=bash)
git clone git@github.com:rascalmicro/u-boot-rascal.git
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

## Linux kernel ##

git clone git@github.com:rascalmicro/linux-2.6.git
make ARCH=arm uImage

## Linux filesystem using OpenEmbedded ##
## Web interface ##

## Loading the Linux kernel via TFTP ##

You can use U-boot to load the Linux kernel via TFTP. The address 0x2200 0000 is arbitrary-- RAM starts at 0x2000 0000. I don’t know where U-boot resides, but 0x2200 0000 is safe, at least for a 1.7 MB kernel.
Note the timeouts in the log below. The timeouts are caused because the Ethernet PHY is switching to half-duplex mode, even though we don’t want it to. When talking to a full-duplex switch in half-duplex mode, it starts dropping packets. You can minimize the timeouts by reducing other traffic on the network. (Good luck with that if you have a Windows 7 machine on your network.)
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
##############################################
done
Bytes transferred = 1729512 (1a63e8 hex)
U-Boot> bootm 0x22000000
$$/code

## Loading Linux via Kermit ##

If TFTP isn’t working for some reason, you can load Linux over the DBGU port with Kermit. Here’s an example. Note the somewhat weird way that Kermit works-- after issuing the loadb command to U-boot, you type Ctrl-\C (that’s Ctrl-\ followed by C) to return to the machine running Kermit. Then, you send the file, wait for it to transfer, and type connect again to return to U-boot.
Loading the kernel this way takes around 4 minutes.
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