## Download the Rascal filesystem release: Cooties ##

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
            <td>July 9, 2013</td>
            <td>140 MB</td>
            <td>1c99a1f69b6e31d2570ea537e16f5ed8</td>
            <td><a href="/files/rascal-filesystem-cooties-rc1-2013-07-09.tar.gz">rascal-filesystem-cooties-rc1-2013-07-09.tar.gz</a></td>
        </tr>
    </tbody>
</table>

Follow the [microSD card tutorial][1] to copy the filesystem onto the Rascal's microSD card.

## Description of changes since previous release ##

* Split the [Red, the Rascal editor][2] and [the Rascal demo collection][3] into two separate git repositories
* Add tabbed editing to Red, the Rascal editor. *Heavy-duty thanks* to D. Small for this.
* Add filename to browser tab titles, thanks to Prof. Ethan Danahy of Tufts CEEO for the suggestion

* Upgrade Flask to 0.10
* Upgrade Flask-Login to 0.2.3
* Upgrade Jinja2 to 2.7
* Upgrade Werkzeug to 0.9.1, which paves the way for Python 3 in the future
* Upgrade CodeMirror to 3.13 + commits up to 83fdc1e77

* Add lsof, a command line tool for listing open files

* Fix log rotation bug
* Fix race condition in Save, thanks to D. Small

[1]: /docs/advanced-tutorial-new-filesystem-onto-microsd-card.html
[2]: https://github.com/rascalmicro/red
[3]: https://github.com/rascalmicro/demos