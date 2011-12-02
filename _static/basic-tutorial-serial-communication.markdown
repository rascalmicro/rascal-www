## Basic tutorial: serial communication ##

The Rascal has three serial ports, which can be used to send digital signals to other devices. This tutorial explains how to make the Rascal send text to a [serial-enabled LCD][1] manufactured by Sparkfun. The basic idea is to capture the text you want to send in a text field on a web page, send it to the Rascal, and then use the Pytronics <code>send_serial</code> function to transfer the text to the LCD.

Here's the hardware setup-- the aforementioned Sparkfun LCD with three wires connecting it to the Rascal.
<img class="span14" src="/img/lcd-and-rascal.jpg">

The table below shows how the three wires (power, ground, and data) are connected between the Rascal and the LCD. The LCD gets power from the 5 V regulator onboard the Rascal.
<table class="zebra">
    <tr><th>Rascal</th><th>LCD</th></tr>
    <tr><td>GND</td><td>GND</td></tr>
    <tr><td>3.3V</td><td>5V (mislabeled on 3.3 V LCDs)</td></tr>
    <tr><td>TX (pin 1)</td><td>RX</td></tr>
</table>

## The basic page ##

The web page needs three elements-- a text field, a button for sending the text, and a button for clearing the LCD. We can create the text field with a <code>textarea</code> element.
$$code(lang=html)
<textarea rows="2" cols="16" id="serial_text"></textarea>
$$/code

The function of <code>rows</code> and <code>columns</code> is to set the size of the field. We use the <code>id</code> attribute to change the appearance of the field with CSS, but that's just cosmetic.

Below the text field, we'll make two buttons that say: "Send to LCD" and "Clear LCD". The <code>class="large blue awesome"</code> attributes access some tricky CSS that make the buttons look nice.
$$code(lang=html)
<input id="send-to-lcd" type="button" value="Send to LCD" class="large blue awesome" alt="Send to LCD">
<input id="clear-lcd" type="button" value="Clear LCD" class="large red awesome" alt="Clear LCD">
$$/code

## Making the buttons work ##

Then we use the jQuery Javascript library to determine what happens when you click the buttons. For each button, we attach a function that will issue an HTTP POST request to the Rascal. The "send-to-lcd" function will pass our text along with it in the field called <code>serial_text</code>.
$$code(lang=javascript)
$("#send-to-lcd").click( function() {
    $.post("/send-to-lcd", { serial_text: $("#serial-text").val() });
});
$("#clear-lcd").click( function() {
    $.post("/clear-lcd");
});
$$/code

Here's the full HTML page that includes the text field, the buttons, and the Javascript.
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

## The Python handlers ##

The last step is to write Python code in <code>server.py</code> on the Rascal to handle the POST requests when they arrive at the Rascal. We'll write one handler for each button. The first one, for requests to <code>/send-to-lcd</code>, pulls the text we sent out with <code>request.form['serial_text']</code> and passes it to the Pytronics function <code>send_serial</code>, along with the baud rate that our LCD uses for communication. In the case of the Sparkfun LCD we're using, this is 9600 bps.

The second handler is triggered by POSTs to <code>/clear-lcd</code>. It tells the LCD to clear itself using a special sequence of characters found in Sparkfun's documentation: 0xFE 0x01. There are a bunch of other cool special commands you can issue to the LCD that do stuff like turn on the backlight or scroll the text, but I'll leave those out for now.

Here are the two Python handlers.
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

That's it. If you find errors in this tutorial, please drop a note in the [forums][2], and we'll fix it up.

[1]: http://www.sparkfun.com/products/9068
[2]: /forum/
