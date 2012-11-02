---
format: markdown
date: 2012/10/22 00:00:00
title: Public robotics at the 2012 Somerville Maker Faire
categories: rascal
---

Most of the robotics industry is devoted to industrial machines, like welding robots, or military robots, like the terrifying stuff that Boston Dynamics builds. Makerspaces like Somerville's [Artisan's Asylum][4], where Rascal Micro has its headquarters, are helping to make robotics more accessible to the general public. Back in September, the Asylum started a new initiative called the Public Robotics Lab. The first project was to rehabilitate a previously-constructed robot platform.

The robot platform, pictured below, made its debut at the [Somerville Maker Faire][1] a few weeks ago. [Andrew Anselmo][6] did a bunch of mechanical and electrical work on the robot to get it driving again. I replaced the robot's brain (previously an Arduino Mega) with a Rascal and wifi router so that we could control it wirelessly. Richard Klancer, the satchel-bedecked gentleman at left in the picture, wrote a [jQuery-based joystick interface][7] that runs in any web browser. It was particularly effective on an iPad, which is what I'm holding in the picture. I enjoyed handing the iPad to people unfamiliar with robots and asking them to drive the platform around. Most everyone picked it up in 10-20 seconds.

<img src="/img/public-robot-somerville-maker-faire-2012-by-vitor-pamplona.jpg">
<h5>[Photo thanks to Vitor Pamplona][2] under [CC-BY license][3]</h5>

Richard has posted a video of the robot platform [driving around the Asylum][8]. The joystick control is visible around the 1:00 mark.

It's not clear what the future of the Public Robotics Lab will bring. Andrew and Kasey are working on mounting an electromechanical arm on the platform. We've also had a donation of a sweet LIDAR scanner from the open-source hardware enthusiasts at Templeman Automation. (You might know them from their [open source touchtable][9] or [open source DNA replicator][10] projects.) I've included Richard's joystick demo in the Beriberi release of the Rascal software; I'll probably continue to develop some kind of Rascal-controlled robot, but I might work on something smaller and more nimble than the current platform.

[1]: http://www.makerfairesomerville.com/
[2]: http://www.flickr.com/photos/vitorpamplona/8086724581/in/set-72157631768384837/
[3]: http://creativecommons.org/licenses/by/2.0/deed.en
[4]: http://artisansasylum.com
[5]: http://wiki.artisansasylum.com/index.php/Robot_Sensor_Platform
[6]: http://flappingbird.com/
[7]: https://github.com/rklancer/touchjoy
[8]: http://www.youtube.com/watch?v=I-g5E0_8iuw
[9]: http://playsurface.org/
[10]: http://personalpcr.com
