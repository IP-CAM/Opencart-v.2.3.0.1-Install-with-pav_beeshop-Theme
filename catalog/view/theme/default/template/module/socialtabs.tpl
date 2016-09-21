<?php $i = 1;?>
<?php if ($tab_facebook) { ?>
<div id="tab-facebook" class="socialtabs-container <?php echo $position; ?>">
  <div id="facebook-icon" class="socialtab-icon facebook_icon_<?php echo $position . ' ' . $position.$i; ?>"><i class="fa fa-facebook fa-2x"></i></div>
  <div class="facebook-body">
    <div id="fb-root"></div>
    <script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/<?php echo $locale; ?>/sdk.js#xfbml=1&version=v2.3";
      fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
    <div class="fb-page" data-href="https://www.facebook.com/<?php echo $page_url; ?>" data-width="280" data-height="<?php echo $facebook_height; ?>" data-hide-cover="<?php echo $show_cover; ?>" data-show-facepile="<?php echo $show_faces; ?>" data-show-posts="<?php echo $show_posts; ?>"></div>
  </div>
</div>
<?php $i++; } ?>
<?php if ($tab_twitter) { ?>
<div id="tab-twitter" class="socialtabs-container <?php echo $position; ?>">
  <div id="twitter-icon" class="socialtab-icon twitter_icon_<?php echo $position . ' ' . $position.$i; ?>"><i class="fa fa-twitter fa-2x"></i></div>
  <div class="twitter-body">
    <a class="twitter-timeline" href="https://twitter.com" data-widget-id="<?php echo $widget_id; ?>"
      width="280"
      height="<?php echo $twitter_height; ?>"
      data-theme="<?php echo $theme; ?>"
      data-show-replies="<?php echo $show_replies; ?>"
      <?php if ($limit) { ?>data-tweet-limit="<?php echo $limit; ?>"<?php } ?>
      <?php if ($related_users) { ?>data-related="<?php echo $related_users; ?>"<?php } ?>
    >Tweets</a>
    <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
  </div>
</div>
<?php } ?>
<script>
$(document).ready(function(){
  <?php if ($tab_facebook) { ?>
	$("#tab-facebook").hover( 
    function() {
      $(this).addClass('open');
      if (typeof $("#tab-twitter").offset() != 'undefined') { 
        $("#tab-twitter").hide();
      }
    },
    function() {
      $(this).removeClass('open');
      if(typeof $("#tab-twitter").offset() != 'undefined') { 
        $("#tab-twitter").delay(500).show(0);
      }
    }
	);
  <?php } ?>
  <?php if ($tab_twitter) { ?>
	$("#tab-twitter").hover(
    function() {
      $(this).addClass('open');
      if(typeof $("#tab-facebook").offset() != 'undefined') { 
        $("#tab-facebook").hide();
      }
    },
    function() {
      $(this).removeClass('open');
      if(typeof $("#tab-facebook").offset() != 'undefined') { 
        $("#tab-facebook").delay(500).show(0);
      }
    }
	);
  <?php } ?>
});
</script>