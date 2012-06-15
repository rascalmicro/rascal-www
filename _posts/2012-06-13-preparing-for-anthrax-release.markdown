---
format: markdown
date: 2012/06/13 00:00:00
title: Preparing for Anthrax release
categories: rascal
---

### New hardware ###

The new Rascal 1.2 hardware, which fixes the exasperating memory bug that doomed Rascal 1.1, has been running solid for the last few weeks. A new batch of Rascals has arrived from the assembler; as soon as they get Ethernet jacks soldered in place (around June 21), they'll be ready for new software.

The picture below shows the Rascal before (left) and after (right) the memory fix. Note the serpentine trace in between the memory and the processors-- this is evidence of the effort to match propagation delays across the memory bus. 

<img src="/img/rascal-1.1-1.2-comparison.jpg" width="820px">

### New software ###

From here on out, each Rascal software release will be named with a date and a codename. As is traditional in many open source projects, the codenames will have a theme. Most of the cuddly themes are taken, so we've decided to use the names of infectious diseases. In addition to being memorable, this makes for great casual conversation, particularly in public spaces.

"Say, Linus, have you heard about the new Anthrax release?"

"I've tried Anthrax, but I can't wait to try Beriberi!"

"If you liked Rickets, you'll love Scurvy!"

There are two major goals for the new software release. The more exciting is the new editor; the less exciting is the infrastructure work that's been going on behind the scenes. More details about how the software is being upgraded in the next post.

[1]: http://rascalmicro.com