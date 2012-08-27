## Basic tutorial: timed events ##

Most of the time when you're working with the Rascal, you want stuff to happen in response to web requests. Sometimes, you'd like something to happen constantly in the background, regardless of any web activity. The way to do that is using timed events.

### Periodic events ###

To create a timed event, you write the function you want to execute in <code>server.py</code>. Then, add an <code>@rbtimer</code> decorator on the line before it that determines how many seconds you want to wait between executions. You should, of course, make sure that your function will be finished before you try to run it again-- that way lies madness. If you want something to happen *really* fast (say, more on the time scale of milliseconds), you should use a dedicated processor to handle it, as described in the [motor control tutorial][2].

Here's an example function that toggles the LED onboard the Rascal every 5 seconds. The logic is: "If the LED pin is high, set it low. Otherwise, set it high." 
$$code(lang=python)
@rbtimer(5)
def toggle_pin(num):
    import pytronics
    if pytronics.digitalRead('LED') == '1':
        pytronics.digitalWrite('LED', 'LOW')
    else:
        pytronics.digitalRead('LED', 'HIGH')
$$/code

The number you pass to <code>@rbtimer</code> has to be an integer-- no decimal places. If you do pass something like 10.6, it will be rounded down to 10 seconds. Note that a value like 0.9 will get rounded down to 0, which will result in the server swamping itself with tasks. Also, note that you need the <code>num</code> argument in your function so that the decorator can use it for the seconds count, even if you never actually use it in the rest of your function.

If you read the [uWSGI documentation on decorators][1], you'll notice that there is another decorator, <code>@timer</code>. This timer is not implemented in uWSGI for ARM chips, so we just have <code>@rbtimer</code> at our disposal.

### Scheduled events ###

If you want something to happen based on a calendar (like every Sunday morning at 3 AM) rather than elapsed time, you'll want to use the <code>@cron</code> decorator instead of <code>@rbtimer</code>. <code>@cron</code> behaves mostly like the old Unix <code>cron</code> utility-- you pass it a list of 5 numbers that determine when it executes: minute, hour, day, month, and weekday. Unlike <code>cron</code>, you use <code>-1</code> rather than <code>*</code> to signify "all."

Here's an example.
$$code(lang=python)
@cron(30, 13, -1, -1, -1)
def siesta(num):
    print('It is 1:30 PM! Time for a siesta!')
$$/code

[1]: http://projects.unbit.it/uwsgi/wiki/Decorators
[2]: /docs/basic-tutorial-controlling-motors.html
