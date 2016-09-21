<?php  echo $social_login_custom_css ? '<style>'.$social_login_custom_css .'</style>' : ''; ?>
<style>
    .mmos-social-login_content {margin-top: 5px;}
		.btn-social .fa-disqus{
     width: 32px;
		  height: 30px;
		  background-size: 30px!important;
		  background: url('../image/social_login.png');
		  position: absolute;
  background-position: 0px 30px;
}
.btn-social .fa-yandex{
           width: 32px;
		  height: 30px;
		  background-size: 30px!important;
		  background: url('../image/social_login.png');
		  position: absolute;
}
.btn-social .fa-mailru{
           width: 32px;
		  height: 30px;
		  background-size: 30px!important;
		  background: url('../image/social_login.png');
		  position: absolute;
background-position: 0px 120px;
}
.btn-social .fa-mailchimp{
 width: 32px;
		  height: 30px;
		  background-size: 30px!important;
		  background: url('../image/social_login.png');
		  position: absolute;
background-position: 0px 90px;
}
.btn-social .fa-odnoklassniki{
width: 32px;
		  height: 30px;
		  background-size: 30px!important;
		  background: url('../image/social_login.png');
		  position: absolute;
background-position: 0px 60px;
}
</style>

<div id="mmos-social-login_show" class="row" style="display: none;">
    <div class="clearfix">
        <?php foreach ($social_login_items as $provider => $value) { ?>
        <a  data-social-provider="<?php echo strtolower($provider); ?>" href="<?php echo $value['link']; ?>"  class="mmosolution_social_login btn  btn-social btn-<?php echo $provider =='Live' ? 'microsoft' : ($provider =='Vkontakte' ? 'vk' : strtolower($provider)); ?>"><i class="fa fa-<?php echo $provider =='Live' ? 'windows' : strtolower($provider); ?>"></i> <?php echo $value['text']; ?></a>
        
            
        <?php } ?>
        <script type="text/javascript"><!--
            $(function(){
                $('#mmos-social-login_show a[data-social-provider]').click(function(e, custom_data){
                    if(custom_data && custom_data.msd_share=='1'&custom_data.msd_share_product_id!=undefined){
                        //do post e.data.msd_share_product_id to server then pass into social login redirect url
                        alert('product_id: '+custom_data.msd_share_product_id);
                        location.href= $(this).prop('href') +"&msd_share_product_id="+custom_data.msd_share_product_id;
                    }
                    return false;
                });
            });
       //--> </script>

    </div>
</div>

<script type="text/javascript">
    
    var show_social_custom_page = '<?php echo $show_social_custom_page; ?>';
    
    $(document).ready(function () {
        $('.mmosolution_show_social').html($('#mmos-social-login_show').html()).show();
        
        <?php if($show_social_custom_page != ''){ ?>
        
         $('#mmosolution_show_social-<?php echo $show_social_custom_page; ?>').html($('#mmos-social-login_show').html()).show();
                
       <?php } ?>
    });
    
</script>   

