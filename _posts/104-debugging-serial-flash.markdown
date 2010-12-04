---
format: markdown
date: 2010/10/11 00:00:00
title: Heavy-duty debugging
categories: rascal, at26, debugging, serial, spi
draft: true
---

OK, I've worked some more on this. It doesn't work yet, but I think I'm close.

[quote]Did you try a read from SAM-BA? Just read the date from the memory chip and then view the data in a binary viewer[/quote]

(You meant "data," not "date, right?) When I read data back from the chip, I get all 0xFFFFFFFF. I am inclined to believe that this is because the writing is failing, rather than the reading, as the chip appears to respond correctly to other commands.

Here's a scope shot of what happens when the 9G20 boots. It executes a 0x05 "read status" request and gets the proper 0x1C response from the chip. Then the 9G20 issues a high-speed-read request, followed by the address 0x000000, a dummy byte, and a long series of clock pulses to crank out the data. As you can see in the zoomed-out top window, the SO line stays high after the status response. Given that the status response is reasonable, I'm inclined to believe that the chip is really empty.
[img]http://rascalmicro.com/img/serial-flash-on-processor-reset-check-status-read-data-at-000.png[/img]

So then the question is: why is writing to the chip failing?

(Tim, you were right that I was still using the wrong version of AT91Bootstrap. But that shouldn't matter, at least for testing writing, right? Obviously, it will matter when I'm trying to load U-boot and so on.)

I've gone through the AT26 initialization and write process fairly carefully. SAM-BA correctly retrieves the JEDEC ID, as you can see below.
[img]http://rascalmicro.com/img/serial-flash-jedec-id-spi.png[/img]