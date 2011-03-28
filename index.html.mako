<%inherit file="_templates/site.mako" />

% for post in bf.posts:
  <%include file="_templates/post.mako" args="post=post" />
    <hr class="interblog" />
% endfor
% if prev_link:
  <a href="${prev_link}">« Previous Page</a>
% endif
% if prev_link and next_link:
  --  
% endif
% if next_link:
<a href="${next_link}">Next Page »</a>
% endif

Feeds for <a href="${bf.util.site_path_helper(bf.config.blog.path,'feed')}">entries</a></p>
