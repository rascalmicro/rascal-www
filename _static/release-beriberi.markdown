## Download the Rascal filesystem release: Beriberi ##

The final release of Beriberi is still forthcoming. So far, we just have a release candidate.

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
    </tbody>
</table>

Follow the [microSD card tutorial][4] to copy the filesystem onto the Rascal's microSD card.

## Description of changes since previous release ##

### Stuff that is already done ###

* Tweaked kernel to support swap files (see [this diff][1] for the gory kernel config details)
* Tweaked U-boot to allow saved environments, so you can boot in crazy ways (thanks to D. Hylands)

* New documentation tab feature (thanks to D. Small)

* Upgrade Numpy to 1.6.2
* Upgrade jQuery to 1.8.2
* Upgrade Twitter Bootstrap to 2.1.1
* Upgrade jqPlot to 1.0.4 and add plugins
* Upgrade to Modernizr 2.6.1

* Add OpenCV and Python bindings
* Add Python Markdown2 preprocessor
* Add Pygments Python library
* Add Knob 1.2.0 jQuery plugin
* Add Kenneth Reitz's excellent Requests library
* Add command-line client for BlinkM LEDs
* Add Screen, a terminal multiplexer
* Add the Sh Python library

* New drivers for wireless USB adapters, like the Iogear GWU523 and the Edimax EW-7811UN, plus supporting software (WPA-supplicant and wireless-tools)

### Stuff we hope will make it in to the final release ###

* Add Nose, a Python test library

[1]: https://github.com/rascalmicro/linux-2.6/commit/36d70d630a6f732a05bfb91c1c90c0cca86edf6d#.config
[4]: /docs/advanced-tutorial-new-filesystem-onto-microsd-card.html
