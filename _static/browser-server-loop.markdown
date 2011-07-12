## How data travels back and forth between your browser and the Rascal ##

The Rascal runs a webserver that can execute Python code on your behalf. The main user interface to the Rascal is your web browser, which talks to the Rascal's webserver.

Let's suppose you want to send some data out the serial port to, for example, an Arduino shield that you had plugged into the Rascal. You'd start by creating a short HTML page that contains a form where you can type in whatever you want to send, along with a button that submits the form to the Rascal. (The form could also be submitted asynchronously with Javascript, but let's keep it simple for now-- you press the button; the data gets sent to the Rascal.)

Here's what that might look like, roughly speaking:
$$code(lang=html)
<html> 
<head> 
    <title>Rascal demo</title>
</head> 
<body> 
    <form id="serial_form" method="POST" action="send_to_shield"> 
        <textarea id="serial_text" name="serial_text" type="textarea"></textarea> 
        <button type="submit" alt="Send serial data"> 
            Send data
        </button> 
    </form> 
</body> 
</html>
$$/code

Notice that in the opening HTML form tag, it says:
$$code(lang=html)
method="POST" action="send_to_shield"
$$/code

These two attributes tell the Rascal what to do with the data it finds in the form.

## What happens on the Rascal ##

The Rascal is running a webserver that is set up to execute Python for you. If you look in /var/www/demo.py, you'll see this:
$$code(lang=python)
@app.route('/send_to_shield', methods=['POST'])
def write_serial():
    rascal.send_serial(request.form['serial_text'])
    return render_template('/serial.html')
$$/code

This calls the Pytronics function "send_serial" with the form data that has id="serial_text." If you look back at the HTML we wrote earlier, you'll see that the textarea has that id:
$$code(lang=bash)
id="serial_text"
$$/code

