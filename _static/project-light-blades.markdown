## Persistent encrypted connections for interactive art ##

### A little background on the project ###

Color Commons is an installation at the [Rose Kennedy Greenway][1] in Boston, USA. Based around the light blades sculpture, which was originally designed in 2008 by Dennis Carmichael of [EDAW][2] (later bought by AECOM), Color Commons makes the light blades interactive, so that anyone can change the color of the lights by sending a text message (like "purple" or "navy blue") to 917-5BL-ADES. Color Commons uses the Rascal microcontroller to receive text messages and talk to a Color Kinetics light controller in a subterranean vault below the Greenway. The interactive features were opened to the public on January 10, 2013, as part of the Greenway's annual Winter Lights festival. More of the non-technical background is [summarized on the New American Public Art blog][6]. The rest of this post focuses on some of the technical innovations that went into making the light blades interactive.

<a href="http://www.flickr.com/photos/ekilby/2600873212/"><img src="/img/eric-kilby-light-blades.jpg" alt="6 green steel blades, 20 feet high, aimed at the sky"></a>

## What's innovative about the Rascal and Color Commons? ##

### Handling text messages ###

The Rascal can receive text messages from the internet, and almost everyone in Boston these days has a phone that can send text messages. This makes a new kind of interactive art possible-- any random person on the street is equipped to participate-- but that's only the first step of innovation.

### Persistent connection to an external server ###

The second innovative step of the Rascal's use in Color Commons is that it's operating on the Greenway's public wifi network. Quite sensibly, the Greenway's firewall protects computers on their wifi network from the dangers of the public internet, but this also prevents the Rascal from receiving text messages directly. To get around this, the Rascal makes an encrypted connection to a generic Linux server in a datacenter in New Jersey. This server listens to the public internet for new messages and sends them to the Rascal when they arrive. The encryption isn't actually necessary in this application, but it does prevent other devices on the network from hijacking the connection to the Rascal.

This kind of connection can be useful for all sorts of interactive work. Normally, most internet connections, like the cable or DSL modem in your house, have a built-in firewall that protects your computer from crap on the internet. They work by blocking everything but responses to requests that you initiate. It's like if you order a pizza from Aaron Burr's Delicious Pizza, and then a few minutes later, a dude shows up outside your house wearing a shirt that says "Aaron Burr's Delicious Pizza", you think, "Ah, that's probably my pizza. I'll open the door." On the other hand, if you are awoken in the night by a man in a cloak ringing the doorbell, and he's holding a handwritten sign saying "Real cheap pizza", I don't think it would be a good idea to open the door.

The interesting bit is that once you open the door and start talking to the (legitimate) pizza guy, the conversation can continue as long as you want. That's how this technique works. Your Rascal starts a conversation with a remote server. (Strictly speaking, it is a TCP connection encrypted using the SSH protocol.) After the conversation is started, both the Rascal and the remote server can continue the conversation. The server is configured to pass all traffic on a certain port directly along to your Rascal, which allows the Rascal to function like it is outside the firewall.

### Managing the encrypted connection ###

Because the Rascal is connecting across the Greenway's wireless mesh network, the Rascal makes an attempt to recover if the connection drops out temporarily, as tends to happen with wireless connections. The Rascal runs a program called [Autossh][3]. Autossh uses the SSH (Secure Shell) program to connect to a remote server, as mentioned earlier. Autossh also establishes a second connection in parallel for the purposes of monitoring the state of the connection. Every 10 minutes, Autossh checks that the connection is still up. If the connection drops, it attempts to restart the connection immediately. If that fails, it tries repeatedly, but at ever-increasing intervals.

Because all the details are kind of beleaguering, the Rascal also comes with a configuration page, shown in the screenshot below, that you can use to manage the connection. This open source software was developed for the Color Commons project, but it will ship in future releases of the Rascal software. (Thanks go to Massachusetts denizen Mike Goelzer for doing a substantial part of the coding, as well as to the authors of Autossh, which is also open source.)

<img src="/img/autossh-config.png">
<h5>Screenshot of the Rascal's Autossh configuration page</h5>

To set up a connection, you need a server on the internet somewhere. Fortunately, in this modern age, you don't need to buy a real server, made of metal, plastic, and silicon; you can just rent a server for around $20/month. For Color Commons, we used the cheapest server available from [Linode][4], but most any server running Linux would work. Assuming the server comes with an SSH server running, which appears to always be the case, the only server setup beyond paying for the rental is adding the Rascal's public encryption key to the server's list of authorized keys. Linode has a brief explanation of how to [add a public key to your server][5].

[1]: http://rosekennedygreenway.org
[2]: http://aecom.com
[3]: http://www.harding.motd.ca/autossh/
[4]: http://linode.com/
[5]: http://library.linode.com/security/ssh-keys
[6]: http://newamericanpublicart.tumblr.com/post/40131886561/hacking-ginormous-public-art-to-make-it-more