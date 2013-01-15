---
format: markdown
date: 2013/01/15 00:00:00
title: The first Rascal hackathon at Tufts University
categories: rascal
---
In late December, we held the first Rascal "Hack Afternoon" at Tufts University in Medford, MA, USA, just over the town line from Rascal headquarters in Somerville. The [Tufts Center for Engineering Education and Outreach][1] (CEEO) had recently bought several Rascals, and they wanted to get off to a quick start on some projects. (Tufts is now tied with Harvard University for the largest installed base of Rascals.)

The CEEO is an unusual entity in that it draws faculty and students from engineering and education in roughly equal proportions. They work to integrate engineering into education for kids in the K-12 range. In practice, this means that they have a lab filled with a lot of Legos and other stuff that straddles the line between toys and engineering prototyping tools. They develop curricula and hold workshops for teachers and kids to test out new methods of engineering education, and they're constantly looking for tools like the Rascal that will help them prototype more efficiently.

The ten people who showed up for the hackathon, organized by professors [Chris Rogers][2] and [Ethan Danahy][3], were mostly professors and graduate students in computer science and mechanical engineering, but we did have a few education folks participate. The Rascal really shines at prototyping web-based systems; this is what attracted the CEEO to the Rascal. In the first fifteen minutes of the hackathon, Ethan had built a web page with buttons that could flash the Rascal's onboard LED. An hour or so later, Chris and [Ben Shapiro][4] had hacked up a LabVIEW front-end that talked to the Rascal over TCP/IP using the Rascal's REST API.

I also got a pile of good feedback on the Rascal's rough corners-- areas where the documentation should be improved, parts of the editor where the interaction could be smoothed, and new ideas for additional features. Some of those improvements are already added to the codebase for the next software release ("Cooties"). There's also a longer-term project that I'll be working on to make it easier to find your Rascal on the network.

Thanks to Chris, Ethan, Ben, Saad, Rafi, Steve, Brian, Jessica, and the folks whose names I missed for showing up.

<img src="/img/hackathon-at-tufts-2012-12-21.jpg" width="820px">
##### Brian, Rafi, Ben, and Chris hack on Rascals #####

[1]: http://ceeo.tufts.edu/
[2]: http://ceeo.tufts.edu/People/chrisrogers.html
[3]: http://ceeo.tufts.edu/People/ethandanahy.html
[4]: http://benshapi.ro