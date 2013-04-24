<%page args="post"/>
<div class="blog_post">
  <a name="${post.slug}"></a>
  <h2 class="blog_post_title"><a href="${post.permapath()}" rel="bookmark" title="Permanent Link to ${post.title}">${post.title}</a></h2>
  <h6>${post.date.strftime("%B %d, %Y")} by Brandon Stafford</h6>
  <div class="post_prose">
    ${self.post_prose(post)}
  </div>

  <div class="fb-like" data-href="http://rascalmicro.com${post.permapath()}" data-send="false" data-layout="button_count" data-width="450" data-show-faces="false" data-font="trebuchet ms"></div>
  <div class="g-plusone" data-size="medium" data-href="http://rascalmicro.com${post.permapath()}"></div>
  <a href="//pinterest.com/pin/create/button/?url=http://rascalmicro.com${post.permapath()}&media=http%3A%2F%2Frascalmicro.com%2Fimg%2Frascal-1.1.jpg&description=Rascal%20Micro%3A%20small%20computers%20for%20art%20and%20science" data-pin-do="buttonPin" data-pin-config="beside"><img src="//assets.pinterest.com/images/pidgets/pin_it_button.png" /></a>
    <a href="https://twitter.com/share" class="twitter-share-button" data-via="rascalmicro" data-url="http://rascalmicro.com${post.permapath()}" data-text="${post.title}" data-size="small">Tweet</a>
</div>

<%def name="post_prose(post)">
  ${post.content}
</%def>
