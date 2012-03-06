## Basic tutorial: DIY thermostat ##
(This tutorial is unfinished.)

My original reason for designing the Rascal was to make hooking the thermostat in our house to the web easier. I was working a somewhat unpredictable schedule a couple winters ago, and I wanted our house to be warm when I got home, but not at the cost of heating it all day. I built a [prototype][2] using a small industrial computer. It was expensive, but it basically worked.

Now that I have the Rascal at my disposal, I want to make a badass thermostat. Here's what my thermostat should do:

1. Pull target temperatures from recurring tasks on my Google calendar.
2. Allow me to override the calendar with text messages.
3. Show me a nice graph of temperature versus time in any modern web browser
4. The obvious: sense the house temperature and switch our gas boiler on and off.

(In the long run, I'd also like the thermostat to log all the data and give me some useful summary statistics about energy usage, but this is supposed to be a basic tutorial. Back in your chairs!)

## The hardware ##

For 

## The main loop ##

Let's start with the basic functionality-- checking the temperature and turning the heat on and off. For a temperature sensor, I'm using a [TMP102 breakout board][3] from Sparkfun. I want the Rascal to query the sensor over the I<sup>2</sup>C bus every few seconds.

The code below, added to <code>server.py</code>, does what we need. The line <code>@rbtimer(3)</code> at the beginning makes the Rascal's Python app server execute the function below every 3 seconds. (The "rb" comes from the fact that server implements the timer with [red-black trees][4].)
$$code(lang=python)
@rbtimer(3)
def update_relay(num):
    import pytronics, thermostat
    actual = float(thermostat.read_sensor(0x48)) * 1.8 + 32.0
    target = float(thermostat.get_target_temp('/var/www/public/static/basic.ics', 'America/New_York'))
    if actual < target:
        pytronics.set_pin_high(2) # Turn heat on
    else:
        pytronics.set_pin_low(2)  # Turn heat off
$$/code

The basic flow of the function is to check the sensor, then get the current target temperature. If the temperature is too low, we heat; otherwise we don't. The address <code>0x48</code> is the default I<sup>2</sup>C address for the TMP102 sensor. The <code>* 1.8 + 32.0</code> is a conversion from the sensor's native Celsius to the inferior Fahrenheit scale my American upbringing burdened me with. There's also some tricky business going on with the arguments to <code>get_target_temp</code>, but let's look at the guts of the <code>read_sensor</code> function in more detail first. I've put the code that is specific to the thermostat in a separate file, <code>thermostat.py</code>. That's where the function below comes from.
$$code(lang=python)
def read_sensor(address):
    import subprocess
    cmd = 'i2cget -y 0 ' + hex(address) + ' 0x00 w'
    subp = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    try: 
        data = int(subp.communicate()[0].strip(), 16)
    except ValueError:
        print 'Couldn\'t get reading from sensor'
        return float('NaN') # Python reserved word for "Not a number"
    return ((data % 0x0100 * 16) + (data / 0x1000)) * 0.0625
$$/code
This code is definitely on the ugly end of things, but it demonstrates a cool characteristic of the Rascal-- the ability to use Linux command line tools to get stuff done. The <code>read_sensor</code> function uses the <code>i2cget</code> command line tool and the Python <code>subprocess</code> module to ask the sensor for the temperature.

When we call this function, we pass it the hex number <code>48</code>. The <code>hex()</code> formatting function returns <code>0x48</code>, so the command we execute will be <code>i2cget -y 0 0x48 0x00 w</code>. This can be roughly translated as "Read a word of data from address 0x00 of the device at address 0x48." The authors of lm-sensors have [more documentation][7] on usage of <code>i2cget</code>.

The sensor returns the data in a funny format, so the last line converts it to a (Celsius) decimal string like <code>25.0</code>.

## Figuring out the target temperature ##

Now let's look at the code to figure out the target temperature. First, let's assume that we've set up a Google calendar with some sensible events that recur weekly. For each event, the calendar field called "summary" is the target temperature for the duration of the event. If there is no event happening, the thermostat will fall back to its default value. I have the calendar set up so that the events are during the day. At night, the thermostat falls back to my default of 56.0 degrees. The image below shows what my calendar looks like.

<img class="span14" src="/img/google-calendar-as-thermostat.png">

We want to query the calendar every so often to see what temperature we should be aiming at. For this, we have the Python code below from <code>server.py</code>, which grabs a new copy of the Google calendar every 300 seconds using the <code>urllib</code> library, which is part of the Python standard library.
$$code(lang=python)
@rbtimer(300)
def fetch_calendar(num):
    import thermostat, urllib
    urllib.urlretrieve(CALENDAR_URL, LOCAL_CALENDAR)
$$/code

Parsing the calendar file would be *really* ugly, but because people use Python for all sorts of weird stuff, an [open source iCalendar Python library][8] already exists for parsing the .ics files used by Google Calendar. We called <code>get_target_temp()</code> and passed it two strings: <code>'/var/www/public/static/basic.ics'</code> and <code>'America/New_York'</code>.
$$code(lang=python)
def get_target_temp(calendar_path, timezone_name):
    import datetime, icalendar, pytz
    f = open(TARGET_PATH, 'r')
    override = f.read()
    if (override[0:5] != 'abort'):
        return str(override)
    days = list(['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'])
    now = datetime.datetime.now(pytz.timezone(timezone_name))
    today = days[now.weekday()]
    events = icalendar.Calendar.from_string(open(calendar_path,'rb').read().walk('VEVENT')
    for event in events:
        if event_is_today(event, today) and event_is_now(event, now):
            return float(event.decoded('summary'))
    return DEFAULT_TEMPERATURE
$$/code

## The interface ##

The target temperature is controlled through the aforementioned calendar, so all the web interface has to do is show us a nice graph. We start by adding a <code>div</code> like the one below to a new page on the Rascal. 
$$code(lang=html)
<div id="chart1" style="height:500px;width:900px;"></div>
$$/code
Then, we use [jQplot][5], a Javascript library that is a jQuery plugin, to turn the <code>div</code> into a graph. The first part of the script sets up all the jQplot options.
$$code(lang=javascript)
chartOptions = {
    legend: {
        show: true,
        location: "se" },
    title: "Channel 0",
    series: [
        {label: "Actual temperature", lineWidth:3, showMarker:false},
        {label: "Target temperature", lineWidth:3, showMarker:false},
        {label: "Heater status", lineWidth:3, showMarker:false, fill: "true", fillAlpha: 0.5}
    ],
    axes: {
        xaxis: {
            label: "Time [seconds ago]",
            min: 0,
            max: 300,
            pad: 0 },
        yaxis: {
            label: "Temperature [F]",
            min: 60.0,
            max: 95.0 },
    },
    seriesColors: [ "#414243", "#08C239", "#CD2820" ]
};
$$/code

Here's what the graph looks like in action.
<img class="span14" src="/img/thermostat-in-action.png">

You can read more details about how jQplot options work in the [jQplot API documentation][6].
$$code(lang=javascript)
a0 = new Array();
a1 = new Array();
a2 = new Array();
setInterval(function() {
    $.post("/temperature", function(response) {
        data = $.parseJSON(response);
        if(a0.length > chartOptions.axes.xaxis.max) {
            a0.pop();
            a1.pop();
            a2.pop();
        }
        actual = data.actual * 1.8 + 32.0
        threshold = data.target
        a0.unshift(actual);
        a1.unshift(threshold);
        if (actual < threshold) {
            a2.unshift(actual);
        } else {
            a2.unshift(0.0);
        }
        $.jqplot("chart1", [a0, a1, a2], chartOptions).replot();
    });
}, 1000);
$$/code
$$code(lang=python)
@public.route('/temperature', methods=['POST'])
def temperature():
    import json, thermostat
    data = {
        "time" : float(time.time()),
        "actual" : float(thermostat.read_sensor(0x48)),
        "target" : thermostat.get_target_temp('/var/www/public/static/basic.ics', 'America/New_York')
    }
    return json.dumps(data)
$$/code

For testing, I set up a small power resistor as a tiny heater that I could use snugged up against the temperature sensor in a feedback loop.

<img src="/img/tmp102-resistor-feedback-loop.jpg">

If you find errors in this tutorial, please drop a note in the [forums][1], and we'll fix it up.

[1]: /forum/
[2]: http://www.flickr.com/photos/pingswept/4361956125/in/photostream/
[3]: http://www.sparkfun.com/products/9418
[4]: http://en.wikipedia.org/wiki/Red%E2%80%93black_tree
[5]: http://www.jqplot.com/
[6]: http://www.jqplot.com/docs/files/jqPlotOptions-txt.html
[7]: http://www.lm-sensors.org/wiki/man/i2cget
[8]: https://github.com/collective/icalendar