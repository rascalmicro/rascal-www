---
format: markdown
date: 2013/04/24 00:00:00
title: Reading 125 kHz RFID cards using Wiegand protocol in Python
categories: rascal
---
One of the early Rascal customers was the [Massachusetts General Hospital Learning Lab][1]. The Learning Lab has been developing an attendance tracking system using 125 kHz RFID cards. In their current system, each card reader talks to an [Arduino microcontroller][2] using the [Wiegand protocol][3]; the Arduino talks to a PC over a USB cable; and the PC talks over the local network a database server to determine whether a card is valid or not.

The folks at the Learning Lab wanted to replace the PC and the Arduino with a Rascal, so I offered to help them interface their Wiegand card reader with the Rascal. For testing purposes, I got a cheap [Wiegand protocol card reader][4] off of Ebay. A little googling revealed that a gentleman by the name of Mark Jason Anderson had already written a Linux driver for Wiegand card readers. He used some CPU-specific kernel functions in his code, but luckily he was using the same Atmel AT91SAM9G20 processor that I use for the Rascal. I [forked his wiegand-linux repository to my own][5] on Github and modified the code slightly to use pins that the Rascal breaks out to its Arduino headers. I was able to build the kernel driver with the same cross-compiler I use for the Rascal kernel. The details of setting up the ARM cross-compiler are covered in the [Rascal build guide][6].

There was one other challenge-- the card reader idles at 5 V, but the Rascal expects 3.3 V on its inputs. To scale the voltage down, I used a circuit not unlike the 2x voltage divider on the [Sparkfun level shifter][7]. The picture below shows the circuit. I used 4.64k and 9.09k resistors to scale the voltage down. In theory, this would reduce a 5 V signal to 3.31 V; I measured it at 3.29 V, so it was pretty close. I suspect that a 5k and 10k resistor would work fine, but I found the other values in my bins first.

<img src="/img/level-shifter-5v-to-3v3.png">
##### Circuit used to scale Wiegand card reader's 5 V down to 3.3 V for the Rascal inputs #####

The earlier kernel driver build provided me with a driver binary called wiegand-linux.ko. I copied that to the Rascal. For testing, I was able to insert it into the running kernel like this:
$$code(lang=bash)
insmod wiegand-linux
$$/code
After this, the following shows up in dmesg:
$$code(lang=bash)
wiegand intialising
wiegand ready
$$/code
To make the kernel load on boot, the binary should be moved into <code>/lib/modules/2.6.36+/</code> and the full filename, <code>wiegand-gpio.ko</code>, added to <code>/etc/modules</code>.

When a card is held next to the card reader, it beeps, the diamond flashes green, and we see new text in dmesg.
$$code(lang=bash)
1 0 0 1 0 0 0 0 0 1 1 1 1 1 1 1 0 1 0 0 1 0 0 0 0 0 wiegand read complete
new read available: 32:65168
$$/code

The new card data is also available from <code>/sys/kernel/wiegand/read</code>.

In the long run, I'd like the RFID reader to display some confirmation that it's working properly on a display, so I hooked up a [4D Systems LCD][8] that I had from a different project. Here's the whole assemblage.

<img src="/img/rascal-with-rfid-reader-and-lcd.jpg">
##### RFID reader and LCD plugged into the Rascal #####

The last step is to pull data from <code>/sys/kernel/wiegand/read</code> and display it on an LCD. (Of course, the Rascal should also do something useful like unlock a door or log the card number to a database, but this is just a demo.) I wrote a short [RFID monitoring Python script][9] that does this on the Rascal. It would be nice to use the Rascal's Python server, uWSGI, to watch for new cards and trigger the Python so a second script wouldn't be needed, but that would mean writing a libudev plugin for uWSGI. I might do that eventually, but for now, this works fine. If you take a close look at the LCD in the picture above, you can see data from the few test RFID cards that I have.

Onwards!

[1]: http://libguides.massgeneral.org/learninglab
[2]: http://arduino.cc
[3]: http://en.wikipedia.org/wiki/Wiegand_interface
[4]: http://www.ebay.com/itm/Waterproof-Security-Door-Black-EM-ID-Wiegand-26-34-RFID-Card-Reader-/170997734969
[5]: https://github.com/rascalmicro/wiegand-linux
[6]: http://rascalmicro.com/docs/build-guide.html
[7]: https://www.sparkfun.com/products/8745
[8]: https://www.sparkfun.com/products/11740
[9]: https://gist.github.com/pingswept/5454485