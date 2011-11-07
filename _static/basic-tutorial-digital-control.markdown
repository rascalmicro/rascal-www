(This tutorial is not done yet.)

We grow tomatoes in pots in our backyard in the summer. A couple of years ago, I built a basic irrigation system using a crappy battery-powered sprinkler controller. For the next iteration, I want to be able to turn the sprinkler on and off through the internet, using the Rascal. Eventually, I'd like to add a moisture sensor as well, but to keep this tutorial simple, I'll just cover turning the sprinkler valve on and off for now. Also, I'm going to skip the irrigation plumbing.

## Figuring out the electrical setup ##

I don't know much about sprinkler valves, but I figure they're pretty well commodified by now, so I started at Amazon.com. After looking at a few, it looks like most run off 24 V AC transformers. This is slightly weird in the electronics world-- most low power stuff runs off DC, rather than AC, but AC supplies are cheaper and will do the job needed of triggering a valve, so that's what sprinklers use. A little more hunting on Amazon yields a [24 V AC power supply][2]. I chose [this sprinkler valve][1] because it is cheap, but looked sturdy. The transformer also won on cheapness. The transformer is rated for 40 VA, but the sprinkler valve doesn't appear to have any public electrical specifications more precise than "low-voltage solenoid," so I took a small risk that this wouldn't work. (Fortunately, they do work correctly together.)

With the valve and power supply sorted out, I just have to figure out how to connect and disconnect the two using a relay controlled by a digital pin on the Rascal.

## Adding a relay to the circuit ##

I'm using a partially assembled Rascal Developers' Shield designed by my friend Mike, but I believe this would work with any Arduino relay shield that can handle 3.3 V inputs. You could also use a relay kit like the one used in Sparkfun's [controllable power outlet tutorial][3]

But I don't have one of those right now, so here's what my circuit looks like.

<img src="http://rascalmicro.com/img/sprinkler-circuit.jpg" width="900px">

## Software control of the relay, and thereby the valve ##

Now that I have the valve connected to the Rascal via the shield, I'll create a new template in the code editor called sprinkler.html. Here's what that looks like, before I customize the code.

<img src="http://rascalmicro.com/img/sprinkler-template-screenshot.png" width="900px">

I'll add this code to the page, which will create two buttons, one labeled "ON" and one labeled "OFF".
$$code(lang=html)
<input id="sprinkler-on" type="button" value="ON" class="large red awesome" alt="ON">
<input id="sprinkler-off" type="button" value="OFF" class="large red awesome" alt="OFF">
$$/code

Then, I'll add some Javascript that will use jQuery to send requests to the Rascal when the buttons are clicked.
$$code(lang=javascript)
$("#sprinkler-on").click( function() {
    $.post("/sprinkler-on");
});
$("#sprinkler-off").click( function() {
    $.post("/sprinkler-off");
});
$$/code

Finally, I'll edit server.py in the Rascal editor, so that it knows how to respond to the requests triggered by the buttons.
$$code(lang=python)
@public.route('/sprinkler-on', methods=['POST'])
def sprinkler_on():
    import pytronics
    pytronics.set_pin_high(2)
    return ('Sprinkler on')
@public.route('/sprinkler-off', methods=['POST'])
def sprinkler_off():
    import pytronics
    pytronics.set_pin_low(2)
    return ('Sprinkler off')
$$/code

[1]: http://www.amazon.com/Orbit-57100-4-Inch-Threaded-Sprinkler/dp/B00004S1V2/
[2]: http://www.amazon.com/Class-II-Transformer-Approved-MGT-2440/dp/B004VMVDTA/
[3]: http://www.sparkfun.com/tutorials/119
