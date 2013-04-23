<%page args="post"/>
<div class="blog_post">
  <a name="${post.slug}"></a>
  <h2 class="blog_post_title"><a href="${post.permapath()}" rel="bookmark" title="Permanent Link to ${post.title}">${post.title}</a></h2>
  <h6>${post.date.strftime("%B %d, %Y")} by Brandon Stafford</h6>
  <div class="post_prose">
    ${self.post_prose(post)}
  </div>
  <a href="https://twitter.com/share" class="twitter-share-button" data-via="rascalmicro" data-url="http://rascalmicro.com${post.permapath()}" data-text="${post.title}" data-size="large">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
  <a href="https://twitter.com/rascalmicro" class="twitter-follow-button" data-show-count="false" data-size="large">Follow @rascalmicro</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
</div>

<%def name="post_prose(post)">
  ${post.content}
</%def>
