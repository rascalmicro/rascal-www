<%inherit file="base.mako" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" type="text/css" href="/../style.css"> 
        ${self.head()}
    </head>
    <body>
        <div class="content">
            ${self.header()}
            <div id="torso">
                <div class="rascalcontent">
                    <div id="main_block">
                        <div id="prose_block">
                        ${next.body()}
                        </div><!-- end prose block -->
                    </div><!-- end main block -->
                </div>
            </div>
            <div id="footer">
                ${self.footer()}
            </div> <!-- end footer -->
        </div> <!-- end content -->
    </body>
</html>
<%def name="head()">
  <%include file="head.mako" />
</%def>
<%def name="header()">
  <%include file="header.mako" />
</%def>
<%def name="footer()">
  <%include file="footer.mako" />
</%def>
