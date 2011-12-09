## Basic tutorial: Pytronics ##

Pytronics is a Python library that allows you control the Rascal hardware, like digital pins and serial ports. The [code reference][2] lists the available functions, while this tutorial gives basic usage examples. If you need more detail, you can also read the [Pytronics source code itself][3].

## Manipulating pins ##

Most of the pins on the Rascal are digital, meaning that they can switch back and forth between 3.3 V and 0 V, but can't linger in between. There are also 4 special analog pins that can read voltages in between 3.3 V and 0 V. (There are no pins on the Rascal that are analog *outputs*, but something like the [Adafruit audio shield][1] might work.)

Each pin has a name. The list of legal names and their location on the Rascal can be found on the [pinout page][4].

There are two functions for controlling digital pins. You need to pass each function a pin name in quotes so it knows which pin you want to affect.
$$code(lang=python)
set_pin_high()
set_pin_low()
$$/code

Here are a couple of examples:
$$code(lang=python)
from pytronics import *
set_pin_high('2') # This makes pin 2 output 3.3 V.
set_pin_low('11') # This makes pin 11 output 0 V.
$$/code

## Serial communication ##

The Rascal has 3 serial ports.
$$code(lang=python)
send_serial(text, speed=19200, port='1')
$$/code

The function <code>send_serial()</code> defaults to 19200 bps on port 1 (pins 0 and 1). You can pass it speed and port parameters if you want to transmit at a different speed or on a different port.

## I<sup>2</sup>C communication ##

This code doesn't actually exist yet. In the meantime, you can use the Python <code>subprocess</code> module and the command line tools <code>i2cget</code> and <code>i2cset</code> to fake it.

[1]: http://www.adafruit.com/products/94
[2]: /docs/pytronics-code-reference.html
[3]: https://github.com/rascalmicro/pytronics/blob/master/pytronics.py
[4]: /docs/pinout.html