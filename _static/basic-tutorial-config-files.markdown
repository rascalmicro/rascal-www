## Basic tutorial: something ##

Intro text

<img class="span12" src="/img/filename.png">

Text right before code
$$code(lang=python)
import ConfigParser
conf = ConfigParser.SafeConfigParser()
conf.read('test.conf')
conf.get('Thermostat', 'name')
conf.set('Thermostat', 'name', 'Larry')
f = open('test.conf', 'wb')
conf.write(f)
$$/code

If you find errors in this tutorial, please drop a note in the [forums][1], and we'll fix it up.

[1]: /forum/