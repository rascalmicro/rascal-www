## Debugging Rascal 1.1, March 2012 ##

### The background ###

Rascal 1.1 is a new revision of the Rascal PCB. The functionality is 95% the same; the biggest changes are switching from the Micrel KSZ8041 to the KSZ8051RNL ethernet PHY and adding a second USB host port. All capacitors were changed from 1206 packages to 0603. I have just assembled the first two PCBs. All of the changes work as expected, but there appears to be a new problem.

### The problem ###

The new boards reboot unexpectedly while Linux is attempting to boot. Additionally, a similar reboot can sometimes be induced by executing the command:

<code>git clone git://github.com/marijnh/CodeMirror2.git</code>

It appears that the reset is controlled by the processor. The oscilloscope capture below shows four lines:

1. yellow: processor reset line, NRST, at connector J4
2. blue: 3.3 V bus at connector J4
3. pink: 5.0 V bus at connector J4
4. green: 1.0 V bus next to L5

<img class="span12" src="/img/reset-with-power-supplies-2012-03-08.png">

From this, it looks like the power supply voltages are steady and the reset is controlled.

### When the resets happen ###

 * The resets rarely or never happen when the processor is idle.
 
 * Unplugging the ethernet cable appears to make no difference; resets still occur.
 
 * The resets do not appear at *random* times during boot. The table below lists some statistics on when they occur. The full boot message appears at the bottom of this page for context.
 
 * In general, the kernel tends to make it further each time it boots. This isn't strictly true, but it's at least a weak tendency.

<pre>
Table of last boot messages from Linux kernel before reset occurs    

Reps  Message
----  ------------------------------------------------  
1     Uncompressing Linux... done, booting the kernel.
4     RPC: Registered tcp NFSv4.1 backchannel transport module.
2     INIT: version 2.86 booting
1     mount: mounting /dev/mmcblk0p1 on /mnt/root failed: . . .
4     Setting up IP spoofing protection: rp_filter.
2     Lease of 192.168.10.190 obtained, lease time 43200
1     udevd (403): /proc/403/oom_adj is deprecated . . .
1     * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon...done.
2     Populating dev cache
1     INIT: Entering runlevel: 5 Staþ
14    rascal14 login:

Total successful boots interspersed among spurious resets above: 4 (out of 37 total)
</pre>

### Appears to be related to memory errors ###

My fellow Artisan's Asylum denizen, Edison G., has been helping me with the debugging. Noticing that the resets seemed to only occur after U-boot passed control to the Linux kernel, Edison suggested that we try making the board reset under U-boot. Looking through the list of U-boot commands, the memory test command, <code>mtest</code> seemed like it might generate a decent load on the processor, so we gave it a try.

As it turns out, <code>mtest</code> reveals that the problem seems to be related to memory errors in the SDRAM on the board. The idea is that either the kernel gets written to RAM incorrectly, or instructions are read back incorrectly as they are executed. Faced with an invalid instruction, the processor does the only thing it can do, which is reset itself. Similar failures occur on both new boards but do not occur with an older board.

### Memory test results ###

The memory errors reported by U-boot look like this:

<pre>
    Mem error @ 0x202035F0: found 0008F209, expected FFF7F209

    Mem error @ 0x202035F4: found 0008F208, expected FFF7F208

    Mem error @ 0x202035F8: found 0008F207, expected FFF7F207

    Mem error @ 0x202035FC: found 0008F206, expected FFF7F206

    Mem error @ 0x20203600: found 0008F205, expected FFF7F205

    Mem error @ 0x20203604: found 0008F204, expected FFF7F204
    Pattern 00000080  Writing...  Reading...
</pre>

There's a pattern to the errors: the two lower bytes are correct, but the two upper bytes are the inverse of what they should be (0x0008 instead of 0xFFF7, and note that 0xFFF7 + 0x0008 = 0xFFFF). This pattern appears most of the time. Sometimes, the found value is exactly the inverse of the expected value.

