---
format: markdown
date: 2012/01/05 00:00:00
title: Rascal wins Editors' Choice, now with an interview!
categories: rascal
---
<div class="row">
    <img class="span2" src="/img/postscapes-award-badge.png">

    <div class="span12">
    <p>The Rascal won the <a href="http://postscapes.com/best-iot-open-source-project-2011">Editors' Choice award</a> in the Open Source Project category at <a href="http://postscapes.com">Postscapes</a> a few days ago. Postscapes is a site in South Korea that tracks the "internet of things," which means stuff like the Rascal, more or less. In the aftermath of the contest, Trevor Harwood of Postscapes and I recorded a discussion of the various topics related to connecting stuff to the internet, open source hardware, and the Rascal. Trevor was kind enough to transcribe and discretize the discussion so you can absorb it in palatable chunks.</p>
    </div>
</div>

**Read/listen to [the interview][1].**

### A brief rant about firewalls and port forwarding ###

One topic that I had meant to discuss, but forgot about in the heat of battle, is the growing asymmetry of internet connections as the industry matures. The original design of the internet made each computer on the network equal to every other. At least in the US, this is no longer the case. Most incoming connections to our homes and businesses are filtered to prevent people from running their own servers.

Instead of assigning unique addresses to each computer, we use what's called "Network Address Translation," which allows each connection to build its own network behind a firewall, while masquerading as a single computer to the rest of the internet. This works pretty well for surfing the web, but when you want to take off the mask to build the internet of things, it's a problem. Additionally, some connections are filter out incoming requests to ports 80 (HTTP) and 25 (email). This is the case for the least-of-evils, at-least-they're-not-Comcast cable connection from RCN I have at home.

In theory, you can request a block of IP addresses from the [American Registry of Internet Numbers][2], but the minimum fee for IP addresses is $1250, plus various fees for other details (registration and maintenance of an Autonomous System number and such) and ARIN won't give you addresses without a convincing explanation of why you need them. Even if they relented, you'd still need to pay someone who owns a bunch of telephone poles to run a wire from your house to your local internet exchange or negotiate some kind of deal with the local government to allow you to run the cable yourself.

There are a few workarounds that you can use. If you have control of your router, you can pick a few external ports that aren't blocked by your ISP and forward them to devices on your internal network. If you live in a big apartment building where all you get is wireless access, this won't work unless your landlord likes you a lot and nobody else wants to fight you for those ports. The other option is creating encrypted software tunnels to external servers, but that requires either that you run a server yourself or get access from someone who does.

Anyway, it's a bit of a mess. I wish I had more ideas about how to fix the situation, but I don't. I wish I had grown up in the good old days, when men were men and IP addresses were globally routed.

[1]: http://postscapes.com/iot-open-source-computers-a-conversation-with-rascal-creator-brandon-stafford
[2]: https://www.arin.net/fees/fee_schedule.html