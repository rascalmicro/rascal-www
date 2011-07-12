This is a description of the most useful Pytronics functions. If you need more detail, try looking at the [Pytronics code][1] itself.

## Manipulating pins ##

Most of the pins on the Rascal are digital, meaning that they can switch back and forth between 3.3 V and 0 V, but can't linger in between. There are also 4 special analog pins that can read voltages in between 3.3 V and 0 V. (There are no pins on the Rascal that are analog *outputs*, but something like the [Adafruit audio shield][2] might work.)

Each pin has a name. Here's the list of legal names:
$$code(lang=python)
'0'
'1'
'2'
'3'
'4'
'5'
'6'
'7'
'8'
'9'
'10'
'11'
'12'
'13'
    # The next four are the analog pins.
'A0' 
'A1'
'A2'
'A3'
    # This last one is for the LED labelled D4, which is just on the Rascal for fun.
'LED'
$$/code

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

[1]: https://github.com/rascalmicro/pytronics/blob/master/rascal.py
[2]: http://www.adafruit.com/products/94