The <code>mtest</code> program writes to every RAM address alternating values from each end of the range of 32 bits, i.e. this sequence: 0xFFFFFFFF, 0x00000000, 0xFFFFFFFE, 0x00000001, . . ., but incrementing the value written by 1 for each memory location as it crosses the address space. The [memory test code][1] is on Github.

The fact that the data read back is the inverse of what we expect, with errors along byte boundaries, rather than random corruption, suggests that the problem is a timing issue, rather than a data or address problem.

### Theories about what could be wrong ###

 * The new, smaller capacitors have less capacitance, and as a result, one of the power supplies is sagging and inducing a reset. Doesn't appear to be the case from the scope image above, but maybe the scope is missing small glitches closer to the processor, or maybe they happen more than 20 ms before the reset. I tried soldering 1 uF caps on top of C21 and C29, and adding a 10 uF cap across pins 27-28 of U5.

 * (Edison's theory) The processor thinks it's hotter than it really it is and is going into thermal shutdown.
 
 * It has something to do with the PHY getting reset, incorrectly reinitialized by the kernel after U-boot releases it, or something like that. It's not clear how the PHY could make the processor reset.
 
 * The memory chips on the new boards are from the same batch as the ones on the old boards, but they spent a humid summer sitting in a closet. While in the closet, they absorbed moisture, which turned to steam when they were run through a reflow oven without a dessication step ahead of time. This damaged the chips in some way. It's somewhat plausible, but it doesn't explain why the memory errors have the same peculiar characteristics on both boards. Could try desoldering two chips and soldering in chips from the new batch.
 
 * Perhaps U-boot's ALT_MEMTEST would give more information (though this wouldn't help if it's a timing issue, which it appears to be).

* Try running the board in a very warm or very cold box and see if the problem persists.

### Related files ###

* [Rascal 1.1 schematic][2]
* [Rascal 1.1 PCB][3]

### Full Linux boot log ###

<pre>
-- AT91bootstrap Project 3.0 --
-- AT91SAM9G20-EK
-- Compiled: Nov 18 2010 10:52:41 --
-I- Setting: MCK = 132MHz
-I- I cache enabled.
-I- Init SDRAM
-I- Init AT26 Serialflash
-I- SerialFlash detected : MX25L3205
-I- Copy "" (196608 bytes) from SerialFlash 0x00010000 to 0x23f00000
-I- Jump to 0x23f00000

U-Boot 2010.09-00018-gd9cc284-dirty (Apr 25 2011 - 19:38:42)

DRAM:  64 MiB
MMC:   mci: 0
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   macb0
Hit any key to stop autoboot:  3  2  1  0 
Initializing SPI0 CS line for software control
SF: Got idcode c2 20 16 c2 20
SF: Detected MX25L3205D with page size 256, total 4 MiB
4096 KiB MX25L3205D at 0:0 is now current device
## Booting kernel from Legacy Image at 22000000 ...
   Image Name:   Linux-2.6.36+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2940472 Bytes = 2.8 MiB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.36+ (brandon@milo) (gcc version 4.2.2) #33 Tue Nov 1 21:38:15 EDT 2011
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: Rascal
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 396 MHz, master 132 MHz, main 18.432 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttyS0,115200 ip=::::rascal14:: pwhash=LwWYSgXfPAMbc
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 60100k/60100k available, 5436k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc4800000 - 0xfee00000   ( 934 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0118000   (1088 kB)
      .text : 0xc0118000 - 0xc046f000   (3420 kB)
      .data : 0xc048c000 - 0xc04ab940   ( 127 kB)
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:192
AT91: 96 gpio irqs in 3 banks
Console: colour dummy device 80x30
console [ttyS0] enabled
Calibrating delay loop... 197.83 BogoMIPS (lpj=989184)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
AT91: Power Management
AT91: Starting after general reset
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-gpio i2c-gpio: using pins 55 (SDA) and 56 (SCL)
Advanced Linux Sound Architecture Driver Version 1.0.23.
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource tcb_clksrc
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Major: 253; minor: 0
Registered device at91_adc.
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 117
io scheduler noop registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq = 1) is a ATMEL_SERIAL
atmel_usart.1: ttyS1 at MMIO 0xfffb0000 (irq = 6) is a ATMEL_SERIAL
atmel_usart.2: ttyS2 at MMIO 0xfffb4000 (irq = 7) is a ATMEL_SERIAL
brd: module loaded
loop: module loaded
ssc ssc.0: Atmel SSC device at 0xc4878000 (irq 14)
nand_get_flash_type: second ID read did not match 52,30 against ff,07
No NAND device found.
MACB_mii_bus: probed
eth0: Atmel MACB at 0xfffc4000 irq 21 (02:71:82:06:00:14)
eth0: attached PHY driver [Micrel KS8051] (mii_bus:phy_addr=ffffffff:00, irq=-1)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: gpio-keys as /class/input/input0
rtc-at91sam9 at91_rtt.0: rtc core: registered at91_rtt as rtc0
rtc-at91sam9 at91_rtt.0: rtc0: SET TIME!
i2c /dev entries driver
wm8731 0-001b: Failed to issue reset: -6
No device for DAI atmel-ssc0
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
rtc-at91sam9 at91_rtt.0: hctosys: unable to read the hardware clock
Freeing init memory: 1088K
Starting initramfs init script with busybox...
Mounted /proc and /sys
mount: mounting /dev/mmcblk0p1 on /mnt/root failed: No such device or address
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SDHC card at address 79ed
mmcblk0: mmc0:79ed SD04G 3.69 GiB 
 mmcblk0: p1
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p1): warning: maximal mount count reached, running e2fsck is recommended
EXT3-fs (mmcblk0p1): using internal journal
EXT3-fs (mmcblk0p1): recovery complete
EXT3-fs (mmcblk0p1): mounted filesystem with ordered data mode
mount: mounting /dev/mmcblk0p1 on /mnt/root failed: Device or resource busy

