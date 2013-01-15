## Getting started with the Rascal ##

This eight minute video demonstrates web-based editing with the Rascal. It's a good place to start if you're unfamiliar with the Rascal.

<iframe class="span10" src="http://player.vimeo.com/video/31444914?title=0&amp;byline=0&amp;portrait=0&amp;color=C6433C" height="461" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

### Plugging the Rascal in ###

The Rascal needs two connections to do anything useful-- an Ethernet cable and a power cable. Plug in the Ethernet cable first so that it will be ready to go when the Rascal starts. After you plug in the power, the Rascal will take around 25 seconds to boot. It might take a little more time depending on how fast it gets assigned an IP address on your network.

As soon as the Linux kernel is up and running, the Rascal will turn off one of the green LEDs on the board (the one that is *not* next to the power jack).

After that, it will take a few seconds to start its web interface.

### The web interface ###

There's a sticker on the bottom of your Rascal that tells you the Bonjour address of your Rascal. (Bonjour is a protocol, created by Apple, used by printers to announce themselves on a network. It works natively on OS X and Linux; if you're running Windows, you'll want to install [Bonjour for Windows][1].) Your address should look something like: <code>rascal819.local</code>

Once you know your Rascal's address, you can access your Rascal's editor like this: <code>http://rascal819.local/editor</code>

After a brief stop at the login page where you enter the password that was included in the box with your Rascal, you'll find the editor.

<img src="/img/sprinkler-template-screenshot.png" width="820px">

### Troubleshooting the boot process ###

Here are a few tips that might be useful if you run into trouble connecting to your Rascal.

If both green LEDs remain on, try reseating your microSD card.

If the Rascal won't resolve at its Bonjour address, it's most likely that your DHCP server is failing to dole out an address. You might try using a Bonjour browser (iStumbler or Bonjour Browser for OS X, avahi-discover for Linux) to see if the address is getting broadcast. If the Rascal can't get an DHCP address, it will fall back to a link-local address.

When the Rascal boots, it sends a large amount of diagnostic data out its debug serial port and then waits for someone to login. You can connect to this serial port with 3.3 V signals at 115200 bps. The pins are arranged in order to match [Sparkfun's FTDI adapters][2] and cables. If you have a recent 5 V FTDI adapter, it can be converted to 3.3 V with the solder jumper on the bottom of the board. If the Rascal doesn't send out this diagnostic data, the Rascal's power supply is probably insufficient in some way. You might check the voltages at the circled vias labeled 3.3 V and 1.0 V.

### Useful development tools ###

* The [Developer Tools][3] for Chrome (especially the [Network Panel][4]) or [Firebug][5] for Firefox help immensely with debugging network communication. You can see packets leaving your browser and what responses they get.

* The network sniffer [Wireshark][6] is free and fascinating. Just seeing all the stuff flying around the network is a revelation.

* For general Python education, I like Zed Shaw's [Learn Python The Hard Way][7]. If you're already familiar with other programming languages, try Mark Pilgrim's [Dive Into Python][10]. Pilgrim's semi-rant about [data-centric programming][11] sold me on Python rapidly.

* For Javascript, I like Marijn Haverbeke's [Eloquent Javascript][8], coupled with Douglas Crockford's video and book, [Javascript: The Good Parts][9], which turns out to refer to a surprisingly large subset of the language. If you're an experienced programmer, you might jump straight to Crockford's stuff.

[1]: http://support.apple.com/kb/DL999
[2]: https://www.sparkfun.com/products/9873
[3]: https://developers.google.com/chrome-developer-tools/docs/overview
[4]: https://developers.google.com/chrome-developer-tools/docs/network
[5]: https://getfirebug.com/
[6]: https://www.wireshark.org/
[7]: http://learnpythonthehardway.org
[8]: http://eloquentjavascript.net/
[9]: http://googlecode.blogspot.com/2009/03/doug-crockford-javascript-good-parts.html
[10]: http://diveintopython.net
[11]: http://diveintopython.net/functional_programming/data_centric.html