---
format: markdown
date: 2011/08/01 00:00:00
title: I want to connect weird stuff to the internet
categories: presentations, rascal, webinterface
---

Through the unseen machinations of social networks, I was invited by LED zealot [Mike Kuniavsky][1] to the [Sketching in Hardware][2] conference in Philadelphia last weekend. All 38 attendees were required to give an 18 minute presentation related to the topic of the conference, which is tools for physical computing prototyping. ("Physical computing" is a term used by CS types to describe what the mechanical and electrical engineers call "embedded systems" and the English majors call "Arduinos.")

The talks weren't recorded and my slides ([1.7 MB PDF][30]) contain only an outline of what I talked about, so I thought it would be useful to summarize what I talked about, while also adding a few links and details that I omitted in the 18-minute spoken format.

## What I said at Sketching In Hardware ##

Introductory fact: I want to connect weird stuff to the internet.

Because I'm an embedded systems engineer, idle conversation often leads to someone saying this to me:
"Oh, you know about computers? OK, here's what I want to do. I want to somehow take this thing and connect it to the internet."

"This thing" is usually something weird. Recent examples include:

* A chicken coop
* Some kind of sausage factory
* Hot tub
* Thermostat for the boiler in a box factory
* A lighting display that reflects the anger level of the owner, two friends, and a guest

I love this kind of project, but I used to have an attitude about the proper hardware for the job.

In grad school, I used to scoff at the [BASIC Stamp][11]. Running into a friend buying a BASIC Stamp in Fry's, I'd challenge them: "You know that's just a $3 PIC with a BASIC interpreter on it, right? Why would you pay $50 for that?"

They would have some reasonable response like: "Look, Brandon, I just want to make this valve keep my tomato plants watered. What would you have me do?"

I'd think: "Why, just learn C, PCB layout, and some basic electrical engineering! . . . Er. Um. I guess I'm being unreasonable. But it's a $3 PIC!" I'd say something dumb, and then storm off to the lab.

Now, after a few years working with lots of different microcontrollers and industrial automation systems, I'm on the other side. Yes, I know C, and I can lay out PCBs, but for simple tasks, I want a simple tool.

This is where the [Arduino][12] enters the picture. The Arduino folks have done an incredible job of making a simple microcontroller board that is easy to use for people who are new to programming. As a result, a huge community has developed around the board. The Arduino is not the ultimate solution for all problems, but it does a great job at simple automation tasks.

## Moving beyond the Arduino ##

Of course, as you try to do more complex stuff with the Arduino, you start to hit its limits: 16 MHz clock, no file system, no threading, 2 kB RAM, 32 kB of flash, no internet connection, no display. Marginally capable of audio, no hope of video.

You start cobbling together an operating system with different modules. You try to squeeze a webserver, network driver, and threading module into 32 kB.

*(Note: [Dave Mellis][3] was nodding knowingly and smiling at this point in the talk.)*

Then you end up in the unfortunate situation where you need to jump up to a more powerful system. There are lots of choices, but probably you end up with something like [Gumstix][4] or the [Beagleboard][5]-- an embedded Linux system. Suddenly, instead of the friendly Arduino program, you're off in the weeds. The friendly programming environment is gone. The sea of helpful community has [drained back through the Bosphorus][6], and you're standing in a field of muddy, dying fish. This is not pleasant.

