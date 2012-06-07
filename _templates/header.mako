    <div class="navbar">
        <div class="fill">
            <div class="container">
                <a class="brand" href="/"><img src="/img/rm-logo-words-only-light.png"></a>
                <ul class="nav">
                    <li class="active"><a href="http://store.rascalmicro.com">Store</a></li>
                    <li><a href="/about.htm">About</a></li>
                    <li><a href="/blog/">Blog</a></li>
                    <li><a href="/forum/">Forum</a></li>
                    <li><a href="/docs/">Docs</a></li>
                </ul>
            </div>
        </div>
    </div>
    <script type="text/javascript">
      function activateNavbar() { // From https://gist.github.com/1362111, but with the regex tweaked
        var path = location.pathname.replace (/^(\/.+?\/).+$/, '$1');
        $('ul.nav li').removeClass("active");
        $('ul.nav a[href="' + path + '"]').parent().addClass("active");
      }
      $(function(){
        activateNavbar();
      })
    </script>