<!DOCTYPE html>
<html lang="en">
<%include file="head.mako" />
<body>
<%include file="header.mako" />
    <div class="container">
        <div class="hero-unit">
            <h1>The Rascal</h1>
            <div class="tab-content">
                <div class="active row tab-pane" id="home">
                    <img src="/img/rascal-glamour-shot.jpg" width="820px" alt="How the Rascal works">
                </div>
                <div class="row tab-pane" id="connect">
                    <img src="/img/950px-rascal-0.2.jpg" width="820px" alt="How the Rascal works">
                </div>
            </div>
            <div class="row">
                <div class="span5">
                    <ul class="tabs" data-tabs="tabs">
                        <li class="active"><a href="#home">&nbsp;</a></li>
                        <li><a href="#connect">&nbsp;</a></li>
                        <li><a href="#arduino">&nbsp;</a></li>
                        <li><a href="#web-editor">&nbsp;</a></li>
                        <li><a href="#open-source">&nbsp;</a></li>
                    </ul>
                </div>
                <div class="span3 offset6">    
                    <p><a class="btn primary large" href="http://store.rascalmicro.com">Buy one &raquo;</a></p>
                </div>
            </div>
        </div>
        <div class="tab-content">
            <div class="active row tab-pane" id="home">
                <div class="span8">
                    <h2>What is the Rascal?</h2>
                    <p>The Rascal is a small computer that you can use to monitor and control the world remotely. It's like the brains of an iPhone, without the corporate overlord. The Rascal is powerful enough to handle real web traffic, but you don't have to be a professional electrical engineer to use one.</p> 
                    <p>The Rascal has its own web-based editor on board, it works with most Arduino shields, and you can program it in Python.</p>
                </div>
                <div class="span8">
                    <h2>Why do I need one?</h2>
                    <p>Maybe you played with legos or erector sets as a kid. Maybe you just got into hacking electronics recently. Either way, you're one of the pioneers of a new era. Instead of saying, "They should make one of those that connects to the internet," you do it yourself.</p>
                    <p>You're part of the vanguard of internet gadgeteers, and it's already 2011! Get to work!</p>
                </div>
            </div>
            <div class="row tab-pane" id="connect">
                <div class="span16">
                    <h2>How do I use the Rascal?</h2>
                    <p>The Rascal is a web server. Connect one end to the Internet and the other end to sensors or actuators.</p>
                </div>
            </div>
            <div class="row tab-pane" id="arduino">
                <div class="span16">
                    <h2>Works with most Arduino shields</h2>
                    <p>The Rascal has the standard headers used by the Arduino family of microcontrollers. Most Arduino shields will work with the Rascal without any tricky business.</p>
                </div>
            </div>
            <div class="row tab-pane" id="web-editor">
                <div class="span16">
                    <h2>Web-based editor</h2>
                    <p>Because the Rascal is a web server, it hosts its own editor. You can edit files directly on the Rascal from your web browser; no connection to the larger Internet is necessary. The Rascal comes with a pile of liberally-licensed demo pages that you can copy and tweak as much as you like.</p> 
                    <p>If you're the type who lives at the command line, you can always SSH into the Rascal-- you'll find that the Rascal has a heavy-duty suite of command line tools.</p>
                </div>
            </div>
            <div class="row tab-pane" id="open-source">
                <div class="span16">
                    <h2>100% open source</h2>
                    <p>The Rascal is built from the ground up with open source technologies. The hardware design, created by Rascal Micro, is available to you for free under a Creative Commons license. The software consists of the Linux kernel, the GNU tools, and a host of higher level languages and tools, all available under various free licenses.</p>
                </div>
            </div>
        </div> <!-- /tab-content -->
    </div> <!-- /container -->
<%include file="footer.mako" />
</body>
</html>