## Advanced tutorial: creating an Amazon machine image ##

### Why you don't actually need to do this ###

Most likely, you don't need to create an Amazon machine image to build your own Rascal filesystem because *we have already built one for you*. In fact, these instructions are only here because we occasionally need to build a new image for a new software release, and it's easier to store the documentation on the internet than anywhere else. If you just want to build your own filesystem, read the [build guide][1]. Otherwise, read on.

## Get an Amazon Web Services account ##

Amazon already documents how to [sign up for an Elastic Compute Cloud account and create a key pair][2], so we'll skip that here.

## Setting up an AMI ##

First, since you will want to log into your machine image via SSH, you'll want to create a security group that allows connections on the SSH port, which is 22. 

Here's what you should do.

* Security group > inbound
* Add custom TCP rule
* port 22, 0.0.0.0/0
* Add rule
* Apply rule changes

After that, you can log into an AMI using a command like this
$$code(lang=bash)
ssh -i path/to/private/key.pem ubuntu@ec2-184-72-81-244.compute-1.amazonaws.com
$$/code

We'll start building the image using a stock Ubuntu image as a base. We'll use an EBS-backed image because we're going to want to add more storage later on.

The most recent images have been based on:

* ami-37af765e, US east 1, 32-bit, EBS, Ubuntu 10.04 LTS Lucid Lynx
* ami-a29943cb: The canonical US east 1, 64-bit, EBS, Ubuntu 12.04 LTS Precise Pangolin image

Launch the AMI as type c1.medium (meaning a High-CPU instance). Remember what zone you launch into (like us-east-1c).

After the instance is launched, log in and install Git, OpenEmbedded, and the like as described in the [build guide][3].

## Expanding the filesystem ##

The stock EBS filesystem is usually 8 GB, which is too small for building OpenEmbedded, so you need to create a new, larger EBS from the stock one. Here are the steps.

* Stop AMI
* Go to Elastic Block Store > Volumes in EC2 console, note id of new volume.
* Go to Elastic Block Store > Snapshot in EC2 console
* Create snapshot of volume, add a name and description. Wait a few minutes for snapshot to complete.
* Back to Elastic Block Store > Volumes in EC2 console and "Create Volume." Base the new volume on the snapshot you just created, but increase the size to 40 GiB. Make sure the availability zone is the same as above (us-east-1c).
* Detach old volume that came with AMI.
* Attach new, larger volume at /dev/sda1.
* Back to console > Instances and start the instance.
* Get the new public DNS name, which will have changed.

If everything looks like it's working correctly, take a snapshot. You may also want to create an AMI from that snapshot if you want to share the image with outher people. After that, you can build OE or do whatever you want.

### Notes about tweaking filesystem and screen ###

With Ubuntu 12.04 LTS, the filesystem expands automatically on reboot. Also, rather than being mounted at /dev/sda1, is actually mounted at /dev/xvda1

For older Ubuntus, like 10.04 LTS, you have to log in and expand the filesystem manually:
$$code(lang=bash)
sudo resize2fs /dev/sda1
$$/code

To make colors work in screen, uncomment in ~/.bashrc:
$$code(lang=bash)
force_color_prompt=yes
$$/code

[1]: /docs/build-guide.html
[2]: http://docs.amazonwebservices.com/AWSEC2/latest/GettingStartedGuide/GetStartedLinux.html
[3]: /docs/build-guide.html