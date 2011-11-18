(This tutorial is incomplete.)

## Manipulating pins ##

Most of the pins on the Rascal are digital, meaning that they can switch back and forth between 3.3 V and 0 V, but can't linger in between. There are also 4 special analog pins that can read voltages in between 3.3 V and 0 V. (There are no pins on the Rascal that are analog *outputs*, but something like the [Adafruit audio shield][1] might work.)

Each pin has a name. Here's the list of legal names:

<table class="zebra">
    <tr><th>Pin names</th><th>Number in sysfs</th><th>Name in AT91 datasheet</th><th>Function</th></tr>
    <tr><td>'0'</td><td>69</td><td>PB5</td><td>digital I/O</td></tr>
    <tr><td>'1'</td><td>68</td><td>PB4</td><td>digital I/O</td></tr>
    <tr><td>'2'</td><td>71</td><td>PB7</td><td>digital I/O</td></tr>
    <tr><td>'3'</td><td>70</td><td>PB6</td><td>digital I/O</td></tr>
    <tr><td>'4'</td><td>73</td><td>PB9</td><td>digital I/O</td></tr>
    <tr><td>'5'</td><td>72</td><td>PB8</td><td>digital I/O</td></tr>
    <tr><td>'6'</td><td>55</td><td>PA23</td><td>digital I/O</td></tr>
    <tr><td>'7'</td><td>56</td><td>PA24</td><td>digital I/O</td></tr>
    <tr><td>'8'</td><td>100</td><td>PC4</td><td>digital I/O</td></tr>
    <tr><td>'9'</td><td>101</td><td>PC5</td><td>digital I/O</td></tr>
    <tr><td>'10'</td><td>67</td><td>PB3</td><td>digital I/O</td></tr>
    <tr><td>'11'</td><td>65</td><td>PB1</td><td>digital I/O</td></tr>
    <tr><td>'12'</td><td>64</td><td>PB0</td><td>digital I/O</td></tr>
    <tr><td>'13'</td><td>66</td><td>PB2</td><td>digital I/O</td></tr>
    <tr><td>'A0'</td><td>96</td><td>PC0</td><td>analog input</td></tr>
    <tr><td>'A1'</td><td>97</td><td>PC1</td><td>analog input</td></tr>
    <tr><td>'A2'</td><td>98</td><td>PC2</td><td>analog input</td></tr>
    <tr><td>'A3'</td><td>99</td><td>PC3</td><td>analog input</td></tr>
    <tr><td>'LED'</td><td>107</td><td>PC11</td><td>digital I/O (hooked to LED on Rascal)</td></tr>
</table>

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

[1]: http://www.adafruit.com/products/94