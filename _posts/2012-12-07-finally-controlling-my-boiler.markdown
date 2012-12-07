---
format: markdown
date: 2012/12/07 00:00:00
title: Finally controlling my boiler with a Rascal
categories: rascal
---
I hit a personal milestone today, but I have to tell a little of the backstory for it to make sense.

Back in early 2010, while working as an embedded systems engineer at a company that subsequently failed, I built a web-based thermostat using an off-the-shelf Linux board. It took 5 days of mucking around with kernel drivers, Python, and Django to get the web framework and the hardware underpinnings installed and working correctly. After that, it took just a couple of hours to write a Python script that looked at the temperature in the house, turned the boiler on or off appropriately, and displayed the operational history in a pretty graph.

When I was done, I thought, "Man, I wish I could have just bought a Linux board with all that stuff preconfigured, and started on the thermostat code 5 days earlier." That was the day that I decided to build the Rascal.

### The milestone ###

Now, 2.5 years later, the Rascal has reached a level of maturity where <b>I can actually use it as a platform for efficient development of web-based systems.</b> (Hey, if I use Rascals for 255 more projects in the next year, each saving 5 days of effort, I will break even on the time invested!)

Yesterday, I finally installed a Rascal as a thermostat in our basement and, following the new Rascal [DIY thermostat tutorial][1], made it pull target temperatures from my Google calendar. Using Twilio, I can also send temporary overrides via text messages, so I can warm the house up right before I get home (JIT house warming, if you will). This morning, sitting in a cafe in Davis Square, I was able to check on my iPhone's web browser that the boiler was actually off. It felt like 2013 had arrived.

### It lives! ###

Because the Rascal's interface is web-based, you can [see my thermostat][2] too. The green line is the target temperature, which is pulled from [my Google calendar][5], and the black line is the temperature as measured in our house. If the area under the black line is red, it means the boiler is circulating hot water; if it's white, the boiler is off.

(Please close the page when you're done, as each page pulls updates from the Rascal once per second. If you would like to DDOS my home heating system, perhaps you could wait until next week when it's not so cold out. Better yet, [buy a Rascal][3] and DDOS that.)

<img src="/img/rascal-as-thermostat-in-basement.jpg" width="820px">
<h5>The Rascal, with a relay shield, perched on top of our cable modem in the basement. There are two relays, but I'm only using one. The 4-wire cable at the lower right talks I<sup>2</sup>C to the TMP102 temperature sensor upstairs.</h5>

<img src="/img/tmp102-temperature-sensor-installed.jpg" width="820px">
<h5>The TMP102 temperature sensor, emerging from behind a bookcase in the hallway near the kitchen</h5>

Next, I plan to add the [datalogging code][4] that a Rascal enthusiast in the UK contributed and add another sensor outside so I can see how well the house is insulated.

[1]: http://rascalmicro.com/docs/basic-tutorial-diy-thermostat.html
[2]: http://demo.rascalmicro.com:81/thermostat.html
[3]: http://store.rascalmicro.com
[4]: https://github.com/dsmall/control-freak/blob/private/public/datalogger.py
[5]: https://www.google.com/calendar/embed?src=0c3lie03m3ajg6j6numm2gf1l4%40group.calendar.google.com