---
author: Brandon Stafford
categories: bloggeurs
date: 2010/07/09 18:14:40
draft: True
format: markdown
title: This is not a blog post
---

### Ideas ###


Different levels of software abstraction

1. ARM boot code
2. Configuring uboot
3. Building the Linux kernel for an embedded board
4. Linux package management
5. Web frameworks

Different components

1. Ethernet controller (partially done)
2. DC/DC converters
3. Low dropout regulators
4. ARM processor families
5. NAND Flash
6. SDRAM

PCB design

1. Signal integrity
2. BGA packages, fanout strategy, and manufacturing
3. Price survey data from different PCB manufacturers. How different attributes drive cost.
4. Announcing libraries available-- Arduino shield, metric parts for Altium
5. Altium layers for APCircuits (see below)

## What is "impedance matching" ##
Impedance matching to maximize power transfer. You want to match the load to the source impedance, but even better is to reduce the source impedance (and then match). Need LaTeX for this post.

## Series of posts on beta-tester projects ##
1. LED driver for Ben
2. Mike's quantum cryptography device
3. Ben Harris?

## Some sort of iternet-anonymizing firewall? ##

Hmmm. 

## Altium, Gerbers, and APCircuits layers ##
.DRR	Drill?						Tool List
.GTL	Gerber Top Layer			Top Copper Layer
.GBL	Gerber Bottom Layer			Bottom Copper Layer
.GM1	Gerber Mechanical 1			Mechanical Layer
.GP1	Gerber Plane 1				1st Mid-Layer Below Top (Plane)
.GP2	Gerber Plane 2				2nd Mid-Layer Below Top (Plane)
.GTO	Gerber Top Overlay			Top Legend
.GBO	Gerber Bottom Overlay		Bottom Legend
.GTS	Gerber Top Soldermask		Top Soldermask
.GBS	Gerber Bottom Soldermask	Bottom Soldermask
.TXT	NC Drill file				NC Drill File
.DRL	Binary drill file?			Not used by APCircuits
Pick Place for _____.TXT			Not used by APCircuits, but assemblers call it XYRS file
.GTP	Gerber Top Paste			Not used by APCircuits, top solderpaste
.GBP	Gerber Bottom Paste			Not used by APCircuits, bottom solderpaste
.GG1	Gerber Drill Guide			Not used by APCircuits
.REP	Lists drill codes per file?	Not used by APCircuits
.EXTREP Decodes file extensions		Not used by APCircuits
.LDP>	Layer Pairs?				Not used by APCircuits
.APR	Aperture file				No longer needed; use 274X embedded apertures instead

Running a company
1. Shipping stuff
	* UPS account
	* Kitting parts for Advanced Assembly with envelopes and 2x4 stickers
	* Economics of PCBs

## General hackery skills ##
1. Using a packet sniffer like Wireshark
2. How the internet works
3. Install Tomato or DDWRT or whatever
4. SSH
5. Soldering tricks-- flux, wire-wrap wire for rework, heatgun for chip removal

## More explanation of LED driver circuit ##

Suppose the LED is at max current. The pot is at 10k, and Q1 is off. The V<sub>BE</sub>'s balance each other. If you lower the pot resistance, the voltage below Q1's emitter drops, which turns on Q1 a little. This makes a little collector current flow, which creates a voltage drop across the collector resistor. This pulls the MOSFET gate a little lower, so it turns off more. This makes the LED current drop, which lowers the voltage holding up the other diode. This process continues until the voltages below the diodes match again. If the voltage in the LED leg were higher, more current would flow in Q1, which would push the process along. If the voltage in the LED leg were to drop below the voltage in the control leg, the current in Q1 would drop, which would reverse the process, reducing current in Q1 and turning on the MOSFET, such that the voltage in the LED leg would rise again.

Not exactly true because the two diodes aren't actually identical, but they're close enough.
http://radiolocation.tripod.com/LEDdimmer/LEDlampDimmer.html

