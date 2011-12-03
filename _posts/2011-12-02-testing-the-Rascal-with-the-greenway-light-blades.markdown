---
format: markdown
date: 2011/12/02 00:00:00
title: Testing the Rascal with the Greenway light blades
categories: rascal
---
Here's a low quality video of a truly excellent event.

I'm working on a project to control the light blades on the Greenway in Boston through text messages. While I was filming the videow with my phone, [Dan][2] was crouched in "The Vault," a concrete bunker under the Greenway plaza. We had a Rascal plugged into the light controller with a serial cable. Dan used a Python script I wrote to generate HTTP POSTs on my laptop. In theory, the POSTs are the same requests that we'll eventually receive from Twilio. (See this [Rascal-and-Twilio tutorial][1] for the details on how that works.) The Rascal parses the messages Dan sends and decides what show to play. The shows are still a bit of a mess, but the Rascal is working great.

I don't want to say too much more about what we have planned until it's closer to fruition, but I think it will be cool.

<iframe src="http://player.vimeo.com/video/33047579?title=0&amp;byline=0&amp;portrait=0" width="400" height="711" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

Below is a better still shot from Eric Kilby that gives a better idea of what the light blades look like in person. There are 12 of them in all; they're in the park between Faneuil Hall and the Aquarium.

<a href="http://www.flickr.com/photos/ekilby/2600873212/"><img src="/img/eric-kilby-light-blades.jpg" alt="6 green steel blades, 20 feet high, aimed at the sky"></a>

[1]: http://rascalmicro.com/docs/basic-tutorial-responding-to-text-messages.html
[2]: http://thehinge.net/