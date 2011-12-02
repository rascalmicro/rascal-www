This is a description of the Pytronics functions intended for external use. If you need more detail, try looking at the [Pytronics code][1] itself.

## Functions for reading data ##

### read_pin(pin) ###
The function <code>read_pin()</code> reads the voltage on one of the Rascal's digital pins. If the voltage is below 0.8 V, <code>read_pin()</code> returns 0. If the voltage is above 2.0 V, <code>read_pin()</code> returns 1. (Note that a voltage above 3.6 V will probably damage the Rascal's pins.)

*Parameters*

 * <code>pin</code> String consisting pin name

*Return type*

Returns a string equal to either <code>'0'</code> or <code>'1'</code>.

### read_analog(pin) ###

The function <code>read_analog()</code> reads the voltage on one of the Rascal's analog inputs, scaled by the voltage on the A/D REF pin. A voltage of 0 V maps to a reading of 0. A voltage equal to or above the voltage on the A/D REF pin maps to a reading of 1023. (Note that a voltage above 3.6 V will probably damage the Rascal's pins.)

*Parameters*

 * <code>pin</code> String consisting pin name

*Return type*

Returns a string containing a number in the range 0-1023.

On error, returns "Not an analog pin. Try 'A0', 'A1', 'A2', or 'A3'."

## Functions for sending data ##

### send_serial(text, speed=19200, port='1') ###

The function <code>send_serial()</code> is used to send data out the Rascal serial ports.

*Parameters*

 * <code>text</code> String consisting of text to be sent. Truncated after 80 characters.
 * <code>speed</code> (optional) Integer. Defaults to 19200.
 * <code>port</code> (optional) String ('1', '2', or '3'). Defaults to '1'.

*Return type*

Returns <code>None</code>

### set_pin_high(pin) ###

The function <code>set_pin_high()</code> raises the voltage on one Rascal pin to 3.3 V.

*Parameters*

 * <code>pin</code> String consisting pin name

*Return type*

Returns <code>None</code>

### set_pin_low(pin) ###

The function <code>set_pin_low()</code> lowers the voltage on one Rascal pin to 0 V.

*Parameters*

 * <code>pin</code> String consisting pin name
 
*Return type*

Returns <code>None</code>

[1]: https://github.com/rascalmicro/pytronics/blob/master/pytronics.py
