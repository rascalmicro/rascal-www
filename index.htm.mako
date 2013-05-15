<!DOCTYPE html>
<html lang="en">
<%include file="head.mako" />
<body>
<%include file="header.mako" />
    <div class="container">
        <div class="hero-unit">
            <h1 id="the-rascal">Get on the web faster</h1>
            <img src="/img/rascal-1.1.jpg" width="820px" alt="A red circuit board used for controlling the universe">
            <div class="span2 offset9">    
                <p><a class="btn btn-primary btn-large" href="http://store.rascalmicro.com">Buy &raquo;</a></p>
            </div>
        </div>
        <div class="ring active row pane-home">
            <div class="span12">
                <h2>It should be easier to talk to hardware from your web browser.</h2>
                <p class="lead">With the Rascal, you get a web interface that's ready to help you test new hardware and develop projects fast.</p>
            </div>
        </div>
        <div class="row">
            <div class="span6">
                <h2>Test digital I/O</h2>
                <a href="/img/test-i2c-2013-05-15.png"><img src="/img/test-pins-screenshot.png" width="440px" alt="A red circuit board used for controlling the universe"></a>
                <p>Use the I/O testing page to set pins high and low without writing any code.</p>
            </div>
            <div class="span6">
                <h2>Test I<sup>2</sup>C devices</h2>
                <a href="/img/test-i2c-2013-05-15.png"><img src="/img/test-i2c-screenshot.png" width="440px" alt="A red circuit board used for controlling the universe"></a>
                <p>Plug in an I<sup>2</sup>C device and quickly scan the bus to detect it. Read and write to different addresses to test that your hardware works.</p>
            </div>
        </div>
        <div class="row">
            <div class="span12">
                <h2>Testimonials</h2>
                <blockquote>
                    <p>"Loving my new Rascal! It's been a great learning tool for Python and a great experience altogether."</p>
                    <small>Glenn L., Winnipeg, Canada</small>
                </blockquote>
                <blockquote>
                    <p>"Developing on the Rascal is really straightforward and simple to debug. The platform comes packaged with an interactive I2C web interface that allows an easy of checking to see if the attached device is working, and allows sending of commands to help understand how the device works.</p>
                    <small>Stephen A., Manchester, UK</small>
                </blockquote>
                <blockquote>
                    <p>"What I had hoped would happen with my son is indeed happening. We are demystifying the Internet and web-based applications by learning the lower level protocols and tools that the whole world is using to create all the things most people just take at face value. I'm not trying to push [my son] into a career plan in IT, but understanding the stack of tools and protocols used in IT is a great foundation for any science-oriented career path. And the Rascal is just the right level of accessibility and challenge for him right now. It's learning about computers at the "First Principles" level that I think is going to be so valuable. And we're having a blast doing this together!"</p>
                    <small>Bill S., Maryland, USA</small>
                </blockquote>
            </div>
        </div>
    </div> <!-- /container -->
<%include file="footer.mako" />
</body>
</html>