INIT: version 2.86 booting

Please wait: booting...
Starting udev
udev: starting version 151
udevd (403): /proc/403/oom_adj is deprecated, please use /proc/403/oom_score_adj instead.
Root filesystem already rw, not remounting
Caching udev devnodes
Populating dev cache
Configuring network interfaces... udhcpc (v1.13.2) started
run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
Sending discover...
eth0: link up (100/Full)
Sending discover...
Sending select for 192.168.10.190...
Lease of 192.168.10.190 obtained, lease time 43200
run-parts: /etc/udhcpc.d/00avahi-autoipd exited with code 1
adding dns 192.168.10.1
done.
Setting up IP spoofing protection: rp_filter.
hwclock: RTC_RD_TIME: Invalid or incomplete multibyte or wide character
Wed Mar  7 17:25:00 UTC 2012

INIT: Entering runlevel: 5

Starting system message bus: dbus.
Starting OpenBSD Secure Shell server: sshd
done.
Starting ntpd: done
Starting syslogd/klogd: done
 * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
   ...done.
/etc/init.d/rc: /etc/rc5.d/S60rascal-gpio.sh: line 5: can't create /sys/class/gpio/gpio55/direction: nonexistent directory
/etc/init.d/rc: /etc/rc5.d/S60rascal-gpio.sh: line 5: can't create /sys/class/gpio/gpio56/direction: nonexistent directory
root: Initializing Rascal
root: Root's password is not blank; good job.
root: You are part of the solution.
Starting Rascal webserver...
done

Date: Wed Mar 7  2012
Kernel release: 2.6.36+
Angstrom 2010.7-test-20111025 rascal14 ttyS0

rascal14 login:
</pre>

[1]: https://github.com/rascalmicro/u-boot-rascal/blob/rascal/common/cmd_mem.c#L901
[2]: /files/rascal-1.1-schematic.pdf
[3]: /files/rascal-1.1-pcb.pdf