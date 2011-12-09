(Note: for now, to get this tutorial to work, you have to add <code>from uwsgidecorators import *</code> to your <code>server.py</code> and add the actual uwsgidecorators.py library to your <code>/usr/lib/python2.6/sitepackages</code> directory. In the long run, this will already be installed on all Rascals.)

## Basic tutorial: timed events ##

Most of the time when you're working with the Rascal, you want stuff to happen in response to web requests. Sometimes, you'd like something to happen constantly in the background, regardless of any web activity. The way to do that is using timed events.

To create a timed event, you write the function you want to execute in <code>server.py</code>. Then, add an <code>@rbtimer</code> decorator on the line before it that determines how many seconds you want to wait between executions. You should, of course, make sure that your function will be finished before you try to run it again-- that way lies madness. If you want something to happen *really* fast (say, more on the time scale of milliseconds), you should use a dedicated processor to handle it, as described in the [motor control tutorial][2].

Here's an example function that toggles pin 2 every 5 seconds. The logic is: "If the pin is high, set it low. Otherwise, set it high." 
$$code(lang=python)
@rbtimer(5)
def toggle_pin()
import pytronics
if pytronics.read_pin('2') == '1':
    pytronics.set_pin_low('2')
else:
    pytronics.set_pin_high('2')
$$/code

The number you pass to <code>@rbtimer</code> has to be an integer-- no decimal places. If you do pass something like 10.6, it will be rounded down to 10 seconds. Note that a value like 0.9 will get rounded down to 0, which will result in the server swamping itself with tasks.

If you read the [uWSGI documentation on decorators][1], you'll notice that there is another decorator, <code>@timer</code>. This timer is not implemented for ARM chips, so we just have <code>@rbtimer</code> at our disposal.

[1]: http://projects.unbit.it/uwsgi/wiki/Decorators
[2]: /docs/basic-tutorial-controlling-motors.html