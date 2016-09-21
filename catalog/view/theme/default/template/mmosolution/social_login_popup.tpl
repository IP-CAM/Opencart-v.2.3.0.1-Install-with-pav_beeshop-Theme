
<?php  echo $social_login_custom_css ? '<style>'.$social_login_custom_css .'</style>' : ''; ?>

<?php if(isset($social_login_popup)):  ?>  
<style>
    .mmosolution_social_login {margin-top: 5px;}	
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


<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" id="dialog-loginbox" aria-labelledby="SmallModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width:<?php echo $social_login_popup_width;?>px; max-width: 95%; orverflow: auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><i class="fa fa-user"></i> <?php echo $heading_title; ?></h4>
            </div>
            <div class="modal-body" id="l2p_form">
			 <div class="form-group-sm">
				 <div class="text-danger" id="error-e-p"></div>
				 <label for="user-email"> <?php echo $entry_email; ?></label>
				 <input id="user-email" type="text" name="email" value placeholder="<?php echo $entry_email; ?>" class="form-control">
			  </div>
             
			 <div class="form-group-sm">
				 <div class="text-danger" id="error-e-p"></div>
				<label for="user-password"><?php echo $entry_password; ?></label>
				<input id="user-password" type="password" name="password" value placeholder="<?php echo $entry_password; ?>" class="form-control">
			  </div>
                <button type="button" class="btn btn-primary btn-lg btn-block" id="mmosolution-button-login"><i class="fa fa-sign-in"></i> <?php echo $text_login; ?></button>

                <hr style="margin-top: 10px;">

                <div class="clearfix">

                    <?php if (isset($social_login_items)) { ?>
                    <div id="mmos-social-login" class="row" style="margin-top: 15px;margin-bottom: 15px;">
                        <div class="col-sm-12">
                            <?php foreach ($social_login_items as $provider => $value) { ?>
                            <a href="<?php echo $value['link']; ?>"  class="mmosolution_social_login btn  btn-social btn-<?php echo $provider =='Live' ? 'microsoft' : strtolower($provider); ?>"><i class="fa fa-<?php echo $provider =='Live' ? 'windows' : ($provider =='Vkontakte' ? 'vk' : strtolower($provider)); ?>"></i> <?php echo $value['text']; ?></a>
                            <?php } ?>

                        </div>
                    </div>
                    <?php } ?>

                </div>
            </div>
            <div class="modal-footer">
                <a href="<?php echo $forgotten ;?>" class="pull-left" title=""><i class="fa fa-question"></i> <?php echo $text_forgotten ;?></a>
                <a href="<?php echo $register ;?>" class="pull-right"><i class="fa fa-user-plus"></i> <?php echo $text_register; ?></a>
            </div>
        </div>
    </div>
</div> 



        
<script type="text/javascript"><!--
    $(document).on('click', '#mmosolution-button-login', function () {
        $('#mmosolution-button-login').attr('disabled', false);
        $('#user-email').attr('disabled', false);
        $('#user-password').attr('disabled', false);
        if (($("#user-email").val() !== undefined && $("#user-email").val() != "") || ($("#user-password").val() !== undefined && $("#user-password").val() != "")) {
            var datapost = {email: $("#user-email").val(), password: $("#user-password").val() };
            $.ajax({
                url: 'index.php?route=module/mmos_login_oc2',
                type: 'post',
                data: datapost,
                dataType: 'json',
                beforeSend: function () {
                    $('#mmosolution-button-login').attr('disabled', true);
                    $('#user-email').attr('disabled', true);
                    $('#user-password').attr('disabled', true);
                },
                complete: function () {
                    $('#mmosolution-button-login').attr('disabled', false);
                },
                success: function (res) {
					
				
                    if (res['login2price_statuslogin'] == 1) {
                       
					<?php if(isset($_GET['route']) && ($_GET['route'] == 'account/logout'  || $_GET['route'] == 'account/register')) { ?>	
								window.location.href =  '<?php echo $base; ?>';								
																
								<?php } else { ?>
                                     location.reload();                								
							 <?php } ?>
                    } else {
                        $('#mmosolution-button-login').attr('disabled', false);
                        $('#user-email').attr('disabled', false);
                        $('#user-password').attr('disabled', false);
                        $("#error-e-p").empty();
                        $("#error-e-p").append(res["error"]);
                    }
                }
            });
        } else {
            alert('<?php echo $error_login; ?>!');
        }
    });
    $(document).on("keyup", "#l2p_form input, #l2p_form button", function (e) {
        if (e.keyCode === 13) {
            $('#mmosolution-button-login').trigger('click');
        }
    });
	 $(document).on("click", 'a[href="<?php echo $login_link; ?>"]', function (e) {
			$('#dialog-loginbox').modal('show');    
				return false;
        });  
//--></script>         
<?php endif; ?>   
