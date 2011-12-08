<script src="/js/bootstrap-twipsy.js"></script>
<script src="/js/bootstrap-popover.js"></script>

(This tutorial is unfinished.)
## Controlling motors ##

Suppose you want to control a motor through the internet. In this example, I'll explain how to go about it. I'm going to use a 4-part chain: a Rascal, an [Arduino Uno][2] with a [motor control board][1] from Adafruit on top, and a small DC motor.

<img src="/img/i2c-motor-control.jpg">

## A little background on motor control ##

For DC motors, you vary the speed of the motor by sending a signal that alternates between on and off. To go slowly, the signal is mostly off; as you speed up, the signal is more on and less off. This is called "pulse width modulation." You can read more details about this on the [Arduino PWM page][3].

For stepper motors, which are used more for positioning tasks, like driving a printhead in a printer, the signals sent to the motor are more complex. Typically, there are 4 wires, and they each carry square wave signals out of phase with each other. The image below shows a few different schemes that are used.

<img src="/img/stepper-motor-waveforms.png">

(Image from the [stepper motor page][4] on Wikipedia.)

With both types of motors, the pulses are very fast-- each one lasts around 1 ms. With the Adafruit motor shield code and an Arduino with a 16 MHz crystal, the exact PWM frequency is 16,000,000/64/256 = 976.6 Hz. The 64 divisor is a prescales the system clock down to produce the timer clock, which rolls over every 256 steps, so that we can have 256 different PWM levels.

Because the pulses are so fast, we'll dedicate the Arduino to the motor control and do all the internet stuff on the Rascal. In this example, the Arduino will be mostly idle because controlling a single motor is easy, but if you were trying to do smooth control of multiple motors, the Arduino wouldn't have time to deal with any internet stuff. In general, it's desirable to separate the fast stuff like motor control from large, slow tasks, which tends to mean any kind of network communication.

## Communicating with the Arduino ##

Of course, we need to be to pass commands from the Rascal to the Arduino if we want the motor to react. For noise immunity, we want to use a digital bus. We could use I<sup>2</sup>C, SPI, or a serial port, but I<sup>2</sup>C wins because its bus-addressable, meaning that we can chain multiple Arduinos together and address them individually if we want to.

Here's the code we'll run on the Arduino. We'll use the Wire library to listen to the I<sup>2</sup>C bus. Whenever a new message comes in from the Rascal, the <code>receiveEvent()</code> handler will be triggered. We'll take the number delivered by I<sup>2</sup>C and store it in <code>x</code>. The next time through the main loop, that value will be passed to <code>setSpeed()</code>. 
$$code(lang=c)
// Motor number 1 (Front) is 29 hex or 41 decimal
AF_DCMotor motor(4);
int x=0;
void setup() 
{
    Wire.begin(0x29);              // Set I2C address
    Wire.onReceive(receiveEvent);  // Set up interrupt handler
    motor.setSpeed(200);
    motor.run(FORWARD);
}
void loop() 
{
    motor.setSpeed(x);
}
void receiveEvent() 
{
    x = Wire.receive();    // receive byte as an integer
}
$$/code

## Setting up the Arduino for motor control ##

The electrical setup here is straightforward.

1. The motor shield plugs into the Arduino.
2. The DC motor hooks to the connector labeled M4.
3. A 9 V power supply connects to the external power connector ("EXT_PWR") on the shield. (Make sure that the PWR jumper on the shield is closed, like it is out of the box.)

<div rel="popover" title="Some details" data-content="I want to explain how this code works, but I can't figure out how to attach this to a single line, rather than the whole code block.">
$$code(lang=html)
<h1>Motor control demo</h1>
<div id="slider"></div>
$$/code
</div>

<script>
  $(function () {
    $("div[rel=popover]")
      .popover({
        offset: 10
      })
      .click(function(e) {
        e.preventDefault()
      })
  })
</script>

Here's the Javascript.
$$code(lang=html)
<script type="text/javascript">
$(function() {
    $( "#slider" ).slider({ min: 0, max: 255 });
});
$( "#slider" ).bind( "slidestop", function(event, ui) {
    var value = $( "#slider" ).slider( "option", "value" );
    $.post("/set-speed", { speed: value });
});
</script>
$$/code

[1]: http://www.adafruit.com/products/81
[2]: http://arduino.cc/en/Main/ArduinoBoardUno
[3]: http://www.arduino.cc/en/Tutorial/PWM
[4]: http://en.wikipedia.org/wiki/Stepper_motor