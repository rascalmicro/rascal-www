(This tutorial isn't finished yet.)

The idea is to demonstrate the Rascal sending characters to a [serial-enabled LCD][1] manufactured by Sparkfun.

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
        <textarea rows="2" cols="16" id="serial_text" name="serial_text" type="textarea" style="border:10px;border-color:#E7E8E9;border-style:solid;margin-top:10px;margin-bottom:10px;font-family:'VT323', 'Courier', sans-serif;font-size:100px;background-color:#111111;color:#A4211A"></textarea><br />
        <input id="send-to-lcd" type="button" value="Send to LCD" class="large blue awesome" alt="Send to LCD" style="margin-left:590px">
        <input id="clear-lcd" type="button" value="Clear LCD" class="large red awesome" alt="ON" style="position:absolute;margin-top:292px">
    </div>
    <script language="javascript" type="text/javascript">
    $("#send-to-lcd").click( function() {
        $.post("/send-to-lcd", { serial_text: $("#serial_text").val() });
    });
    $("#clear-lcd").click( function() {
        $.post("/clear-lcd");
    });
    </script>
</body>
</html>
$$/code

[1]: http://www.sparkfun.com/products/9068
