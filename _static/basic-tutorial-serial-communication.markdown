(This tutorial isn't finished yet.)

The Rascal has three serial ports, which can be used to send digital signals to other devices. This tutorial explains how to make the Rascal send text to a [serial-enabled LCD][1] manufactured by Sparkfun. The basic idea is to capture the text you want to send in a text field on a web page, send it to the Rascal, and then use the Pytronics <code>send_serial</code> function to transfer the text to the LCD.

Here's the hardware setup-- the aforementioned Sparkfun LCD with three wires connecting it to the Rascal.
<img src="http://rascalmicro.com/img/lcd-and-rascal.jpg">

The table below shows how the three wires (power, ground, and data) are connected between the Rascal and the LCD. The LCD gets power from the 5 V regulator onboard the Rascal.
<table class="zebra">
    <tr><th>Rascal</th><th>LCD</th></tr>
    <tr><td>GND</td><td>GND</td></tr>
    <tr><td>3.3V</td><td>5V (mislabeled on 3.3 V LCDs)</td></tr>
    <tr><td>TX (pin 1)</td><td>RX</td></tr>
</table>

The web page needs two elements-- a text field and a button for sending the text. We can create the text field with a <code>textarea</code> element.
$$code(lang=html)
<textarea rows="2" cols="16" id="serial_text"></textarea>
$$/code

The function of <code>rows</code> and <code>columns</code> is to set the size of the field. We use the <code>id</code> attribute for changing the appearance of the field with CSS.
$$code(lang=html)
<input id="send-to-lcd" type="button" value="Send to LCD" class="large blue awesome" alt="Send to LCD">
<input id="clear-lcd" type="button" value="Clear LCD" class="large red awesome" alt="Clear LCD">
$$/code

Here's the full page.
$$code(lang=html)
<html>
<head>
    <meta charset="utf-8">
    <title>LCD demo</title>
    <link rel="stylesheet" type="text/css" href="/static/demo.css">
    <link rel="shortcut icon" href="/static/favicon.ico">
    <script src="/static/jquery-1.5.js"></script>
</head>
<body>
    <div class="rascalcontent">
        <h1><a href="/lcd.html">LCD demo</a></h1>
        <p>Enter some text to send to the LCD display</p><br />
        <textarea rows="2" cols="16" id="serial-text"></textarea><br />
        <input id="send-to-lcd" type="button" value="Send to LCD" class="large blue awesome" alt="Send to LCD">
        <input id="clear-lcd" type="button" value="Clear LCD" class="large red awesome" alt="Clear LCD">
    </div>
    <script language="javascript" type="text/javascript">
    $("#send-to-lcd").click( function() {
        $.post("/send-to-lcd", { serial_text: $("#serial-text").val() });
    });
    $("#clear-lcd").click( function() {
        $.post("/clear-lcd");
    });
    </script>
</body>
</html>
$$/code

Here's the Python.
$$code(lang=python)
@public.route('/send-to-lcd', methods=['POST'])
def send_to_lcd():
    import pytronics
    pytronics.send_serial(request.form['serial_text'], 9600)
    return render_template('/lcd.html')
@public.route('/clear-lcd', methods=['POST'])
def clear_lcd():
    import pytronics
    pytronics.send_serial(chr(0xFE) + chr(0x01), 9600)
    return render_template('/lcd.html')
$$/code

[1]: http://www.sparkfun.com/products/9068
