## Wiping microSD card and copying on OpenEmbedded image ##

First, you have to figure out the name of the card that you want to wipe in your device hierarchy. To do this, check dmesg, insert the card, and then check dmesg again. The new text that shows up at the end should tell you where the card you inserted was mounted-- it's often something like /dev/sdb1.

(Note [cautionary tale][1] about accidentally wiping hard drive's boot sector at the end of blog post.)

*Wipe the card clean*
(Warning: this, uh, wipes the card clean.)
$$code(lang=bash)
brandon@milo:/oe$ sudo -s # become the superuser.
[sudo] password for brandon: 
root@milo:/oe# umount /dev/sdb1 # unmount the card
root@milo:/oe# mkfs.ext3 -L rascal-beta /dev/sdb1 # wipe everything and make a new EXT3 filesystem
mke2fs 1.41.12 (17-May-2010)
Filesystem label=transcend-ext3
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
246512 inodes, 984320 blocks
49216 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=1010827264
31 block groups
32768 blocks per group, 32768 fragments per group
7952 inodes per group
Superblock backups stored on blocks: 
    32768, 98304, 163840, 229376, 294912, 819200, 884736
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
This filesystem will be automatically checked every 29 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
$$/code

Now, pull the card out and reinsert it so that it gets remounted.

## Find an archive of the filesystem you want to use ##

Tarballs of the stock filesystem can be found on the [sources][2] page. Download one of these, copy it onto your card, and extract the filesystem.

For example:
$$code(lang=bash)
root@milo:/oe# whoami # check that you're still the superuser
root
root@milo:/oe# ls /media # check that the card is mounted
rascal-beta
wget http://rascalmicro.com/files/rascal-filesystem-beriberi-2012-11-09.tar.gz
mv rascal-filesystem-beriberi-2012-11-09.tar.gz /media/rascal-beta/
cd /media/rascal-beta
tar xzvf rascal-filesystem-beriberi-2012-11-09.tar.gz # extract the filesystem
rm rascal-filesystem-beriberi-2012-11-09.tar.gz # delete the tarball
sync # make sure all the data is committed to the card
exit # relinquish root privileges
$$/code

Last, pull out the card and put it back into the Rascal.

## The reverse direction: archiving a filesystem ##

If you want to archive a filesystem, start by unplugging your Rascal, extracting the card, and putting it into your computer.
$$code(lang=bash)
cd /media/rascal-beta/ # change to the root of your SD card
sudo tar czvf /path/to/your/new/tarball.tar.gz *
$$/code

If you have space on the card, you can generate the tarball on the card itself, but it's probably a better idea to generate it on your host computer directly. You have to move it there, anyway.

[1]: /blog/2010/10/18/adding-a-microsd-card-to-the-rascal/
[2]: /docs/sources.html
