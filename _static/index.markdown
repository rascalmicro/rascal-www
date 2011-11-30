# Documentation and tutorials #

The Rascal is a small, open-source computer designed for connecting sensors, motors, and whatever else you can build to the internet. It's about 5 cm x 10 cm (2 inches by 4 inches).

<img src="/img/rascal-0.6-beta-2011-02-26.jpg" alt="The Rascal" width="820px">

## Basic tutorials: building stuff with the Rascal ##

These are a good place to start if you are new to the Rascal.

* [Getting started][4]: plugging the Rascal in and using its built-in web editor
* [Digital control][7]: turning stuff on and off through the web
* [Serial communication][8]: sending messages out the serial port
* [Graphing analog sensor data][9]: connecting a temperature sensor to the Rascal
* [Text messages and tri-color LEDs][15]: Twilio, I<sup>2</sup>C to a BlinkM, and the Rascal

## Advanced tutorials: how the Rascal works under the hood ##

If you understand the basic usage of the Rascal, you might want to know how it works inside. The list below contains highly technical documents that are not intended for normal people. If you think you're trying to do something simple with the Rascal, they will likely be useless to you. On the other hand, if you're intending to soar over the mountains, pursuing things unattempted yet in Python or Ruby, we hide nothing from view.

* [Guts of the software][1]
* [Build a new system image][2]
* [Putting a new filesystem onto a microSD card][12]
* Blog post: [Toggling pins on the AT91SAM9G20 with U-boot][5]
* Blog post: [Reprogramming the Rascal's serial flash with JTAG][6]

## Reference documents ##

Reference documents are the crack cocaine of documentation-- pure facts flooding directly to your brain.

* [Pytronics code reference][11]
* [Rascal pinout][13]

## Hardware and software sources ##

All of the Rascal hardware and software is open source. For the code, hardware design files, and some precompiled binaries, check the [sources][3] page.

[1]: /docs/software-guts.html
[2]: /docs/build-guide.html
[3]: /docs/sources.html
[4]: /docs/basic-tutorial-getting-started.html
[5]: /blog/2011/01/07/toggling-pins-on-the-at91sam9g20-with-u-boot/
[6]: /blog/2010/09/28/rascal-0.3-in-the-works/
[7]: /docs/basic-tutorial-digital-control.html
[8]: /docs/basic-tutorial-serial-communication.html
[9]: /docs/basic-tutorial-reading-sensors.html
[10]: /docs/basic-tutorial-controlling-motors.html
[11]: /docs/pytronics-code-reference.html
[12]: /docs/advanced-tutorial-new-filesystem-onto-microsd-card.html
[13]: /docs/pinout.html
[14]: /docs/basic-tutorial-getting-started-even-more.html
[15]: /docs/basic-tutorial-responding-to-text-messages.html
[16]: /docs/basic-tutorial-pytronics.html
