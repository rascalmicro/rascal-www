---
format: markdown
date: 2010/11/24 00:00:00
title: Booting the Rascal with a remote filesystem
categories: bootloader, nfs, rascal, software, u-boot
draft: true
---
This is another one of those posts that describes obscure procedures that normal Rascal users will never need to understand. For the folks working on development of the Rascal, or other small computers, I hope this proves useful.

To make U-boot boot from an NFS filesystem, you have to do achieve 2 major goals:

1. Set up an NFS server.
2. Give U-boot a list of parameters that it will pass to the Linux kernel, instructing it to contact your NFS server for a filesystem.

## Setting up the NFS server ##

sudo apt-get install nfs-kernel-server nfs-common portmap

Add line to /etc/exports

/nfs       192.168.1.57/255.255.255.0(rw,no_root_squash,sync)

sudo /etc/init.d/nfs-kernel-server restart

NFS uses ports 111, 2049, and 32771, so if you have a firewall, those should be forwarded to your NFS server, but if you're on a local network, you're fine.

## Parameters for U-boot ##

nfsroot=192.168.1.57:/nfs
ip=dhcp
root=/dev/nfs (or maybe =/dev/nfs rw)?

Maybe? rootfstype=nfs

You also want to leave the "console=ttyS0,115200" bootarg intact.

To set a boot argument, you do this at a U-boot prompt:
setenv bootargs "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.57:/nfs ip=dhcp"
saveenv

You can check that it worked with printenv, like this.
printenv

The quotes are necessary when the value of the what you're setting contains spaces.
