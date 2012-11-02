## Download the Rascal filesystem release: Beriberi ##

The final release of Beriberi is still forthcoming. So far, we have two release candidates.

*Note that "release candidates" are less well tested and may set your Rascal on fire.*

<table class="table table-striped table-bordered table-condensed">
    <thead>
        <tr>
            <th>Release</th>
            <th>Date</th>
            <th>Size</th>
            <th>MD5 hash</th>
            <th>Download link</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Release candidate 1</td>
            <td>September 24, 2012</td>
            <td>134 MB</td>
            <td>d51484894c494edd79904cb9dbe98f65</td>
            <td><a href="/files/rascal-filesystem-beriberi-rc1-2012-09-24.tar.gz">rascal-filesystem-beriberi-rc1-2012-09-24.tar.gz</a></td>
        </tr>
        <tr>
            <td>Release candidate 2</td>
            <td>October 30, 2012</td>
            <td>136 MB</td>
            <td>66e8f211bff806c07136f5ac33caf26b</td>
            <td><a href="/files/rascal-filesystem-beriberi-rc2-2012-10-30.tar.gz">rascal-filesystem-beriberi-rc2-2012-10-30.tar.gz</a></td>
        </tr>
    </tbody>
</table>

Follow the [microSD card tutorial][4] to copy the filesystem onto the Rascal's microSD card.

## Description of changes since previous release ##

* Tweaked kernel to support swap files (see [this diff][1] for the gory kernel config details)
* Tweaked U-boot to allow saved environments, so you can boot in crazy ways (thanks to D. Hylands)

* New documentation tab feature (thanks to D. Small)
* New joystick demo (thanks to [R. Klancer][2])
* New BlinkM knob demo (thanks to D. Small)
* Reworking of Pytronics reloading code (thanks to D. Small)
* Squashing of a [nasty iOS6 POST caching bug][3] (thanks to D. Small)
* A pile of other small documentation and demo improvements (thanks to D. Small)
* New SPI functions added to Pytronics

* Upgrade Flask to 0.9
* Upgrade Numpy to 1.6.2
* Upgrade jQuery to 1.8.2
* Upgrade Twitter Bootstrap to 2.1.1
* Upgrade jqPlot to 1.0.4 and add plugins
* Upgrade Modernizr to 2.6.1
* Upgrade CodeMirror to 2.35

* Add OpenCV and Python bindings
* Add Python Markdown2 preprocessor
* Add Pygments Python library
* Add Knob 1.2.0 jQuery plugin
* Add Kenneth Reitz's excellent Requests library
* Add command-line client for BlinkM LEDs
* Add Screen, a terminal multiplexer
* Add the Sh Python library
* Add Autossh, an SSH wrapper for persistent tunneling (thanks to M. Goelzer for init script work and testing)

* New drivers for wireless USB adapters, like the Iogear GWU523 and the Edimax EW-7811UN, plus supporting software (WPA-supplicant and wireless-tools)

[1]: https://github.com/rascalmicro/linux-2.6/commit/36d70d630a6f732a05bfb91c1c90c0cca86edf6d#.config
[2]: https://github.com/rklancer/touchjoy
[3]: /forum/viewtopic.php?f=1&t=71
[4]: /docs/advanced-tutorial-new-filesystem-onto-microsd-card.html
