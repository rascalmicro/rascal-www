<%inherit file="_templates/site.mako" />
    <div id="torso">
        <div class="rascalcontent">
            <div id="lefttorso">
                <p>The Rascal is still under development, so there's no help to be had yet. If you're interested in hearing the details as the Rascal is developed, stick your email address in the box below and click the button. So far, this means emails about once every 5 weeks.</p>
                <!-- Begin MailChimp Signup Form -->
                <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>
                <script type="text/javascript" src="http://downloads.mailchimp.com/js/jquery.validate.js"></script>
                <script type="text/javascript" src="http://downloads.mailchimp.com/js/jquery.form.js"></script>
                <script type="text/javascript">
                // delete this script tag and use a "div.mce_inline_error{ XXX !important}" selector
                // or fill this in and it will be inlined when errors are generated
                var mc_custom_error_style = '';
                </script>
                <div id="mc_embed_signup">
                    <form action="http://rascalmicro.us1.list-manage.com/subscribe/post?u=1b1bbc0cef4aee1d788f8423d&amp;id=f8f38179b4" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank">
                        <div class="mc-field-group">
                            <label for="mce-EMAIL">Email address:</label>
                            <input type="text" value="" name="EMAIL" class="required email" id="mce-EMAIL">
	                        <div class="response" id="mce-error-response" style="display:none"></div>
	                        <div class="response" id="mce-success-response" style="display:none"></div>
                            <input type="submit" value="Tell me facts!" name="subscribe" id="mc-embedded-subscribe" class="btn">
                        </div>
                    </form>
                </div>
                <script type="text/javascript">
                var fnames = new Array();var ftypes = new Array();fnames[0]='EMAIL';ftypes[0]='email';fnames[1]='FNAME';ftypes[1]='text';fnames[2]='LNAME';ftypes[2]='text';fnames[3]='MMERGE3';ftypes[3]='text';fnames[4]='MMERGE4';ftypes[4]='radio';var err_style = '';
                try{
                    err_style = mc_custom_error_style;
                } catch(e){
                    err_style = 'margin: 1em 0 0 0; padding: 1em 0.5em 0.5em 0.5em; background: ERROR_BGCOLOR none repeat scroll 0% 0%; font-weight: bold; float: left; z-index: 1; width: 80%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial; color: ERROR_COLOR;';
                }
                var mce_jQuery = jQuery.noConflict();
                mce_jQuery(document).ready( function($) {
                  var options = { errorClass: 'mce_inline_error', errorElement: 'div', errorStyle: err_style, onkeyup: function(){}, onfocusout:function(){}, onblur:function(){}  };
                  var mce_validator = mce_jQuery("#mc-embedded-subscribe-form").validate(options);
                  options = { url: 'http://rascalmicro.us1.list-manage.com/subscribe/post-json?u=1b1bbc0cef4aee1d788f8423d&id=f8f38179b4&c=?', type: 'GET', dataType: 'json', contentType: "application/json; charset=utf-8",
                                beforeSubmit: function(){
                                    mce_jQuery('#mce_tmp_error_msg').remove();
                                    mce_jQuery('.datefield','#mc_embed_signup').each(
                                        function(){
                                            var txt = 'filled';
                                            var fields = new Array();
                                            var i = 0;
                                            mce_jQuery(':text', this).each(
                                                function(){
                                                    fields[i] = this;
                                                    i++;
                                                });
                                            mce_jQuery(':hidden', this).each(
                                                function(){
                                                	if ( fields[0].value=='MM' && fields[1].value=='DD' && fields[2].value=='YYYY' ){
                                                		this.value = '';
								                    } else if ( fields[0].value=='' && fields[1].value=='' && fields[2].value=='' ){
                                                		this.value = '';
								                    } else {
                                                        this.value = fields[0].value+'/'+fields[1].value+'/'+fields[2].value;
                                                    }
                                                });
                                        });
                                    return mce_validator.form();
                                }, 
                                success: mce_success_cb
                            };
                  mce_jQuery('#mc-embedded-subscribe-form').ajaxForm(options);

                });
                function mce_success_cb(resp){
                    mce_jQuery('#mce-success-response').hide();
                    mce_jQuery('#mce-error-response').hide();
                    if (resp.result=="success"){
                        mce_jQuery('#mce-'+resp.result+'-response').show();
                        mce_jQuery('#mce-'+resp.result+'-response').html(resp.msg);
                        mce_jQuery('#mc-embedded-subscribe-form').each(function(){
                            this.reset();
                    	});
                    } else {
                        var index = -1;
                        var msg;
                        try {
                            var parts = resp.msg.split(' - ',2);
                            if (parts[1]==undefined){
                                msg = resp.msg;
                            } else {
                                i = parseInt(parts[0]);
                                if (i.toString() == parts[0]){
                                    index = parts[0];
                                    msg = parts[1];
                                } else {
                                    index = -1;
                                    msg = resp.msg;
                                }
                            }
                        } catch(e){
                            index = -1;
                            msg = resp.msg;
                        }
                        try{
                            if (index== -1){
                                mce_jQuery('#mce-'+resp.result+'-response').show();
                                mce_jQuery('#mce-'+resp.result+'-response').html(msg);            
                            } else {
                                err_id = 'mce_tmp_error_msg';
                                html = '<div id="'+err_id+'" style="'+err_style+'"> '+msg+'</div>';
                                
                                var input_id = '#mc_embed_signup';
                                var f = mce_jQuery(input_id);
                                if (ftypes[index]=='address'){
                                    input_id = '#mce-'+fnames[index]+'-addr1';
                                    f = mce_jQuery(input_id).parent().parent().get(0);
                                } else if (ftypes[index]=='date'){
                                    input_id = '#mce-'+fnames[index]+'-month';
                                    f = mce_jQuery(input_id).parent().parent().get(0);
                                } else {
                                    input_id = '#mce-'+fnames[index];
                                    f = mce_jQuery().parent(input_id).get(0);
                                }
                                if (f){
                                    mce_jQuery(f).append(html);
                                    mce_jQuery(input_id).focus();
                                } else {
                                    mce_jQuery('#mce-'+resp.result+'-response').show();
                                    mce_jQuery('#mce-'+resp.result+'-response').html(msg);
                                }
                            }
                        } catch(e){
                            mce_jQuery('#mce-'+resp.result+'-response').show();
                            mce_jQuery('#mce-'+resp.result+'-response').html(msg);
                        }
                    }
                }
                </script>
                <!--End mc_embed_signup-->
                <p>Your email address won't be sold, given, rented, leased, licensed, lent, assigned, repurposed, aliased, commandeered, reverse-borrowed, klaxoned, plaxoed, broadcast via guerrilla radio, read through a megaphone in Davis Square, or otherwise trumpeted skywards.
                </p>
            </div>
            <div id="righttorso">
                <p>In the meantime, you can digest the rest of the website.</p>
                <p>Read the <a href="/docs/">documentation</a>.</p>
                <p>Read our <a href="/blog/">blog</a>.</p>
                <p>Join the mayhem in the <a href="/forum/">forums</a>.</p>
            </div>
        </div>
    </div>
