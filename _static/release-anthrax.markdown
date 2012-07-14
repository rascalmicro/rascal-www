## Download the Rascal filesystem release: Anthrax ##

The RC1 release was used on Rascal 1.2 built June 22, 2012.

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
            <td>Release candidate 2</td>
            <td>July 13, 2012</td>
            <td>103 MB</td>
            <td>c7f431bf465905e747cc99252aa969ea</td>
            <td><a href="/files/rascal-filesystem-anthrax-rc2-2012-07-13.tar.gz">rascal-filesystem-anthrax-rc2-2012-07-13.tar.gz</a></td>
        </tr>
        <tr>
            <td>Release candidate 1</td>
            <td>June 22, 2012</td>
            <td>53 MB</td>
            <td>4f7fffef42b9334e031e2ffe149ded23</td>
            <td><a href="/files/rascal-filesystem-anthrax-rc1-2012-06-22.tar.gz">rascal-filesystem-anthrax-rc2-2012-06-22.tar.gz</a></td>
        </tr>
    </tbody>
</table>

Follow the [microSD card tutorial][4] to copy the filesystem onto the Rascal's microSD card.

## Description of changes since previous release ##

 * Updated Pytronics to make functions more closely resemble Arduino libs
 * Updated Control Freak web interface to 0.3RC1 (see subsequent list for details)
 * Added SimpleJSON Python library
 * Added Python imaging library
 * Upgraded Nginx webserver to 1.3.0
 * Upgraded uWSGI Python app server to 1.2.3
 * Upgraded Flask Python web framework to 0.8
 * Upgraded Werkzeug Python network utility library to 0.8.3
 * Upgraded Jinja2 Python templating library to 2.6
 * Made uWSGI and Nginx handle Python and HTTP error messages more nicely
 * New in RC2: Fixed spurious linebreaks in Nginx logs
 * New in RC2: Re-fixed Python error handling
 * New in RC2: New I2C Python bindings based on native fcntl and ctypes Python modules
 * New in RC2: Improved build process: uWSGI, Flask-Login, vim-syntax, pip and opkg now install correctly
 * New in RC2: New Python libraries: numpy, matplotlib, ipython, networkx, pysolar, python-devel
 * New in RC2: Editor: Refined theme selection
 * New in RC2: Editor: Folders-first filetree sorting
 * New in RC2: Editor: Display app-server log on Python reload
 * New in RC2: Optional interrupt handler added to uWSGI
 
 Thanks to dsmall and mgoelzer for the substantial code contributions to this release.

### New features in Control Freak 0.3 ###

The UK dev team has been hard at work on Control Freak, the web interface for the Rascal, for the last few months. The changes below are the most significant software changes in the Anthrax release.

 * Resizes automatically to fit browser window
 * Scrollable file tree
 * Create new template
    * Error if template exists
 * Create new folder
    * Create new folder in the static folder, error if folder exists
 * Drag and drop files or folders in the file tree
    * Except templates folder, static folder or server.py
 * Drag and drop files from desktop onto file tree
    * Files can be images, HTML, CSS, JavaScript or Python
 * Image preview
    * Images can only be displayed when in the static folder or in a subfolder of the static folder
 * Save current file with Save button, Cmd-S (Mac) or Ctrl-S
 * Warning if about to overwrite unsaved changes
    * Changed file indicated by highlighting the file name
 * Revert current file to previously saved version
    * Click the current file name in the file tree
 * Delete any file or empty folder with warning
    * Except templates folder, static folder or server.py
 * Save editor preferences
    * Can set theme, font size, line height, tab width etc
 * Two new themes, solarized-light and solarized-dark
    * Syntax colours (yes, *colours*) not yet finalised (yes, *finalised*)
 * Preference to highlight active line
    * Currently only supported for default, blackboard, night and solarized themes
 * Themed file tree, icon pane and location bar
    * Currently only supported for default, blackboard, night and solarized themes
 * Rename file
    * If a file with the new name already exists, it is overwritten
 * Search and Replace (experimental)
    * Type Cmd-F/Ctrl-F to search or Cmd-Alt-F/Shift-Ctrl-F to search and replace

[1]: /files/rascal-filesystem-anthrax-rc1-2012-06-22.tar.gz
[2]: /files/rascal-filesystem-anthrax-rc2-2012-07-12.tar.gz
[4]: /docs/advanced-tutorial-new-filesystem-onto-microsd-card.html
