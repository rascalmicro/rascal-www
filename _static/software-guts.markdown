# The guts of the Rascal software #

*This page describes how the software in the Rascal fits together. If you just want to use the Rascal, you don't need to understand any of this; it's just here for the benefit of the hardcore Rascal zealots.*

The Rascal starts with 4 pieces of code in its stock configuration. The first three are contained in the 4 MB serial flash; the fourth is on a removable microSD card. The picture below shows a beta unit with the serial flash and microSD card called out.

<img src="http://rascalmicro.com/img/rascal-with-boot-labels.jpg">

## Serial flash ##

The serial flash holds 4 MB of memory. As long as you're using the Rascal as intended, this memory is read-only. Production versions of the Rascal will probably ship with the serial flash write protected, so that regardless of the horrible contortions you may put the CPU through, you can't corrupt the bootloaders or the Linux kernel.

<img src="http://rascalmicro.com/img/4-mb-serial-flash-memory-layout.png">

The addresses of the bootloaders in the diagram above are correct but the proportions are wrong so that the labels will fit. In reality, U-boot is around 100x smaller than the Linux kernel, and AT91Bootstrap is another 40x smaller.

## Boot procedure ##

When the Rascal's AT91SAM9G20 processor boots, it looks for a serial flash. When it finds one, it checks that the first 8 instructions are valid ARM interrupt vectors. If they do, it looks at the value in the sixth vector, and copies that many bytes from the start of the serial flash to its small chunk of internal RAM. On the Rascal, the start of the serial flash is AT91Bootstrap, which contains a sixth vector which is sized so that the rest of AT91Bootstrap is copied.

The CPU then executes AT91Bootstrap, which, among other low-level initialization tasks, prepares the external RAM. AT91Bootstrap's last action is to load whatever it finds at 0x01 0000 in the serial flash to memory location 0x23F0 0000 in RAM, and then jump to execute that code. 0x01 0000 is where U-boot is stored, so U-boot starts executing.

In the same pattern that we saw with AT91Bootstrap, U-boot reads 0x2F FFFF bytes from the serial flash starting at 0x10 0000, which is where the Linux kernel starts. Whatever code U-boot reads is copied to 0x2200 0000 and executed.

## Building the code ##

If you're particularly enthusiastic, you can build all of the code for the Rascal yourself. You'll need an ARM C-compiler-- the Denx [Embedded Linux Development Kit][1] is a good place to start. The code is held in [Git repositories][2] on Github.com.

Need to set a few environment variables.
$$code(lang=bash)
export CROSS_COMPILE=arm-linux-
PATH=$PATH:/opt/eldk/usr/bin:/opt/eldk/bin
$$/code

## Building AT91Bootstrap ##
(need to add AT91Bootstrap 3.0 repo)

## Building U-boot ##
Example of build procedure
$$code(lang=bash)
export CROSS_COMPILE=arm-linux-
PATH=$PATH:/opt/eldk/usr/bin:/opt/eldk/bin
git clone git://github.com/rascalmicro/u-boot-rascal.git
cd u-boot-rascal
git checkout rascal # switches to the Rascal branch
make distclean
make rascal_config
make all
$$/code

## Building the Linux kernel ##
Example of build procedure
$$code(lang=bash)
git clone git@github.com:rascalmicro/linux-2.6.git
cd linux-2.6
git checkout rascal # switches to the Rascal branch
make ARCH=arm uImage
$$/code

If the toolchain builds the kernel successfully, you'll find the kernel image at arch/arm/boot/uImage.

## Building OpenEmbedded filesystem image ##
Example of build procedure
$$code(lang=bash)
source env.sh # sets some environment variables, like BBPATH
bitbake rascal-image
$$/code

[1]: http://www.denx.de/wiki/view/DULG/ELDKAvailability
[2]: https://github.com/rascalmicro/
