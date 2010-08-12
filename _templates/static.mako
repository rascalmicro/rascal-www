<%inherit file="_templates/site.mako" />


<%def name="filter(chain)">
    ${bf.filter.run_chain(chain, capture(caller.body))}
</%def>

<%self:filter chain="markdown, syntax_highlight">
${page}
</%self:filter>
