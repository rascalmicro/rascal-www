---
format: markdown
date: 2010/12/03 00:00:00
title: Toggling pins with U-boot
categories: bootloader, u-boot
draft: true
---
I recently faced a problem with the Rascal where I needed to test that some of the pins on the processor. A couple of the pins used for talking to the Ethernet transceiver were acting weird, and I thought there might be a short circuit under the BGA package. It turned out that the problem was in software, but as part of the debugging, I figured out how to toggle pins with U-boot.

Microcontrollers have various hardware preipherals built in-- hardware for talking to serial ports, timers, and so forth. All of these features are controlled by registers in memory. In the AT91SAM9G20, there is a group of 32 pins called Port A. There is also a Port B and Port C, which are similar, but with slightly different features.

The pins in Port A can all be used as general purpose input or output pins ("GPIO"). To make a pin function as an output, you have to do 4 things:
 1. Turn off all its peripheral functions.
 2. Set it to be an output.
 3. Set its value (high or low).

The registers that control Port A reside near the top of the processor's 32-bit memory space, in the range of 0xfffff400-fffff600. For toggling pins, there are three sets of three registers that you care about. 
PIO_PER at 0xfffff400
PIO_PDR at 0xfffff404
PIO_PSR at 0xfffff408

PIO_OER at 0xfffff410
PIO_ODR at 0xfffff414
PIO_OSR at 0xfffff418

PIO_SODR at 0xfffff430
PIO_CODR at 0xfffff434
PIO_ODSR at 0xfffff438

$$code(lang=bash)
U-Boot> md fffff400
fffff400: 00000000 00000000 fe400030 00000000    ........0.@.....
fffff410: 00000000 00000000 01800000 00000000    ................
fffff420: 00000000 00000000 00000000 00000000    ................
fffff430: 00000000 00000000 00000000 c0680efa    ..............h.
fffff440: 00000000 00000000 00000000 ffffffff    ................
fffff450: 00000000 00000000 01800000 00000000    ................
fffff460: 00000000 00000000 01bff00f 00000000    ................
fffff470: 00000000 00000000 00000000 00000000    ................
fffff480: 00000000 00000000 00000000 00000000    ................
fffff490: 00000000 00000000 00000000 00000000    ................
fffff4a0: 00000000 00000000 00000000 00000000    ................
fffff4b0: 00000000 00000000 00000000 00000000    ................
fffff4c0: 00000000 00000000 00000000 00000000    ................
fffff4d0: 00000000 00000000 00000000 00000000    ................
fffff4e0: 00000000 00000000 00000000 00000200    ................
fffff4f0: 50494f32 20202020 00002017 00000204    2OIP    . ......
U-Boot> mw fffff400 ffffffff
U-Boot> mw fffff410 01802000
U-Boot> mw fffff430 01802000
U-Boot> mw fffff434 01802000
U-Boot> mw fffff430 01802000
U-Boot> mw fffff434 01802000
U-Boot> mw fffff430 01802000
$$/code