# Pytronics #

Pytronics is a Python library used to control the electronic hardware on the Rascal. It closely mirrors the [library of functions used by the Arduino][1]. This page describes the Pytronics functions available for use in response to web requests. If you need more detail, try looking at the [Pytronics code][2] itself.

## Summary of useful URLs (coming in Cooties software release)##

The parts with angle brackets, like &lt;analog pin&gt;, mean "substitute a number in here."

The sections in braces, like { data: &lt;data&gt; } mean "pass JSON with your request that looks like this."

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr><th>Name</th><th>Request</th><th>URL</th></tr>
    </thead>
    <tbody>
        <tr><td>analog read</td><td>GET</td><td>/analog/read/&lt;analog pin&gt;</tr></tr>
        <tr class="error"><td>analog write</td><td>POST</td><td>(can't actually do this with current Rascal kernel)</tr></tr>
        <tr><td>digital read</td><td>GET</td><td>/digital/read/&lt;pin&gt;</tr></tr>
        <tr><td>digital write</td><td>POST</td><td>/digital/write/&lt;pin&gt;, { data: &lt;data&gt; }</tr></tr>
        <tr><td>I<sup>2</sup>C read</td><td>GET</td><td>/i2c/read/&lt;addr&gt;/&lt;reg&gt;/&lt;num_bytes&gt;</tr></tr>
        <tr><td>I<sup>2</sup>C write</td><td>POST</td><td>/i2c/write/&lt;addr&gt;/&lt;reg&gt;, { data: &lt;data&gt; }</tr></tr>
        <tr><td>serial read</td><td>GET</td><td>/serial/read/&lt;channel&gt;/&lt;speed&gt;/&lt;num_bytes&gt;</tr></tr>
        <tr><td>serial write</td><td>POST</td><td>/serial/write/&lt;channel&gt;/&lt;speed&gt;, { data: &lt;data&gt; }</tr></tr>
        <tr><td>SPI read</td><td>GET</td><td>/spi/read/&lt;channel&gt;/&lt;speed&gt;/&lt;num_bytes&gt;</tr></tr>
        <tr><td>SPI write</td><td>POST</td><td>/spi/write/&lt;channel&gt;/&lt;speed&gt;, { data: &lt;data&gt; }</tr></tr>
    </tbody>
</table>

## Other useful URLs (coming in Cooties software release) ##

Shortcuts

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr><th>Name</th><th>Request</th><th>URL</th></tr>
    </thead>
    <tbody>
        <tr><td>digital toggle</td><td>GET or POST</td><td>/digital/toggle/&lt;pin&gt;</tr></tr>
        <tr><td>digital write shortcut</td><td>GET or POST</td><td>/digital/write/&lt;pin&gt;/&lt;state&gt;</tr></tr>
    </tbody>
</table>

BlinkM smart LED

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr><th>Name</th><th>Request</th><th>URL</th></tr>
    </thead>
    <tbody>
        <tr><td>set hue, saturation and brightness</td><td>GET or POST</td><td>/blinkm/&lt;address&gt;/hsb/&lt;hue&gt;/&lt;saturation&gt;/&lt;brightness&gt;</tr></tr>
        <tr><td>get hue, saturation and brightness </td><td>GET or POST</td><td>/blinkm/&lt;address&gt;/hsb</tr></tr>
    </tbody>
</table>

4D Systems PICASO microLCDs

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr><th>Name</th><th>Request</th><th>URL</th></tr>
    </thead>
    <tbody>
        <tr><td>clear LCD</td><td>GET or POST</td><td>/fd/clear-lcd</tr></tr>
        <tr><td>draw filled rectangle</td><td>GET or POST</td><td>/fd/draw-filled-rectangle/&lt;x1&gt;/&lt;y1&gt;/&lt;x2&gt;/&lt;y2&gt;/&lt;color&gt;</tr></tr>
    </tbody>
</table>

Rascal Micro precision voltage shield

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr><th>Name</th><th>Request</th><th>URL</th></tr>
    </thead>
    <tbody>
        <tr><td>reset shield</td><td>GET or POST</td><td>/pvs/reset</tr></tr>
        <tr><td>read voltages</td><td>GET or POST</td><td>/pvs/read</tr></tr>
    </tbody>
</table>

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

The function <code>i2cWrite()</code> sends one or more bytes onto the [I<sup>2</sup>C][3] bus.

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

 * <code>text</code> String consisting of characters to be sent. Truncated after 80 characters.
 * <code>speed</code> (optional) Integer. Defaults to 19200.
 * <code>port</code> (optional) String ('1', '2', or '3'). Defaults to '1'.

*Return type*

Returns <code>None</code>

### spiWrite(data, channel='0') ###

The function <code>spiWrite()</code> sends data over one of the Rascal's four [SPI][4] channels. The maximum speed of the SPI port is limited in the kernel driver to 14.67 MHz, but can be decreased with an ioctl call that hasn't been sorted out yet.

*Parameters*

 * <code>data</code> Integer or string to be sent.
 * <code>channel</code> (optional) String representing SPI channel to use ('0', '1', '2', or '3'). Defaults to '0'.

*Return type*

Returns <code>None</code>

[1]: http://arduino.cc/en/Reference/HomePage
[2]: https://github.com/rascalmicro/pytronics/blob/master/pytronics.py
[3]: https://en.wikipedia.org/wiki/I2C
[4]: https://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus