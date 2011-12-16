<!DOCTYPE html>
<html lang="en">
<%include file="head.mako" />
<body>
<%include file="header.mako" />
    <div class="container">
        <div class="hero-unit">
            <div class="image">
                <div class="active ring row pane-home">
                    <img src="/img/rascal-glamour-shot.jpg" width="820px" alt="A red circuit board used for controlling the universe">                    
                </div>
                <div class="ring row pane-connect">
                    <img src="/img/rascal-summary-diagram-820x575px.png" width="820px" alt="A diagram showing a connection between a Rascal and a laptop">
                </div>
                <div class="ring row pane-arduino">
                    <img src="/img/rascals-with-arduino-shields-820x575px.jpg" width="820px" alt="Three Rascals with Arduino shields plugged in">
                </div>
                <div class="ring row pane-web-editor">
                    <img src="/img/web-editor-with-white-borders.png" width="820px" alt="Screenshot of a web browser with an editor inside">
                </div>
                <div class="ring row pane-open-source">
                    <img src="/img/rascal-glamour-shot.jpg" width="820px" alt="Circuit diagrams for the Rascal">
                </div>
                <h1 id="the-rascal">The Rascal</h1>
                <div id="bullet-strip" class="row">
                    <div class="span5">
                        <ul class="bullets">
                            <li id="home-dot">&bull;</li>
                            <li id="connect-dot">&bull;</li>
                            <li id="arduino-dot">&bull;</li>
                            <li id="web-editor-dot">&bull;</li>
                            <li id="open-source-dot">&bull;</li>
                        </ul>
                    </div>
                    <div class="span2 offset7">    
                        <p><a class="btn primary large" href="http://store.rascalmicro.com">Buy &raquo;</a></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="ring active row pane-home">
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
        <div class="ring row pane-connect">
            <div class="span8">
                <h2>How do I use the Rascal?</h2>
                <p>At its heart, the Rascal is a web server. You can make web pages with buttons that trigger the hardware you plug in; you can also read data from sensors and graph the results in a web page. You can plug in some sensors directly, or you can use one of the hundreds of premade boards that work with the Rascal to do something more complex. Most Arduino shields work with the Rascal out of the box.</p>
            </div>
            <div class="span8">
                <h2>How do I program the Rascal?</h2>
                <p>The Rascal comes with Pytronics, a Python library of simple functions for reading sensors and talking to shields. For the web interface, you can copy and paste HTML from the examples on board. To make using Javascript easier, jQuery and the jQplot graphing plugin are preinstalled. The web interface uses Flask, a Python web framework that makes dreary stuff like authentication and timed events easier.</p>
            </div>
        </div>
        <div class="ring row pane-arduino">
            <div class="span16">
                <h2>Works with most Arduino shields</h2>
                <p>The Rascal has the standard headers used by the Arduino family of microcontrollers. Most of the hundreds of existing Arduino shields will work with the Rascal without any tricky business. You can also buy empty shields designed for prototyping and solder up your own circuits to work directly with the Rascal. With a screw terminal shield, you can connect some devices to the Rascal without any soldering at all.</p>
            </div>
        </div>
        <div class="ring row pane-web-editor">
            <div class="span16">
                <h2>Web-based editor</h2>
                <p>Because the Rascal is a web server, it hosts its own editor. You can edit files directly on the Rascal from your web browser; no connection to the larger Internet is necessary. The Rascal comes with a pile of liberally-licensed demo pages that you can copy and tweak as much as you like.</p> 
                <p>If you're the type who lives at the command line, you can always SSH into the Rascal-- you'll find that the Rascal has a heavy-duty suite of command line tools.</p>
            </div>
        </div>
        <div class="ring row pane-open-source">
            <div class="span16">
                <h2>100% open source</h2>
                <p>The Rascal is built from the ground up with open source technologies. The hardware design, created by Brandon Stafford of Rascal Micro, is available to you for free under a Creative Commons license. The software consists of the Linux kernel, the GNU tools, and a host of higher level languages and tools, all available under various free licenses. The Rascal source code is on Github, and all the hardware sources are posted on the <a href="/docs/sources.html">sources</a> page.</p>
                <p>Next, take a look at the <a href="/docs/">tutorials</a> page to see all the cool stuff you can build with the Rascal!</p>
            </div>
        </div>
    </div> <!-- /container -->
<%include file="footer.mako" />
    <script type="text/javascript">
    $(".bullets > li").css("color", "#414243");
    $("#home-dot").css("color", "#C6433C");
    
    $("#home-dot").click(function(){
        $(".bullets > li").css("color", "#414243");
        $("#home-dot").css("color", "#C6433C");
        $(".active").removeClass("active");
        $(".pane-home").addClass("active");
    });
    $("#connect-dot").click(function(){
        $(".bullets > li").css("color", "#414243");
        $("#connect-dot").css("color", "#C6433C");
        $(".active").removeClass("active");
        $(".pane-connect").addClass("active");
    });
    $("#arduino-dot").click(function(){
        $(".bullets > li").css("color", "#414243");
        $("#arduino-dot").css("color", "#C6433C");
        $(".active").removeClass("active");
        $(".pane-arduino").addClass("active");
    });
    $("#web-editor-dot").click(function(){
        $(".bullets > li").css("color", "#414243");
        $("#web-editor-dot").css("color", "#C6433C");
        $(".active").removeClass("active");
        $(".pane-web-editor").addClass("active");
    });
    $("#open-source-dot").click(function(){
        $(".bullets > li").css("color", "#414243");
        $("#open-source-dot").css("color", "#C6433C");
        $(".active").removeClass("active");
        $(".pane-open-source").addClass("active");
    });
    </script>
</body>
</html>