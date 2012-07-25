# Pytronics #

Pytronics is a Python library used to control the electronic hardware on the Rascal. It closely mirrors the [library of functions used by the Arduino][1]. This page describes the Pytronics functions available for use in response to web requests. If you need more detail, try looking at the [Pytronics code][2] itself.

## Functions for reading data ##

### digitalRead(pin) ###
The function <code>digitalRead()</code> reads the voltage on one of the Rascal's digital pins. If the voltage is below 0.8 V, <code>digitalRead()</code> returns 0. If the voltage is above 2.0 V, <code>digitalRead()</code> returns 1. (Note that a voltage above 3.6 V will probably damage the Rascal's pins.)

*Parameters*

 * <code>pin</code> String consisting of a pin name, like '2', '3', or 'LED'

*Return type*

Returns a string equal to either <code>'0'</code> or <code>'1'</code>.

### analogRead(pin) ###

The function <code>analogRead()</code> reads the voltage on one of the Rascal's analog inputs, scaled by the voltage on the A/D REF pin. A voltage of 0 V maps to a reading of 0. A voltage equal to or above the voltage on the A/D REF pin maps to a reading of 1023. (Note that a voltage above 3.6 V will probably damage the Rascal's pins.) Voltages in between 0 and A/D REF are mapped linearly between 0 and 1023. As an example, if you connect A/D REF to 3.3 V, a voltage of 1.65 V will produce a reading halfway between 0 and 1023 (roughly 512).

*Parameters*

 * <code>pin</code> String consisting of an analog pin name, like 'A0', 'A1', 'A2', or 'A3'

*Return type*

Returns a string containing a number in the range 0-1023.

On error, returns "Not an analog pin. Try 'A0', 'A1', 'A2', or 'A3'."

### i2cRead(addr, reg = 0, size = 'B') ###

The function <code>i2cRead()</code> reads one or more bytes from a device on the I<sup>2</sup>C bus.

*Parameters*

 * <code>addr</code> Chip address
 * <code>reg</code> Memory address on chip
 * <code>size</code> 'C', 'W', 'B' or None, representing type of read requested, character, word, block, or short

*Return type*

Returns data read from device

### spiRead() ###

The function <code>spiRead()</code> is not implemented yet . . .

*Parameters*

 * <code>chip</code>

*Return type*

Returns <code>data</code>

## Functions for sending data ##

### digitalWrite(pin, state) ###

The function <code>digitalWrite()</code> sets the voltage on one Rascal pin to either 3.3 V or 0 V, depending on the value of state passed in.

*Parameters*

 * <code>pin</code> String consisting pin name
 * <code>state</code> 'HIGH' or 'LOW'

*Return type*

Returns <code>None</code>

### i2cWrite(addr, reg, val = '', size = 'B') ###

The function <code>i2cWrite()</code> sends one or more bytes onto the I<sup>2</sup>C bus.

*Parameters*

 * <code>addr</code> Chip address
 * <code>reg</code> Memory address on chip
 * <code>val</code> Data to write
 * <code>size</code> 'C', 'W', 'B' or None, representing type of write requested, character, word, block, or short

*Return type*

Returns <code>None</code>

### serialWrite(text, speed=19200, port='1') ###

The function <code>serialWrite()</code> is used to send data out the Rascal serial ports.

*Parameters*

 * <code>text</code> String consisting of text to be sent. Truncated after 80 characters.
 * <code>speed</code> (optional) Integer. Defaults to 19200.
 * <code>port</code> (optional) String ('1', '2', or '3'). Defaults to '1'.

*Return type*

Returns <code>None</code>

### spiWrite() ###

The function <code>spiWrite()</code> is not implemented yet . . .

*Parameters*

 * <code>chip</code>
 * <code>data</code>

*Return type*

Returns <code>None</code>

[1]: http://arduino.cc/en/Reference/HomePage
[2]: https://github.com/rascalmicro/pytronics/blob/master/pytronics.py
