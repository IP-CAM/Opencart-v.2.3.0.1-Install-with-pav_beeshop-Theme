
<?php if (!$islogged) { ?>
<style>
<?php foreach($providers as $provider){ ?>
#dsl_<?php echo $provider['id']; ?>_button{
  background:  <?php echo $provider['background_color']; ?>
}
#dsl_google_button:active{
  background: <?php echo $provider['background_color_active']; ?>;
}
<?php } ?>

 .dsl-button {

  text-decoration: none;
  color: #fff;
  display: inline-block;
  box-sizing: border-box;
  -webkit-border-radius: 3px;
  -moz-border-radius: 3px;
  border-radius: 3px;
  box-shadow: 0 1px 0 rgba(0,0,0,0.10);
  margin: 2px;
  margin-bottom: 10px;
  font-size: 12px;
  padding: 8px;
}
#social_login_free  .dsl-button:hover {
  text-decoration: none;
  box-shadow: inset 0 -2px 0 rgba(0,0,0,0.20);
}
#social_login_free .dsl-button:active{
  box-shadow: inset 0 2px 0 rgba(0,0,0,0.20);
}
#social_login_free .dsl-button.dsl-button-medium .l-side,
#social_login_free .dsl-button .l-side {
  padding: 5px 5px 0px 5px;
  border-right: 1px solid rgba(255,255,255,0.3);
  color: #fff;
  display: inline-block;
  font-size: 17px;
  vertical-align: middle;
  box-sizing: border-box;
  text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.3);
  position: relative;
}
#social_login_free .dsl-button.dsl-button-medium .r-side,
#social_login_free .dsl-button .r-side{
  padding: 6px 10px 6px 10px;
  color: #fff;
  display: inline-block;
  font-size: 12px;
  vertical-align: middle;
  box-sizing: border-box;
  text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.3);
}
#social_login_free .dsl-button.dsl-button-huge .l-side {
  font-size: 26px;
  padding: 8px 10px 0px 8px;
}
#social_login_free .dsl-button.dsl-button-huge .r-side {
  font-size: 15px;
  padding: 12px 20px 11px 20px;
}
#social_login_free .dsl-button.dsl-button-large .l-side {
  font-size: 20px;
  padding: 6px 6px 0px 6px;
}
#social_login_free .dsl-button.dsl-button-large .r-side {
  font-size: 13px;
  padding: 8px 16px 7px 16px;
}
#social_login_free .dsl-button.dsl-button-small .l-side {
  font-size: 14px;
  padding: 4px 4px 0px 4px;
}
#social_login_free .dsl-button.dsl-button-small .r-side {
  font-size: 10px;
  padding: 4px 5px 3px 5px;
}

#social_login_free .dsl-button.dsl-button-icons .l-side {
  font-size: 17px;
  padding: 5px 5px 0px 5px;
  border: none;
}
#social_login_free .dsl-button.dsl-button-icons .r-side {
  display: none;
}
a [class*="dsl-icon-"],
[class*="dsl-icon-"],
[class*="dsl-icon-"]:before{
  margin:0px !important;
  background-image:none !important;
}
.dsl-label {
  display: none;
  vertical-align: middle;
}
.dsl-label-icons{
  display: inline-block;
}
.dsl-hide-icon{
  opacity: 0
}
</style>
<div id="social_login_free">
  <?php foreach($providers as $key => $provider){ ?><?php if ($provider['enabled']) { ?>
  <a class="btn btn-<?php echo $provider['id']; ?> dsl-button"  href="index.php?route=module/social_login_free/provider_login&provider=<?php echo $key; ?>">
    <i class="icon-<?php echo $provider['id']; ?>"></i> <?php echo $provider['heading']; ?>
  </a>
<?php }  ?><?php } ?>
</div>
<script>
$( document ).ready(function() {
  $('.dsl-button').on('click', function(){
    $('.dsl-button').find('.l-side').spin(false);
    $(this).find('.l-side').spin('<?php echo $size; ?>', '#fff');
    
    $('.dsl-button').find('.dsl-icon').removeClass('dsl-hide-icon');
    $(this).find('.dsl-icon').addClass('dsl-hide-icon');
  })
})
</script>
<?php } ?>