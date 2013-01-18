---
format: markdown
date: 2013/01/18 00:00:00
title: Interactive public art on Boston's Greenway
categories: rascal
---
<img src="/img/light-blades-opening-2013-01-10.jpg">
##### The opening event at the light blades. I'm the guy on the stage in the hat. #####

The Rose Kennedy Greenway is a 15 acre park that was created in 2008 when route 93, the main highway through Boston, was put underground. In the middle of the Greenway, there is a fountain flanked by 12 steel light sculptures, called the light blades.

Over the last year, I've been working with a public artist here in Somerville, Dan Sternof Beyer, to use the Rascal to make the light blades controllable from anyone's cell phone via text message.

Last Thursday night, the Greenway Conservancy held an event to unveil the phone number (917-525-2337). Between now and sometime in mid-March 2013, you can text the name of a color to that number, and the blades will obey your command. Dan put together the video below, which shows a few clips from the opening and the blades in action.

<iframe class="span14" src="http://player.vimeo.com/video/57427317?title=0&amp;byline=0&amp;color=C6433C" width="820" height="461" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

### Technical overview ###

At the heart of the project is a Rascal, installed in a subterranean vault under the street near the light blades. The Rascal is listening for text messages forwarded across the internet by Twilio, a cloud communication service. The diagram below shows the full technology stack.

<img src="/img/light-blades-overview.png" width="820px">

### The code ###

The Rascal hosts its own code editor and web framework, based around [CodeMirror][3] and [Flask][4]. The crux of the code is below. (The list of colors is shortened here because it's boring. The [full Color Commons code][1] is up on Github.)

When a message arrives, the Rascal looks it up in a dictionary of colors. (The first ~200 colors or so came from the Python webcolors library, but we added more since then, along with some easter eggs.) If the color can't be found in the dictionary, the Rascal picks a show to run at random. Once a show is selected, the Rascal uses the RS-232 shield plugged into it to talk to the Color Kinetics iPlayer, which talks to the light fixtures using DMX.
$$code(lang=python)
@public.route('/sms', methods=['POST'])
def control_lights():
    d = {'airforceblue': '11',
        'airsuperiorityblue': '11',
        'aliceblue': '16',
        'amaranth': '29' 
    } # dictionary of colors severely truncated
    message = request.form['Body']
    # print writes to the webserver log
    print "Received text message: " + str(message)
    try:
        # normalize and look up the message
        program = int(d[message[0:25].lower().replace(' ', '')])
    except KeyError:
        # pick a random show if we don't understand the message
        print 'color {0} not found'.format(message)
        program = random.randint(10,98)
    # translate the message to a hex show command
    command = 'X04%(number)2.2X' % {"number": program}
    print 'Translated {0} to {1}'.format(message, command)
    # validate the command, just to be double-sure
    if (command in allowed_commands):
        # tell the iPlayer to start the show
        pytronics.serialWrite(command, speed=9600)
    else:
        print "Command {0} is not one of the allowed commands.".format(command)
        command = 'FAIL'
    return('<?xml version="1.0" encoding="UTF-8"?><Response>{0}</Response>'.format(command))
$$/code

### A persistent encrypted connection for public art ###

The hardest part of getting the light blades to respond to text messages was figuring out the network connection. We initially hoped that the Boston Fiber Network would allow us to forward incoming requests from Twilio across their network, but they were worried about the security implications and refused. They suggested that we use a proprietary VPN connection on the Greenway's public wifi network to a Greenway office instead. We got that working on an old Linux server, but the connection was not reliable. In the end, we used a reverse SSH tunnel to an external Linux server, using AutoSSH to make it reliable. The result was that even though the wifi drops out from time to time, the connection has survived for the last month and approximately 3000 text messages so far.

Some more technical details about the Rascal and AutoSSH are on the [light blades project][2] page.

### Open invitation ###

If you are interested in making interactive public art like the light blades, please email brandon@rascalmicro.com. We would love to make cell phones into your city's remote control. We're always short on time and money, but we're happy to talk stuff over and point you in the right direction.

[1]: https://gist.github.com/4494118
[2]: http://rascalmicro.com/docs/project-light-blades.html
[3]: http://codemirror.net
[4]: http://flask.pocoo.org/