## Basic tutorial: making the Rascal dance with text messages ##

Twilio is a web service that allows you to send and receive phone calls and text messages through the internet. I'm working on a larger Rascal-Twilio project that's still developing, but I wanted to demonstrate one element of it now, because it's cool. Using Twilio, I've set up a Rascal such that if I text the name of a color, like "blue," to a certain number, the Rascal will receive that text and change a BlinkM LED to the color sent.

Here's a quick video that shows the system in operation.

<iframe class="span10"src="http://player.vimeo.com/video/31884547?title=0&amp;byline=0&amp;portrait=0&amp;color=C6433C" height="461" frameborder="0" webkitAllowFullScreen allowFullScreen></iframe>

Twilio has good instructions for setting up a trial account. Here are some details:

* If you set up a trial account with Twilio, your first $30 of text messages (that's 3000 messages at $0.01 each) are free.
* When you're using the Twilio sandbox, you have to start your text message with an eight digit "sandbox PIN", so Twilio knows who to route the message to. After you upgrade your account, which is still free for the first 3000 messages, you don't need the PIN prefix any more.

When Twilio receives a text message to your number, one of their servers will make an HTTP POST request to an address that you specify in the [Twilio dashboard][1] in the <code>SMS URL</code> field. You must create and log into your account before you can get to your dashboard.

## Processing the data from Twilio ##

The HTTP POST request from Twilio will come with some data attached. From [the full list of what data Twilio sends when you receive an SMS][2], I'm just interested in the "Body" field, which contains the message itself. To respond to the POST request, I'll add some Python code to <code>server.py</code>. The code has three main steps.

1. <code>color = webcolors.name_to_rgb(request.form['Body'])</code> pulls the body of the text message out of the POST request and uses the [Python webcolors library][3] to convert the message text to an RGB color. By default, any color from [the list of named CSS3 colors][4] can be translated by webcolors.
2. The next line, <code>cmd = 'blinkm set-rgb -d 9 -r ' + str(color\[0\]) + ' -g ' + str(color\[1\]) + ' -b ' + str(color\[2\])</code>, takes the R, G, and B values and stuffs them into a command line that calls the [Blinkm command-line tool][5] written by Scott Ellis, which is included in the Rascal. This talks to the BlinkM LED using the Rascal's I<sup>2</sup>C bus.
3. <code>subprocess.Popen([cmd], shell=True)</code> executes the Blinkm command on the Rascal.

Here's the Python code.
$$code(lang=python)
@public.route('/sms', methods=['POST'])
def parse_sms():
    import subprocess, webcolors
    color = webcolors.name_to_rgb(request.form['Body'])
    cmd = 'blinkm set-rgb -d 9 -r ' + str(color\[0\]) + ' -g ' + str(color\[1\]) + ' -b ' + str(color\[2\])
    subprocess.Popen([cmd], shell=True)
    return ('color sent to Blinkm')
$$/code

One other note: to run the code above, you'll need to install the webcolors library. If you can SSH into the Rascal, it's as easy as <code>pip install webcolors</code>. If not, it's slightly more complicated, but it will be installed by default on all Rascals in the future. Let us know if you're stuck on this.

If you find errors in this tutorial, please drop a note in the [forums][6], and we'll fix it up.

[1]: https://www.twilio.com/user/account
[2]: http://www.twilio.com/docs/api/twiml/sms/twilio_request
[3]: http://pypi.python.org/pypi/webcolors/
[4]: http://xilize.sourceforge.net/Reference/colorref.html
[5]: https://github.com/scottellis/overo-blinkm
[6]: /forum/
