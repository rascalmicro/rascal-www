---
format: markdown
date: 2010/10/21 00:00:00
title: Finding the Rascal
categories: rascal, dhcp, patents, wishful thinking
draft: false
---
One unusual function of the Rascal blog is to document publicly the plans I have for the Rascal as a defense against patents.

Why don't I patent these ideas myself? The [average time for a patent to issue][1] is 6 years; the cost is somewhere around $10,000. These ideas aren't the core of the Rascal-- they're components of a larger design.

In the mechanical realm, it's realistic to think that someone could devise a clever way of joining two cylindrical shafts (like the Trantorque, [US patent 4202644][2], 1980) and become the exclusive supplier of "keyless bushings" to the shaft couplers of the world. In the realm of software, it is not reasonable to think that someone might become the exclusive supplier of a certain sorting algorithm. There's the additional wrinkle that algorithms can't be patented directly; you have to patent a device that performs the algorithm. On top of all that, if I wanted to take software patents seriously, I'd need to read a lot of them, which means that any subsequent infringements would incur triple damages.

I'm trying to build a movement, not a secret club, so I'm going to do what all the programmers I know do, which is ignore the broken system and hope it changes before it affects me. (There are probably programmers at large companies that behave differently, but I don't know them.) I talked with a gentleman a few months ago who is one of the directors at the MIT Technology Licensing Office; I was heartened by his assertion that MIT doesn't license software patents, it generally doesn't pursue patents unless they suspect that they're licensable, and they don't renew patents that haven't been licensed in the first couple of years after issuing.

But enough about patents-- the real point of this post is to explain what I'm planning to detect Rascals on a network.

When you buy a small computer with an Ethernet port, like a [Gumstix][3] or some other embedded Linux board, you have to figure out how to find it on your network. You plug the device into your network with an Ethernet cable and power it up. Most of these devices send out what's called a "DHCP request." (DHCP stands for Dynamic Host Configuration Protocol.) The request goes out to all of the computers on the local network. One of the computers, usually some server in the basement, is in charge of handing out IP addresses to new arrivals. It sends back a packet that contains the IP address that your computer should use.

The unfortunate part is that you can't see internet traffic with the naked eye, so even though your device now has an address, you don't know what it is. There are a few solutions. You can use a program like [nmap][4] to scan the network to see what computers exist, and then try them one by one. If you have a computer that comes with a [Zeroconf][5] implementation installed, i.e. a computer not running Windows, you might be able to use that to detect the new device. You could install and use Apple's Zeroconf implementation for Windows. You could also connect your new device to a hub that repeats all incoming traffic on all ports and use a packet sniffer like [Wireshark][6] to listen for the IP assignment response from the DHCP server.

These are all painful techniques for normal people.

My intent is to make the Rascal reveal its identity more easily. What follows is the plan I'm thinking of using, but it's still in pre-natal condition. Better ideas are welcome. When you plug in a Rascal, it gets an IP address like any other device. After it receives an address, it starts sending packets periodically to a server running at ip.rascalmicro.com (doesn't exist yet). The packet contains the serial number and ip address of the Rascal. Upon receiving the packet, the server adds the IP address to a database, which you can search for on the Rascal Micro website using the serial number as the key. This links you to a page that tells you the IP address.

From there, you connect directly to your Rascal. If you want, you can add a static IP address for your Rascal, so you don't have to go through this again. (You can also configure your DHCP server to always give your Rascal the same IP address, but that means mucking around with your DHCP server. The DHCP server can identify the Rascal, or any computer, by its unique Ethernet MAC address.)

## Comments ##

If you want to comment on this post, use [this post][7] on the forums.

[1]: http://www.uspto.gov/dashboards/patents/main.dashxml
[2]: http://www.google.com/patents?vid=USPAT4202644
[3]: http://www.gumstix.com/store/catalog/product_info.php?products_id=251
[4]: http://nmap.org/
[5]: http://www.zeroconf.org/
[6]: http://www.wireshark.org/
[7]: http://rascalmicro.com/forum/viewtopic.php?f=7&t=14