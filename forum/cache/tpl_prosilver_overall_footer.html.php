<?php if (!defined('IN_PHPBB')) exit; ?></div>
		
		<div id="page-footer">
		
			<div class="navbar">
				<div class="inner"><span class="corners-top"><span></span></span>
		
				<ul class="linklist">
					<li class="icon-home"><a href="<?php echo (isset($this->_rootref['U_INDEX'])) ? $this->_rootref['U_INDEX'] : ''; ?>" accesskey="h"><?php echo ((isset($this->_rootref['L_INDEX'])) ? $this->_rootref['L_INDEX'] : ((isset($user->lang['INDEX'])) ? $user->lang['INDEX'] : '{ INDEX }')); ?></a></li>
						<?php if (! $this->_rootref['S_IS_BOT']) {  if ($this->_rootref['S_WATCH_FORUM_LINK']) {  ?><li <?php if ($this->_rootref['S_WATCHING_FORUM']) {  ?>class="icon-unsubscribe"<?php } else { ?>class="icon-subscribe"<?php } ?>><a href="<?php echo (isset($this->_rootref['S_WATCH_FORUM_LINK'])) ? $this->_rootref['S_WATCH_FORUM_LINK'] : ''; ?>" title="<?php echo (isset($this->_rootref['S_WATCH_FORUM_TITLE'])) ? $this->_rootref['S_WATCH_FORUM_TITLE'] : ''; ?>"><?php echo (isset($this->_rootref['S_WATCH_FORUM_TITLE'])) ? $this->_rootref['S_WATCH_FORUM_TITLE'] : ''; ?></a></li><?php } if ($this->_rootref['U_WATCH_TOPIC']) {  ?><li <?php if ($this->_rootref['S_WATCHING_TOPIC']) {  ?>class="icon-unsubscribe"<?php } else { ?>class="icon-subscribe"<?php } ?>><a href="<?php echo (isset($this->_rootref['U_WATCH_TOPIC'])) ? $this->_rootref['U_WATCH_TOPIC'] : ''; ?>" title="<?php echo ((isset($this->_rootref['L_WATCH_TOPIC'])) ? $this->_rootref['L_WATCH_TOPIC'] : ((isset($user->lang['WATCH_TOPIC'])) ? $user->lang['WATCH_TOPIC'] : '{ WATCH_TOPIC }')); ?>"><?php echo ((isset($this->_rootref['L_WATCH_TOPIC'])) ? $this->_rootref['L_WATCH_TOPIC'] : ((isset($user->lang['WATCH_TOPIC'])) ? $user->lang['WATCH_TOPIC'] : '{ WATCH_TOPIC }')); ?></a></li><?php } if ($this->_rootref['U_BOOKMARK_TOPIC']) {  ?><li class="icon-bookmark"><a href="<?php echo (isset($this->_rootref['U_BOOKMARK_TOPIC'])) ? $this->_rootref['U_BOOKMARK_TOPIC'] : ''; ?>" title="<?php echo ((isset($this->_rootref['L_BOOKMARK_TOPIC'])) ? $this->_rootref['L_BOOKMARK_TOPIC'] : ((isset($user->lang['BOOKMARK_TOPIC'])) ? $user->lang['BOOKMARK_TOPIC'] : '{ BOOKMARK_TOPIC }')); ?>"><?php echo ((isset($this->_rootref['L_BOOKMARK_TOPIC'])) ? $this->_rootref['L_BOOKMARK_TOPIC'] : ((isset($user->lang['BOOKMARK_TOPIC'])) ? $user->lang['BOOKMARK_TOPIC'] : '{ BOOKMARK_TOPIC }')); ?></a></li><?php } if ($this->_rootref['U_BUMP_TOPIC']) {  ?><li class="icon-bump"><a href="<?php echo (isset($this->_rootref['U_BUMP_TOPIC'])) ? $this->_rootref['U_BUMP_TOPIC'] : ''; ?>" title="<?php echo ((isset($this->_rootref['L_BUMP_TOPIC'])) ? $this->_rootref['L_BUMP_TOPIC'] : ((isset($user->lang['BUMP_TOPIC'])) ? $user->lang['BUMP_TOPIC'] : '{ BUMP_TOPIC }')); ?>"><?php echo ((isset($this->_rootref['L_BUMP_TOPIC'])) ? $this->_rootref['L_BUMP_TOPIC'] : ((isset($user->lang['BUMP_TOPIC'])) ? $user->lang['BUMP_TOPIC'] : '{ BUMP_TOPIC }')); ?></a></li><?php } } ?>

					<li class="rightside"><?php if ($this->_rootref['U_TEAM']) {  ?><a href="<?php echo (isset($this->_rootref['U_TEAM'])) ? $this->_rootref['U_TEAM'] : ''; ?>"><?php echo ((isset($this->_rootref['L_THE_TEAM'])) ? $this->_rootref['L_THE_TEAM'] : ((isset($user->lang['THE_TEAM'])) ? $user->lang['THE_TEAM'] : '{ THE_TEAM }')); ?></a> &bull; <?php } if (! $this->_rootref['S_IS_BOT']) {  ?><a href="<?php echo (isset($this->_rootref['U_DELETE_COOKIES'])) ? $this->_rootref['U_DELETE_COOKIES'] : ''; ?>"><?php echo ((isset($this->_rootref['L_DELETE_COOKIES'])) ? $this->_rootref['L_DELETE_COOKIES'] : ((isset($user->lang['DELETE_COOKIES'])) ? $user->lang['DELETE_COOKIES'] : '{ DELETE_COOKIES }')); ?></a> &bull; <?php } echo (isset($this->_rootref['S_TIMEZONE'])) ? $this->_rootref['S_TIMEZONE'] : ''; ?></li>
				</ul>
		
				<span class="corners-bottom"><span></span></span></div>
			</div>
		
		<!--
			We request you retain the full copyright notice below including the link to www.phpbb.com.
			This not only gives respect to the large amount of time given freely by the developers
			but also helps build interest, traffic and use of phpBB3. If you (honestly) cannot retain
			the full copyright we ask you at least leave in place the "Powered by phpBB" line, with
			"phpBB" linked to www.phpbb.com. If you refuse to include even this then support on our
			forums may be affected.
		
			The phpBB Group : 2006
		//-->
		</div>
		</div>
		</div>
		<div id="footer">
		    <div class="rascalcontent">
		        <div id="bottomcontent">
		            <p>"He who receives an idea from me, receives instruction himself without lessening mine;<br>as he who lights his taper at mine, receives light without darkening me."<br>&ndash;Tom Jefferson</p>
		        </div>
		        <div id="bottombar">
					<?php if ($this->_rootref['TRANSLATION_INFO']) {  ?><br /><?php echo (isset($this->_rootref['TRANSLATION_INFO'])) ? $this->_rootref['TRANSLATION_INFO'] : ''; } if ($this->_rootref['DEBUG_OUTPUT']) {  ?><br /><?php echo (isset($this->_rootref['DEBUG_OUTPUT'])) ? $this->_rootref['DEBUG_OUTPUT'] : ''; } if ($this->_rootref['U_ACP']) {  ?><br /><strong><a href="<?php echo (isset($this->_rootref['U_ACP'])) ? $this->_rootref['U_ACP'] : ''; ?>"><?php echo ((isset($this->_rootref['L_ACP'])) ? $this->_rootref['L_ACP'] : ((isset($user->lang['ACP'])) ? $user->lang['ACP'] : '{ ACP }')); ?></a></strong><?php } ?>

                    <p><a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://creativecommons.org/images/public/somerights20.png" /></a><br />The posts in the forums are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>. The forum code runs on <a href="http://www.phpbb.com/">phpBB</a>, available under <a href="http://www.phpbb.com/downloads/license/">the GNU General Public License, version 2</a>.</p>
                    <p><a href="http://rascalmicro.com/docs/privacy.html">Privacy policy</a></p>
		        </div>
		    </div>
		</div>
    <script type="text/javascript"> 

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-96134-3']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type =
    'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' :
    'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(ga, s);
      })();

    </script>
		<div>
			<a id="bottom" name="bottom" accesskey="z"></a>
			<?php if (! $this->_rootref['S_IS_BOT']) {  echo (isset($this->_rootref['RUN_CRON_TASK'])) ? $this->_rootref['RUN_CRON_TASK'] : ''; } ?>

		</div>
</body>
</html>