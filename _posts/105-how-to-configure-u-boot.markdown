#How to configure U-boot for a custom board

Download the u-boot tarball or whatever.

In the top-level directory, you're going to run *make* twice. The first time, you'll give *make* a configuration name, and *make* will write a config.h file in the include directory. The second time, you'll just say *make all*, and *make* will build u-boot according to the configuration previously written out.

How do you figure out the configuration names? If you're building u-boot for an existing board, the name is just *name_of_board*_config. You can search through all the .h files in /include/configs to find the exact name of your board.

If you're making a custom board, you should copy the existing .h file and corresponding directory in the board directory and modify it to suit your hardware.

One more wrinkle-- some boards have multiple configurations. For example, the AT91SAM9260 evaluation kit has a few different configurations, all with names of the form at91sam9260_*subconfig*_config. So far as I can tell, the only way to figure out what subconfigurations exist is to grep through the Makefile in the top-level directory for your board name, as it is the Makefile that determines how the configuration names are parsed.
