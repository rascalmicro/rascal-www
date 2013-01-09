## Project profile: the technology behind Color Commons ##

Color Commons is an installation at the [Rose Kennedy Greenway][1] in Boston, USA. Based around the light blades sculpture, originally designed in 2008 by Dennis Carmichael of [EDAW][2] (later bought by AECOM), Color Commons makes the light blades interactive, so that anyone can change the color of the lights by sending a text message. like "purple" or "navy blue" to 917-5BL-ADES.

Color Commons uses the Rascal microcontroller to receive text messages and talk to a Color Kinetics light controller in a subterranean vault below the Greenway.

### What's innovative about the Rascal and Color Commons ###

The Rascal can receive text messages from the internet, and almost everyone in Boston these days has a phone that can send text messages. This makes a new kind of interactive art possible.

The second innovation of the Rascal's use in Color Commons is that it's operating on the Greenway's public wifi network. Quite sensibly, the Greenway protects computers on their wifi network from the dangers of the public internet, but this also would prevent the Rascal from receiving text messages. To get around this, the Rascal connects to a Rascal Micro server in a datacenter in New Jersey. This server listens to the public internet for new messages and sends them to the Rascal when they arrive.

AutoSSH is real great.

Normally, most internet connections, like the cable or DSL modem in your house, have a built-in firewall that protects your computer from crap on the internet. They work by blocking everything but responses to requests that you initiate. It's like if you order a pizza from Aaron Burr's Delicious Pizza, and then a few minutes later, a dude shows up outside your house wearing a shirt that says "Aaron Burr's Delicious Pizza", you think, "Ah, that's probably my pizza. I'll open the door." On the other hand, if you are awoken in the night by a man in a red cloak ringing the doorbell, and he's holding a handwritten sign saying "Real cheap pizza", I don't think it would be a good idea to open the door.

The interesting bit is that once you open the door and start talking to the (legitimate) pizza guy, the conversation can continue as long as you want. That's how this technique works. Your Rascal starts a conversation with a remote server. (Strictly speaking, it is a TCP connection encrypted using the SSH protocol.) After the conversation is started, both the Rascal and the remote server can continue the conversation. The server is configured to pass all traffic on a certain port directly along to your Rascal, which makes it seem like the Rascal is outside the firewall.

## Starting the reverse tunnel ##

$$code(lang=python)
@public.route('/sms', methods=['POST'])
def parse_sms():
    import subprocess, webcolors
    color = webcolors.name_to_rgb(request.form['Body'])
    cmd = 'blinkm set-rgb -d 9 -r ' + str(color\[0\]) + ' -g ' + str(color\[1\]) + ' -b ' + str(color\[2\])
    subprocess.Popen([cmd], shell=True)
    return ('color sent to Blinkm')
$$/code

[1]: http://rosekennedygreenway.org
[2]: http://aecom.com

