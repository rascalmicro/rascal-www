## Basic tutorial: Pytronics ##

Pytronics is a Python library that allows you control the Rascal hardware, like digital pins and serial ports. The [code reference][2] lists the available functions, while this tutorial gives basic usage examples. If you need more detail, you can also read the [Pytronics source code itself][3].

## Manipulating pins ##

Most of the pins on the Rascal are digital, meaning that they can switch back and forth between 3.3 V and 0 V, but can't linger in between. There are also 4 special analog pins that can read voltages in between 3.3 V and 0 V. (There are no pins on the Rascal that are analog *outputs*, but something like the [Adafruit audio shield][1] might work.)

Each pin has a name. The list of legal names and their location on the Rascal can be found on the [pinout page][4].

There are two ways to affect digital pins. You need to pass each function a pin name in quotes so it knows which pin you want to affect.
$$code(lang=python)
digitalWrite(pin, 'HIGH)
digitalWrite(pin, 'LOW')
$$/code

Here are a couple of examples:
$$code(lang=python)
from pytronics import *
digitalWrite('2', 'HIGH') # This makes pin 2 output 3.3 V.
digitalWrite('11', 'LOW') # This makes pin 11 output 0 V.
$$/code

## Serial communication ##

The Rascal has 3 serial ports.
$$code(lang=python)
serialWrite(text, speed=19200, port='1')
$$/code

The function <code>serialWrite()</code> defaults to 19200 bps on port 1 (pins 0 and 1). You can pass it speed and port parameters if you want to transmit at a different speed or on a different port.

## I<sup>2</sup>C communication ##

I<sup>2</sup>C is a digital communication bus that can be used to talk to many different devices at once. Some people call it "TWI" because Philips' semiconductor division (now NXP), which invented the bus has a history of litigious behavior. Their [patent][5] has expired, but they still have a trademark on the name. "TWI" stands for "two-wire interface," even though the bus uses 3 wires (clock, data, and ground).
$$code(lang=python)
i2cWrite(chip_address, data_address, byte_to_write, 'B')
$$/code

## SPI communication

SPI is another digital communication bus. It's similar to I<sup>2</sup>C in that it has a data and clock line. The differences are that an I<sup>2</sup>C bus uses a single, bidirectional line for data and each device on the bus has a unique address, while SPI has a dedicated line for transmitting and another for receiving, and addressing happens with chip select lines. The Rascal has 4 chip select lines, so it can talk to a maximum of 4 SPI devices. (Yes, you could get tricky with digital I/O and a multiplexer.)
$$code(lang=python)
spiWrite(data, channel='0')
$$/code
[1]: http://www.adafruit.com/products/94
[2]: /docs/rascal-api.html
[3]: https://github.com/rascalmicro/pytronics/blob/master/pytronics.py
[4]: /docs/pinout.html
[5]: http://www.google.com/patents/US4689740