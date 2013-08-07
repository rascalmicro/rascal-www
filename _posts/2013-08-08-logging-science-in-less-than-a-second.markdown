---
format: markdown
date: 2013/08/08 00:00:00
title: Logging science in less than a second
categories: rascal, science
---

As the Rascal has matured over the last few years, I've started to think about how it can change the working lives of artists and scientists. The Rascal is already a useful tool for people who have some experience with web programming and basic electronics, but I'd like to see it spread to a wider audience. I'm working on a number of projects to this end; I'll detail one in the scientific realm below.

### Data management in science ###

In science, one of the largest changes in the last 20 or 30 years is the rise of computerized statistical analysis. Scientists have long used statistics to analyze their data, but with microcontrollers embedded in everything, we can now gather data more easily than ever before. I think it would be fair to say that our ability to gather data has outstripped our ability to manage that data.

In my experience, researchers manage data in a haphazard way, but only because it's so hard to do better. They're often collecting data from multiple instruments simultaneously. The data ends up with different timestamps, on various USB sticks or shared fileservers, often in CSV or Excel files, or in some weird text format specific to the instrument. The researcher then pulls the data together onto one computer, reconciles the timescales, and analyzes the data using Excel, SPSS, R, Python, or a software tool specific to their research specialty. I think we can do data collection and management better.

### The event logger ###

I've been collaborating with an angel-funded startup at MIT called [Biobright][1]. Their goal is to build an open software framework for the collection, analysis, and visualization of biomedical data. Recently, we have been working on a device for the lab bench that will help biomedical experimenters log their progress while executing biomedical protocols.

<img src="/img/event-logger-prototypes-2013-08-07.jpg">

##### The first cardboard mock-up, a first try, and a much smaller, more refined prototype #####

The scenario goes like this: you're at the lab bench wearing nitrile gloves, holding a pipette in one hand and a test tube in the other. You're working your way through a protocol. You'd like to be able to note down, "Yes, at 10:36 AM today, I added 10 mL of NaCl to the solution," but given that the protocol is long and complex, and you have a lot of samples to prepare, you're not going to take the time at every step to log what happened. You'd have to put down the pipette and type on your laptop one-handed, or use a pencil and a notebook. Your average time for each step could easily double or triple, and you might end up contaminating your samples as well.

### Logging in less than a second ###

If you could create a timestamped log of steps achieved and add less than 1 second per step, that would be worth it. Then, when something goes funny with your experiment, you can look back across multiple batches of samples or cultures and check where the preparations differed. Was one culture out of the fridge for longer? Did one solution spend the night on the stir plate, while the other was only stirred as long as it took to check email?

This is the idea of the event logger-- a small box that pulls your protocols from a central server. It shows you each step, and as you complete each step, you tap the button. You can hit it with a finger, the heel of your palm, or even your elbow. The box acknowledges your button press and moves to the next step. In the background, it timestamps the protocol step and logs to a file. If you're using the Biobright software or something that implements their API, the box logs the same data back to the central server.

That's the basic functionality, but we can add more advanced features. For example, if your protocol requires that you put your samples in an incubator for 18 minutes, the event logger will give you an 18-minute countdown, starting when you hit the button. Because every event logger contains a Rascal, it's also a webserver, so you can log into it remotely to change settings, look at the data, and so forth.  

### Your feedback is welcome, scientists ###

The event logger is obviously in a child-like state. If this sounds like something you would like to use in your lab, please get in touch with me at brandon@rascalmicro.com. If you work in a lab around Boston, I would love to come to your lab and hear the details of what your lab needs. It may be nothing like the event logger; I'm still interested!

[1]: http://biobright.org