(To speak in defense of the manufacturers of Linux boards for a moment: they're targeting professional engineers who want cheap, reliable hardware. They're deliberately not optimizing for amateur tinkerers, because tinkerers don't place large orders. Makes sense to me.)

This brings us to the point of this presentation (er, blog post). I've come up with 8 barriers to normal people connecting weird stuff to the internet. There are certainly more, but these are what I see as the big ones. I'll list each problem and try to explain what I see as our best solutions are, or at least what direction we should be going. (Throughout this discussion, I'll refer to a "Linux board," but it could be running some other operating system and most or all of the same problems would exist.)

## Problem 1: “I can’t find the damn thing’s IP address!” ##

You plug a Linux board into your network. It receives an IP address from the DHCP server in your firewall, but you have no idea what it is. If you're a normal person, you probably don't even know that your firewall has a DHCP server, and you definitely don't know how to access its admin interface to check what IPs it has dispensed. You're left in the ridiculous situation where you can see the board sitting on your desk, but you can't find it on your network.

The best solution we have at present is what is called "[zero configuration networking][13]" or "zeroconf." Apple calls [their implementation][14] "[Bonjour][15]," while the Linux people call [theirs][16] "Avahi." Apple has a [zeroconf implementation for Windows][17], but it is not installed by default.

I propose that all Linux boards ship with Avahi set to announce its existence on the network. For the board I'm working on, the Rascal, I'd give it the hostname "rascal<serial number>". If you read the serial number 246 on the bottom of the board, you can open a web browser and go to rascal246.local, and the Rascal will respond with a page that gives you basic information about the board (such as the damn IP address).

## Problem 2: SSH is baffling. ##

The next two problems are connected.

Once you know the board's IP address, you have to log into it using a secure shell (SSH) terminal like [Putty][20]. Unfortunately, because SSH traffic is encrypted, and configuring encryption keys is confusing, SSH baffles people. The standard SSH warnings are good, because we want our systems to be secure, but they presume a level of sophistication that is not present in the normal person who is trying to connect a chicken coop to the internet.

## Problem 3: Console editors are weird, alienating, and ugly. ##

If you do manage to figure out SSH, you then have to use an ugly console-based text editor like Nano that doesn’t support cut and paste by any conventional means.

I think we can solve the previous two problems together in one stroke. I think we need what I call "self-serve programming tools." (I've written about this in [more detail][10] previously.) Since we know these boards can connect to the internet, we should make them serve browser-based editors. On Github, I've started an [open-source project to do this][21], based around [Codemirror][25] and the [jQuery Filetree plugin][26]. Note that I'm not talking about stuff like the cloud compiler for the [Mbed][22], though I do think that's cool. I'm talking about hosting the code editor directly on the Linux board.

## Problem 4: Embedded C, Makefiles, and gcc are scary. ##

I like programming in embedded C as much as the next Linux zealot, but most people prefer to sacrifice some performance in order to use higher-level languages like Python or Ruby. I think we need to have hardware APIs in multiple higher-level languages that can be called through web requests. (In the long run, I think we need server software based around event frameworks like [Twisted][23], but I didn't actually say that in the talk.)

## Problem 5: GUI builders ##

Often you need to use a custom GUI builder for a new embedded device with display (e.g. GTK, Qt, …). I actually like GUI builders, but the market has been badly fragmented for so long. As a result, HTML and CSS have won. As Mark Pilgrim has said: “[HTML] is the format of our age.”

There is a large swarm of amateurs who, when faced with HTML and CSS, will say, “I don’t really know how this works, but I can cut and paste it real well...” This pattern of example modification is something that tinkerers thrive on. (TCP handshake with [Björn Hartmann][7] for the apt phrase, "example modification.") Rather than resisting HTML and CSS, we should embrace them, particularly with the burgeoning acceptance of HTML5 and rapidly improving Javascript libraries like [jQuery][24].

## Problem 6: No users, permissions, sessions. ##

After you get your weird thing connected to the internet, you often realize that you want to have some features that aren't accessible to everyone, while still letting the general public have some access. This involves writing a bunch of tedious code, and doing it securely is not easy.

Fortunately, these problems were crushed a few years ago by web frameworks like [Ruby on Rails][8] or [Django][9] (“Python on Rails”).

## Problem 7: Low fault tolerance ##

“I edited some files, and now it won’t boot.”

Our Linux boards should have removable media so that they can be reset to factory defaults. A normal person can probably handle downloading a default file system from the web onto an SD card and sticking that into the board.

## Problem 8: Dynamic IP addresses ##

In the US, at least, the IP addresses of most home internet connections change periodically, which breaks the domain name system. (I'm told IPs change less in Japan.) If you want your IP address to remain the same, you have to pay around $15 per month to the people selling you the connection.

The only solution I know of to this is to use a dynamic DNS service, and a router running open source firmware like [Tomato][18] or [DD-WRT][19]. After the talk, people suggested a few other possibilities ([Yaler][27], some VPN service like [Hamachi][28], and something involving IPv6), but I don't have any intelligent opinions about them yet.

That's all I talked about during the presentation. If you're interested in making more powerful physical computing devices easier to use, email me at brandon at rascalmicro. If complete sentences aren't your style, try me [@rascalmicro][29].

[1]: http://thingm.com/about-us/team/mike-kuniavsky.html
[2]: http://sketching11.com
[3]: http://dam.mellis.org/
[4]: http://gumstix.com
[5]: http://beagleboard.org
[6]: http://en.wikipedia.org/wiki/Black_Sea_deluge_theory
[7]: http://bjoern.org/
[8]: http://rubyonrails.org/
[9]: https://www.djangoproject.com/
[10]: /blog/2011/07/06/self-serve-programming-tools/
[11]: http://www.parallax.com/tabid/295/Default.aspx
[12]: http://arduino.cc
[13]: http://zeroconf.org/
[14]: http://www.apple.com/support/bonjour/
[15]: https://twitter.com/#!/carladiana_/status/97676155359989761
[16]: http://avahi.org/
[17]: http://support.apple.com/kb/DL999
[18]: http://www.polarcloud.com/tomato
[19]: http://www.dd-wrt.com/site/index
[20]: http://www.chiark.greenend.org.uk/~sgtatham/putty/
[21]: https://github.com/rascalmicro/control-freak
[22]: http://mbed.org/
[23]: http://twistedmatrix.com/trac/
[24]: http://jquery.com/
[25]: http://codemirror.net
[26]: http://abeautifulsite.net/blog/2008/03/jquery-file-tree/
[27]: https://yaler.net/
[28]: https://secure.logmein.com/products/hamachi/
[29]: https://twitter.com/#!/rascalmicro
[30]: /files/presentations/2011-07-31-sketching11-weird-stuff-to-the-internet.pdf
