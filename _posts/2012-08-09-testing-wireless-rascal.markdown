---
format: markdown
date: 2012/08/09 00:00:00
title: Testing the Rascal with a wireless adapter and battery
categories: rascal
---

The most frequent feature request for the Rascal is, "It should do wireless!" I've avoided putting a wireless transmitter on the Rascal so far because FCC-approved wireless modules cost more than Ethernet, and wireless can be fiddly to set up, especially if you're new to boards like the Rascal. I had suspected that cheap USB wireless adapters would work with the Rascal. While I'm waiting for the next batch of Rascals to be assembled, I had a chance to test it out, and it works!

Here's a quick video that shows the Rascal running completely wirelessly-- power supplied from a battery and communication supplied via wifi. (Thanks to robotics zealot Adam Bercu for lending me the battery.)

<iframe class="span11" src="http://player.vimeo.com/video/47257426?title=0&amp;byline=0&amp;portrait=0&amp;color=C6433C" height="461" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

The wireless adapter I used is an [Iogear GWU523][1], which uses the ZyDAS ZD1211B chipset. ZyDAS was bought by Atheros in 2006; it seems that the ZD1211B is now called the Atheros AR5007UG in some adapters. A list of wireless adapters that may work with this driver is on the [Linux kernel wireless site][2].

To make the adapter work, you need a driver module. Fortunately, since all the Rascal kernels so far are identical, there's no need to compile it yourself. You'll need two files to make the adapter work: the [driver][3] and the [firmware blobs][4]. The firmware blobs are precompiled binaries that ZyDAS/Atheros makes you upload to the wireless adapter after it's plugged in. (They do this because it's cheaper than adding flash memory to the adapters.)

### Preparing the Rascal to use the wireless adapter ###

First, install some software and fetch the driver and firmware blobs.
$$code(lang=bash)
opkg install wireless-tools wpa_supplicant
wget http://rascalmicro.com/files/kernel-modules/zd1211rw.ko
wget http://rascalmicro.com/files/kernel-modules/zd1211-firmware-blobs.tar.gz
$$/code

Install firmware blobs to <code>/lib/firmware/zd1211/</code> on your Rascal.
$$code(lang=bash)
mv zd1211-firmware-blobs.tar.gz /lib/firmware/
cd /lib/firmware
tar xzvf zd1211-firmware-blobs.tar.gz
$$/code

Edit <code>/etc/wpa_supplicant.conf</code> so that it has a section with your wireless network's name and password. This is a bit tricky in that the right setting will vary depending on what kind of encryption your network uses. There are a lot of examples in <code>/etc/wpa_supplicant.conf</code>
$$code(lang=bash)
network={
	ssid="Skynet" # Change this to your network's name
	psk="skynetresearchinitiatephasetwoprojectjudgementday" # Change this to your password
	priority=5
}
$$/code

### Bringing up the adapter ###

At this point, plug in the wireless adapter. You can leave it plugged in forever.

Insert the wireless driver into the kernel.
$$code(lang=bash)
insmod zd1211rw.ko
$$/code

When you run the <code>dmesg</code> command, you should see something like this.
$$code(lang=bash)
usb 1-1: new full speed USB device using at91_ohci and address 2
usb 1-1: reset full speed USB device using at91_ohci and address 2
phy0: Selected rate control algorithm 'minstrel_ht'
zd1211rw 1-1:1.0: phy0
usbcore: registered new interface driver zd1211rw
$$/code

Now you're ready to connect to your wireless network.
$$code(lang=bash)
ifconfig wlan0 up # Brings up the wireless interface
wpa_supplicant -B -c/etc/wpa_supplicant.conf -iwlan0 # Authenticates with your access point
udhcpc -i wlan0 # Requests an IP address via DHCP
$$/code

If those three commands succeed, victory is yours!

If you get this working with a wireless adapter other than the Iogear GWU523, please let [me][5] know. Eventually, my hope is to make the Rascal work out of the box with several wireless adapters.

### Notes about building the kernel module ###

You shouldn't need to build the kernel module, as there's a prebuilt binary available, but if you're running a custom kernel on your Rascal, you might want to. Here are some notes that will make sense to the kernel-savvy.
$$code(lang=bash)
make ARCH=arm menuconfig
$$/code

In menuconfig, enable the module: Device Drivers > Network device support > Wireless LAN > ZyDAS ZD1211/ZD1211B USB-wireless support 

Build the kernel modules.
$$code(lang=bash)
make ARCH=arm modules
$$/code

The file that you want is <code>~/linux-2.6/drivers/net/wireless/zd1211rw/zd1211rw.ko</code>. Be sure to get the firmware blobs mentioned above as well.

### About the battery ###

I have a bunch of interesting notes about the battery as well, but I'll save those for the next blog post. A quick summary is: get a 7.4 V lithium polymer battery from [hobbyking.com][6].

[1]: http://www.amazon.com/IOGEAR-Wireless-G-Speed-Adapter-GWU523/dp/B0009JR3SE
[2]: http://wireless.kernel.org/en/users/Drivers/zd1211rw/devices
[3]: /files/kernel-modules/zd1211rw.ko
[4]: /files/kernel-modules/zd1211-firmware-blobs.tar.gz
[5]: http://rascalmicro.com/about.htm
[6]: http://hobbyking.com