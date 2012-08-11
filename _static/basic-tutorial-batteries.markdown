## Basic tutorial: running the Rascal off a battery ##

Usually, the Rascal runs off a small power supply that converts wall power to 9 V DC. From there, the Rascal has four voltage regulators:

 * 5 V for shields and as a prefilter to the other regulators
 * 3.3 V for the ARM microprocessor and the Ethernet chip, supplied by the 5 V regulator
 * 1.0 V for the ARM processor's core logic, supplied by the 5 V regulator
 * A special low-noise regulator at  1.0 V for the phase-locked loop embedded in the ARM processor, supplied by the 3.3 V regulator

Because the Rascal has onboard regulation, it can run from a range of voltages. As the battery voltage drops, the Rascal becomes more likely to shut down. The nominal threshold where we start getting into trouble is 7.0 V. The maximum voltage that the Rascal can withstand is nominally 35 V, but I haven't tested it above 15 V or so.

### Some experimental results ###

I did an experiment where I attached a Rascal to a adjustable power supply to simulate a battery. I gradually lowered the voltage until the Rascal died. The results are in the graph below.

<img class="span12" src="/img/battery-voltage-2012-08-10.png">

### Details about when the Rascal went off into the weeds ###

 * Above 7.0 V, everything was great, as expected.
 * At 6.8 V, the 5 V regulator started to lose regulation.
 * At 5.8 V, the 5 V regulator had sagged down to 4.0 V, which was enough to affect the 3.3 V regulator, but the Rascal kept going.
 * At 5.2 V, the 3.3 V regulator had sagged to 2.85 V. The Rascal could still run at this voltage, but it couldn't boot, probably because the bursts of current needed for booting made the poorly-regulated supplies sag wildly.
 * At 4.7 V, the 3.3 V regulator sagged to 2.37 V, which was low enough to make the Rascal stop responding to web traffic.

### Battery chemistry and voltage ###

There are several battery chemistries available today, but the most popular for small electronics is lithium polymer, or lipo. Each individual lipo cell has a voltage of around 3.7 V; the Rascal works best with batteries that have two cells in series ("2S batteries"), as their total voltage is 7.4 V. Higher voltage batteries will also work, but less efficiently, because the regulator on the Rascal dumps everything above 5 V. This makes 7.4 V is the best choice.

### Battery life ###

The Rascal draws around 140 mA when idle, but can draw up to 250 mA when it's booting. For comparison, this is 2-3x less than a Beagleboard, but 2-3x more than an Arduino.

Lipo batteries are available from a place like [Hobby King][2]. All the batteries that they sell have vastly more current capability than the Rascal needs. I've been testing out batteries from Hobby King. I'd estimate that the Turnigy 3300 mAh battery will run the Rascal for around 24 hours; it costs about $17. More details will appear here when the tests are complete.

If you find errors in this tutorial, please drop a note in the [forums][1], and we'll fix it up.

[1]: /forum/
[2]: http://hobbyking.com