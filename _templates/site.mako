<%inherit file="base.mako" /><!DOCTYPE html>
<html lang="en">${self.head()}
    <body>
        ${self.header()}
        <div class="container">
            <div class="hero-unit">
            ${next.body()}
            </div>
        </div>
        ${self.footer()}
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
