---
format: markdown
date: 2012/04/26 00:00:00
title: Open source hardware in Washington, D.C.
categories: rascal
---

Last weekend, I traveled down to Washington, D. C. to visit family; while I was there, I went to an [open hardware event][1] put on by Public Knowledge on Friday afternoon. The event was organized by Michael Weinberg of Public Knowledge. Cat Johnson has a [nice discussion][2] with Michael explaining why they want to introduce policymakers to the idea of open hardware.

In reference to last year's similar event for 3D printing, Michael says,

"If you're a legislator and the first time you ever hear about 3-D printing is someone coming into your office saying, 'This horrible pirate box is ruining my business,' you would have one world view of 3-D printing. If the first time you hear about 3-D printing is someone saying, 'Wow, look at all these new businesses and people who are coming together around technology and creating all these amazing things,' you have a different world view about the subject."

Cat explains that with this approach, "Public Knowledge doesn’t have to spend the first half of a meeting explaining what it is they’re talking about."

The event consisted of two panels about open source hardware, followed by a demo session in the Rayburn Foyer. I watched the panels and had a table in the demo session. The demo I brought for the event is a motor that can have its speed controlled through the internet; the picture below shows its I-am-not-a-terrorist guise.

<img src="/img/demo-with-motor-in-case.jpg" width="820px">

The two panels occurred in a small room on the third floor of the Rayburn office building. Each panel was 4 or 5 people. There were around 100 people there; at least 40 of them were open hardware folks; the remainder were either policy people or random geeks who wanted to see the action.

My hometown of Somerville is in Rep. Mike Capuano's district (he used to be mayor of Somerville), but Capuano and his aides were too busy to come to the event.

### Where we stand ###

The panelists answered questions from the moderators, Alicia Gibb and Michael Weinberg. The event was filmed, so I won't try to reproduce all the questions and answers here, but it was definitely interesting and informative. Bunnie Huang had a great rant about how everyone involved in the production of electronics should visit the electronics markets in Shenzhen and feel the energy of commerce. (If that intrigues you, read his [great blog post about Shenzhen][3] from a few years ago.) All hardware, with some level of reverse engineering, is open, he pointed out. There are huge markets that don't have the strong IP rights enforcement we have in the US.

To me, the point is that we are making open source hardware even if we don't want to. This forces us to adopt openness by default, so that we get the benefits as well as the detriments.

I was encouraged to see that we have a bunch of smart people on our side. Bunnie, AnnMarie Thomas, David Mellis, and Nathan Seidle are articulate and funny. The demos were impressive. My favorite moment of the day was talking to a janitor who was drawn in by a RepRap 3D printer that was running unattended before the event officially started. Noticing that she was staring at the machine and seemed puzzled, I pointed out the printed-out plastic rabbits on the table and explained that the RepRap was halfway through printing another one. I showed her the pair of new Makerbot Replicators that can print two colors at once. She had the 3D printing epiphany and said something like, "This thing can make you anything you want!" She grabbed a few Makerbot fliers and as she left, she said, "I gotta tell people about this!" She had the altered-world urgency of someone who has just learned that Kennedy is still alive, or discovered that soylent green is people, or seen Nathan's secret tattoo. (Don't bother asking. He just pretends it doesn't exist.) I'm glad that we could help spread the enthusiasm.

The demos went well; I'd estimate that 50-100 people passed through, which is pretty good for a sunny Friday afternoon. I hadn't seen the very cool [squishy circuits][4] before; somehow, they managed to attract the children in the crowd, which is impressive for an event aimed at adults in suits. The Rascal demo worked perfectly, though I did have a couple moments of terror while setting up. First, it seems that in double-checking my demo, I managed to delete my DHCP server's configuration file. Fortunately, it was easy to switch the Rascal to a static IP. I guess I'm prepared for idiots like me.

Then, in my motor control demo, some of the Javascript code was linked from external servers. When I tested it the night before without an internet connection, the Rascal used cached versions of the code. 12 hours later, the cached versions expired, which left me scrambling for a wireless connection to pull down the code I needed. After some quick modifications to use local code, the demo worked quite well. Several people stopped by to ask when new Rascals would be available for sale, which made my day. (Thanks, Shawn!)

Still, my overall impression was that as a group, we open hardware folks are weak on the policy front. We don't know what policies we want. Worse, we don't even know what outcomes we want. Some of us really don't care about licenses; others think we need them desperately; and still others think licensing hardware is hopeless. We're just setting up the [first open source hardware nonprofit organization][5]. Our most experienced professionals are people like Nathan and Bunnie, who were in college 10 years ago. Generally, we seem like people much more interested in building stuff than public policy. In some contexts, our political inexperience is alarming; Michael Weinberg put it more optimistically: "No, that just means you've made prudent life choices!"

Thanks to Public Knowledge for organizing the event.

(More details about the state of the new Rascal boards coming soon.)

[1]: http://www.publicknowledge.org/event/ohdc-open-source-hardware-comes-dc
[2]: http://www.shareable.net/blog/open-source-hardware-goes-to-washington
[3]: http://www.bunniestudios.com/blog/?p=147
[4]: http://courseweb.stthomas.edu/apthomas/SquishyCircuits/index.htm
[5]: http://www.oshwa.org/