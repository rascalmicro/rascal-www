## Basic tutorial: DIY thermostat ##
(This tutorial is unfinished.)

My original reason for designing the Rascal was to make hooking the thermostat in my house to the web easier. I was working a somewhat unpredictable schedule a couple winters ago, and I wanted our house to be warm when I got home, but not at the cost of heating it all day. I built a [prototype][2] using a small industrial computer. It was expensive, but it basically worked.

Now that I have the Rascal at my disposal, I want to make a badass thermostat. Here's what my thermostat should do:

1. Pull target temperatures from my Google calendar.
2. Allow me to override the calendar with text messages.
3. Show me a nice graph of temperature versus time
4. The obvious: sense the house temperature and switch our gas boiler on and off.

(In the long run, I'd also like the thermostat to log all the data and give me some useful summary statistics about energy usage, but I haven't written that code yet.)

## The main loop ##

Let's start with the basic functionality-- checking the temperature and turning the heat on and off. For a temperature sensor, I'm using a [TMP102 breakout board][3] from Sparkfun. The Rascal talks to the sensor over the I<sup>2</sup>C bus.

The code below has the line <code>@rbtimer(3)</code> at the beginning. This is a decorator that will make the Rascal's Python app server execute the function below every 3 seconds. (The "rb" comes from the fact that server implements the timer with [red-black trees][4].)
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

The basic flow of the function is to check the sensor, then get the current target temperature. If the temperature is too low, we heat; otherwise we don't. I've put the code that is specific to the thermostat in a separate file, <code>thermostat.py</code>. Let's look at the <code>read_sensor</code> function in more detail.
$$code(lang=python)
def read_sensor(address):
    import subprocess
    cmd = 'i2cget -y 0 ' + hex(address) + ' 0x00 w'
    subp = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    data = int(subp.communicate()[0].strip(), 16)
    return ((data % 0x0100 * 16) + (data / 0x1000)) * 0.0625
$$/code
This code is definitely on the ugly end of things, but it demonstrates a cool characteristic of the Rascal-- the ability to use command line tools to get stuff done. The <code>read_sensor</code> function uses the <code>i2cget</code>
$$code(lang=html)
<div id="chart1" style="height:500px;width:900px;"></div>
$$/code
This is the web page.
$$code(lang=html)
<script language="javascript" type="text/javascript">
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
</script>
$$/code
This Python code is run by the webserver. It grabs a new copy of the Google calendar every 60 seconds. Every 3 seconds, it reads the TMP102 temperature sensor to see if the temperature is above or below the target and then turns the heater on or off accordingly.
$$code(lang=python)
@rbtimer(60)
def fetch_calendar(num):
    import thermostat
    thermostat.update_calendar_file()
    print('Calendar reload attempt')
@rbtimer(3)
def update_relay(num):
    import pytronics, thermostat
    actual = float(thermostat.read_sensor(0x48)) * 1.8 + 32.0
    target = float(thermostat.get_target_temp('/var/www/public/static/basic.ics', 'America/New_York'))
    print("Measured temperature: %f degrees. Target is %f degrees." % (actual, target))
    if actual < target:
        pytronics.set_pin_high(2)
        print("Heat on")
    else:
        pytronics.set_pin_low(2)
        print("Heat off")
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
This is the Python code for reading the sensor and checking the Google calendar for the target temperature.
$$code(lang=python)
TARGET_PATH = '/var/www/public/thermostat-target.txt'
DEFAULT_TEMPERATURE = 56.0
LOCAL_CALENDAR = '/var/www/public/static/basic.ics'
CALENDAR_URL = 'https://www.google.com/calendar/ical/0c3lie03m3ajg6j6numm2gf1l4%40group.calendar.google.com/public/basic.ics'
def update_calendar_file():
    import urllib
    urllib.urlretrieve(CALENDAR_URL, LOCAL_CALENDAR)
def get_event_list(calendar_path):
    import icalendar
    cal = icalendar.Calendar.from_string(open(calendar_path,'rb').read())
    return cal.walk('VEVENT')
def get_target_temp(calendar_path, timezone_name):
    import datetime, pytz
    f = open(TARGET_PATH, 'r')
    override = f.read()
    if (override[0:2] != 'ab'):
        return str(override)
    days = list(['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'])
    now = datetime.datetime.now(pytz.timezone(timezone_name))
    today = days[now.weekday()]
    events = get_event_list(calendar_path)
    for event in events:
        if event_is_today(event, today) and event_is_now(event, now):
            return float(event.decoded('summary'))
    print "Temperature not found in calendar. Using default."
    return DEFAULT_TEMPERATURE
def event_is_today(event, today):
    try:
        freq = event.decoded('rrule')['FREQ'].pop()
    except KeyError:
        freq = None
    try:
        byday = event.decoded('rrule')['BYDAY']
    except KeyError:
        byday = []
    if (freq == 'DAILY') or (today in byday):
        return True
    else:
        return False
def event_is_now(event, now):
    start = event.decoded('dtstart').time()
    end = event.decoded('dtend').time()
    if start < now.time() and end > now.time():
        return True
    else:
        return False
def read_sensor(address):
    import subprocess
    cmd = 'i2cget -y 0 ' + hex(address) + ' 0x00 w'
    subp = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    data = int(subp.communicate()[0].strip(), 16)
    return ((data % 0x0100 * 16) + (data / 0x1000)) * 0.0625
$$/code
If you find errors in this tutorial, please drop a note in the [forums][1], and we'll fix it up.

[1]: /forum/
[2]: http://www.flickr.com/photos/pingswept/4361956125/in/photostream/
[3]: http://www.sparkfun.com/products/9418
[4]: http://en.wikipedia.org/wiki/Red%E2%80%93black_tree