---
format: markdown
date: 2011/07/06 00:00:00
title: Self-serve programming tools
categories: rascal, webinterface
---
The Rascal hardware testing has been successful so far-- no major problems have been discovered so far. As a result, I've been able to spend more of my time working on the Rascal programming tools I started back in late January while waiting for hardware fabrication.

The major goal of the Rascal is to make connecting weird stuff to the internet easier. Even though my own background is in programming microcontrollers with obscure tools, I still find the usual programming tools for microcontrollers painful to use, and I know it's worse when you're starting out.

The Rascal is powerful enough that I think we can start building what I call "self-serve" programming tools. Because the Rascal is designed for connecting stuff to the internet, it runs its own webserver. This means that the Rascal can serve its own programming tools-- thus, "self-serve." In the same way that you use webmail to write emails, you can use the Rascal's web editor to edit the rest of the code on the Rascal.

In the long run, you can put whatever you want on the Rascal webserver, but it starts out with some example pages and the editor. There are, of course, some safeguards-- you can't use the editor to delete itself, for example.

The editor still needs work, but here's an early screenshot.

<a href="/img/proto-web-editor-2011-06-21.png"><img class="span14" src="/img/proto-web-editor-2011-06-21.png" width="950px"></a>

In the open source tradition, I didn't write the editor from scratch. The text window itself uses [Codemirror][1]; the file tree uses [jQuery with a file tree plugin][2], and the whole application uses [Flask][3]. Eventually, my code will be properly released under the GPL. In the meantime, the [source][4] to the demo is on Github.

If any other developers want to pick this code up, I'd be glad to have it running on more than one platform, as I have no desire to fall into the "maintain your own IDE" trap that so many compiler vendors fell into before Eclipse came along. I've seen that one of the Beagleboard guys, Jason Kridner, is [treading the same path I am][5], but with the Cloud9 IDE. I originally did my first prototypes of the Rascal system using Bespin, which was eventually merged into Cloud9, but my impression is that Cloud9 is too big for what I want. It looks like Jason's Cloud9 stuff is just an experiment, but it would be great if the Beagleboard started shipping with a web IDE-- I'd love to have TI's help pulling the bandwagon.

If you are so inclined, [discuss this post on the forums][6].

[1]: http://codemirror.net/
[2]: http://abeautifulsite.net/blog/2008/03/jquery-file-tree/
[3]: http://flask.pocoo.org/
[4]: https://github.com/rascalmicro/control-freak/blob/master/templates/editor.html
[5]: http://blog.hangerhead.com/2011/03/nodejs-based-cloud9-javascript-ide.html
[6]: /forum/viewtopic.php?f=7&t=33
