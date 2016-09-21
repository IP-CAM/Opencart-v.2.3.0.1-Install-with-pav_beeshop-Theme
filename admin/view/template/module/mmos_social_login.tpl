<?php echo $header; ?>

<style>
.fa-yandex {
width: 16px;
height: 16px;
background-size: 16px!important;
background: url('../image/social_login.png');
position: absolute;			
}
.text-Yandex, .text-Mailru, .text-MailChimp, .text-Odnoklassniki, .text-Disqus{
padding-left: 20px;
}
.fa-mailru {
width: 16px;
height: 16px;
background-size: 16px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 64px;
}
.fa-mailchimp {
width: 16px;
height: 16px;
background-size: 16px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 48px;
}
.fa-odnoklassniki {
width: 16px;
height: 16px;
background-size: 16px!important;
background:#1E91CF url('../image/social_login.png');
position: absolute;
background-position: 0px 32px;
}
.fa-disqus {
width: 16px;
height: 16px;
background-size: 16px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 96px;
}
.btn-social .fa-disqus{
width: 32px;
height: 32px;
background-size: 32px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 32px;
}
.btn-social .fa-yandex{
width: 32px;
height: 32px;
background-size: 32px!important;
background: url('../image/social_login.png');
position: absolute;
}
.btn-social .fa-mailru{
width: 32px;
height: 32px;
background-size: 32px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 128px;
}
.btn-social .fa-mailchimp{
width: 32px;
height: 32px;
background-size: 32px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 96px;
}
.btn-social .fa-odnoklassniki{
width: 32px;
height: 32px;
background-size: 32px!important;
background: url('../image/social_login.png');
position: absolute;
background-position: 0px 64px;
}
</style>
</style>
<?php echo $column_left; ?>
<div id="content">
<div class="page-header">
<div class="container-fluid">
<div class="pull-right">
<button type="submit" id="savestay" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success">
<i class="fa fa-save"></i> <?php echo $button_save_stay; ?>
</button>
<button type="submit"  form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary">
<i class="fa fa-save"></i>
</button>
<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
</div>
<h1><img src="//mmosolution.com/image/mmosolution.com_34.png"> <?php echo $heading_title; ?></h1>
<ul class="breadcrumb">
<?php foreach ($breadcrumbs as $breadcrumb) { ?>
<li><a  href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
<?php } ?>
</ul>
</div>
</div>
<div class="container-fluid">
<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
<button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
<button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<div class="panel panel-default">
<div class="panel-heading">
<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_module_edit; ?> </h3>
</div>
<div class="panel-body">
<ul class="nav nav-tabs">
<li class="active"><a href="#tab-setting" data-toggle="tab"><?php echo $tab_setting; ?></a></li>
<li><a href="#tab-social-setting" data-toggle="tab"><?php echo $tab_social_setting; ?></a></li>
<li><a href="#supporttabs" data-toggle="tab"><?php echo $tab_support; ?></a></li>
<li class="pull-right hidden-xs"><a style="  background: url('//mmosolution.com/image/opencart.gif') 0px 10px no-repeat; padding-left: 20px; " title="go to Opencart Market"  href="http://www.opencart.com/index.php?route=extension/extension&filter_username=mmosolution" target="_blank">Get Extensions <span class="badge" style="background: gold;">80++</span></a></li>
<li class="pull-right hidden-xs"><a style="background: url('//mmosolution.com/image/mmosolution_20x20.gif') 0px 8px no-repeat; padding-left: 25px; " title="go to MMOS market"  href="http://mmosolution.com" target="_blank" class="text-success">Get Extensions <span class="badge" style="background: gold;">80++</span></a></li>
</ul>
<?php if (count($stores) > 1) { ?>
<div class="input-group">
<span class="input-group-addon" id="mmos-stores"><i class="fa fa-shopping-cart"></i> <?php echo $entry_store; ?></span>
<select class="form-control col-sm-6"  onchange="window.location = 'index.php?route=module/mmos_requestquote&token=<?php echo $token; ?>&store_id=' + $(this).val();">
<?php foreach ($stores as $store) { ?>
<option value="<?php echo $store['store_id']; ?>" <?php echo ($store_id == $store['store_id']) ? 'selected' : ''; ?>><?php echo $store['name']; ?></option>
<?php } ?>
</select>
</div>
<hr>
<?php } ?>
<form action="<?php echo $action; ?>" method="post"  enctype="multipart/form-data" id="form" class="form-horizontal">
<div class="tab-content">
<div class="tab-pane active in" id="tab-setting">
<div class="panel panel-default">
<div class="panel-heading"><?php echo $tab_setting; ?></div>
<div class="panel-body">
<div class="form-horizontal">
<div class="form-group">
<label for="inputPassword" class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
<div class="col-sm-9">
<input class="mmos-bootstrap-sw" name="social_login_status" value="1" type="checkbox" data-on-text="<?php echo $text_enabled; ?>" data-off-text="<?php echo $text_disabled ; ?>" data-on-color="success" data-off-color="danger" <?php echo (isset($social_login_status) && $social_login_status ==1) ? 'checked' : ''  ?>>         
</div>
</div>
<div class="panel panel-default">
<div class="panel-heading"><?php echo $page_Show; ?></div>
<div class="panel-body">
<div class="form-horizontal">
<div class="col-sm-12">
<div class="checkbox">
<label>
<input type="checkbox" value="1" name="social_login_show[popup]"  <?php echo isset($social_login_show['popup']) ? 'checked' : '' ?>><?php echo $page_popup_login; ?>
</label> <br>
<div class="col-sm-5">
<div class="input-group">
<span class="input-group-btn">
<span class="btn btn-default"><?php echo $page_popup_login_width; ?></span>
</span>
<input style="min-width: 50px;" type="text" name="social_login_popup_width" value="<?php echo isset($social_login_popup_width) ? $social_login_popup_width : '300' ?>" class="form-control" >
<span class="input-group-btn">
<span class="btn btn-default">Px</span>
</span>
</div>
</div>
</div>
</div>

<div  class="panel-body">
<div class="row">
<div class="col-sm-4 col-xs-12">
<div class="checkbox">
<label>
<input type="checkbox" value="1" name="social_login_show[register]" <?php echo isset($social_login_show['register']) ? 'checked' : '' ?>> <?php echo $page_register; ?>
</label>
</div>
</div>
<div class="col-sm-4 col-xs-12">
<div class="checkbox">
<label>
<input type="checkbox" value="1" name="social_login_show[login]" <?php echo isset($social_login_show['login']) ? 'checked' : '' ?>> <?php echo $page_login; ?>
</label>
</div>
</div>
<div class="col-sm-4 col-xs-12">
<div class="checkbox">
<label>
<input type="checkbox" value="1" name="social_login_show[checkout]" <?php echo isset($social_login_show['checkout']) ? 'checked' : '' ?>> <?php echo $page_checkout; ?>
</label>
</div>
</div>
</div>                                   
</div>                                   
</div>
</div>
</div>                           
<div class="panel panel-default">
<div class="panel-heading"><?php echo $entry_required; ?></div>
<div class="panel-body">
<div class="form-horizontal">                                                          
<div class="col-sm-12">                                                                           
<div class="col-md-3 col-sm-4 col-xs-12">
<div class="checkbox disabled">
<label>
<input type="checkbox" checked="checked" disabled="disabled"/>
<strong><?php echo $entry_email; ?></strong>
</label>
</div> 
</div>

<?php foreach ($required_fieldlist as $field): ?>
<?php if ($field == 'country_id') { ?>
<div class="col-md-3 col-sm-4 col-xs-12">
<div class="checkbox">
<label>
<input type="checkbox" name="social_required_fields[]" value="<?php echo $field; ?>" <?php
if (in_array($field, $social_required_fields)) {
echo 'checked="checked"';
}
?>/>
<?php echo ${'entry_country'}; ?>
</label>
</div> 
</div> 

<?php } else if ($field == 'zone_id') { ?>
<div class="col-md-3 col-sm-4 col-xs-12">
<div class="checkbox">
<label>
<input type="checkbox" name="social_required_fields[]" value="<?php echo $field; ?>" <?php
if (in_array($field, $social_required_fields)) {
echo 'checked="checked"';
}
?>/>
<?php echo ${'entry_zone'}; ?>
</label>
</div> 
</div> 
<?php } else { ?>
<div class="col-md-3 col-sm-4 col-xs-12">
<div class="checkbox">
<label>
<input type="checkbox" name="social_required_fields[]" value="<?php echo $field; ?>" <?php
if (in_array($field, $social_required_fields)) {
echo 'checked="checked"';
}
?>/>
<?php echo ${'entry_' . $field}; ?>
</label>
</div> 
</div> 
<?php } ?>
<?php endforeach; ?>
</div> 
</div> 
</div> 
</div>                                                                     
<div class="form-group">
<label style="padding-top: 0px;" for="inputPassword" class="col-sm-2 control-label"><?php echo $text_popup_add_required_fields; ?></label>
<div class="col-sm-9">
<input class="mmos-bootstrap-sw" name="show_popup_required_fields" value="1" type="checkbox" data-size="small" data-on-text="<?php echo 'Yes'; ?>" data-off-text="<?php echo 'No' ; ?>" data-on-color="success" data-off-color="danger" <?php echo (isset($show_popup_required_fields) && $show_popup_required_fields ==1) ? 'checked' : ''  ?>>         
</div>                                           
</div>
<div class="panel panel-default">
<div class="panel-heading"><?php echo $entry_login_success; ?></div>
<div class="panel-body">
<div class="form-horizontal">                                                                                  
<div class="col-sm-12">                                                
<?php if (!empty($success_redirect_page['value']) && $success_redirect_page['value'] == 'page'): ?>
<div class="radio">
<label>
<input type="radio" value="keep" name="success_redirect_page[value]" />   
<?php echo $entry_original; ?>
</label>
</div>
<div class="radio">
<label>
<input type="radio" value="page" name="success_redirect_page[value]" checked/>   
<?php echo $entry_specified_page; ?>
</label>
<div style="margin-left: 20px;">
<input type="text" name="success_redirect_page[url]" value="<?php echo $success_redirect_page['url']; ?>" class="form-control" placeholder="Full URL"/>

</div>
</div>
<?php else: ?>
<div class="radio">
<label>
<input type="radio" value="keep" name="success_redirect_page[value]" checked/>   
<?php echo $entry_original; ?>
</label>
</div>
<div class="radio">
<label>
<input type="radio" value="page" name="success_redirect_page[value]"/>   
<?php echo $entry_specified_page; ?>
</label>
<div style="margin-left: 20px;">
<input type="text" name="success_redirect_page[url]" value="" class="form-control" placeholder="Full URL"/>                                          
</div>
</div>
<?php endif; ?>
</div>
</div>
</div>
</div> 
<div class="panel panel-default">
<div class="panel-heading"><?php echo $entry_login_success_from; ?></div>
<div class="panel-body">
<div class="form-horizontal">                                                                                                                 
<div class="col-sm-12">                                                                                                                                                                                                                     
<?php //var_dump($success_redirect_page_from_logout); ?>
<?php if (!empty($success_redirect_page_from_logout['value']) && $success_redirect_page_from_logout['value'] == 'page'): ?>
<div class="checkbox">
<label>
<input type="checkbox" value="page" name="success_redirect_page_from_logout[value]" checked/>   
<?php echo $entry_specified_page; ?>
</label>
<div style="margin-left: 20px;">
<input type="text" name="success_redirect_page_from_logout[url]" value="<?php echo $success_redirect_page_from_logout['url']; ?>" class="form-control" placeholder="Full URL"/>                                           
</div>
</div>
<?php else: ?>
<div class="checkbox">
<label>
<input type="checkbox" value="page" name="success_redirect_page_from_logout[value]"/>   
<?php echo $entry_specified_page; ?>
</label>
<div style="margin-left: 20px;">
<input type="text" name="success_redirect_page_from_logout[url]" class="form-control" placeholder="Full URL"/>                                        
</div>
</div>
<?php endif; ?>
</div>
</div>
</div>
</div>                                                                    
<div class="form-group">
<label for="link" class="col-sm-2 control-label"><?php echo $text_put_code; ?></label>
<div style="padding-top: 10px;" class="col-sm-10">
<pre>&lt;div class=&quot;mmosolution_show_social&quot;&gt;&lt;/div&gt;</pre>
</div>
</div>	
<div class="form-group">
<label for="inputPassword" class="col-sm-2 control-label"><?php echo $entry_debug; ?></label>
<div class="col-sm-9">
<input class="mmos-bootstrap-sw" name="social_login_debug" value="1" type="checkbox" data-size="small" data-on-text="<?php echo $text_enabled; ?>" data-off-text="<?php echo $text_disabled ; ?>" data-on-color="success" data-off-color="danger" <?php echo (isset($social_login_debug) && $social_login_debug ==1) ? 'checked' : ''  ?>>         
</div>
</div>                                                  
<div class="form-group">
<label for="key" class="col-sm-2 control-label"><?php echo $text_advanced_css; ?></label>
<div class="col-sm-10">
<textarea class="form-control" rows="6" name="social_login_Advanced_css"><?php echo $social_login_Advanced_css; ?></textarea>
</div>
</div>
</div> 
</div> 
</div> 
</div> 

<div class="tab-pane" id="tab-social-setting">
<div class="panel panel-default">
<div class="panel-heading"><?php echo $tab_social_setting; ?></div>
<div class="panel-body">
<div class="form-horizontal">
<div class="row">
<div class="col-md-6 col-md-offset-3">
<h4><?php echo $how_to_set_up; ?></h4>
</div>
</div>									
<div class="row">
<div class="col-sm-3">
<ul style="  padding-top: 10px; padding-bottom: 10px;" class="nav nav-pills nav-stacked" id="mmosolution">
<?php foreach ($providers as $provider => $value) { ?>
<li><a  href="#tab-<?php echo $provider; ?>" data-toggle="tab"><i class="text-primary fa fa-<?php echo $provider == 'Live' ? 'windows' : ($provider =='Vkontakte' ? 'vk' : strtolower($provider)); ?>"></i> <span class="text-<?php echo $provider; ?>"><?php echo $provider == 'Live' ? $provider . ' (Microsoft)' : $provider; ?> </span></a></li>
<?php } ?>
</ul>
</div>
<div class="col-sm-9">
<div class="tab-content">
<?php foreach ($providers as $provider => $value) { ?>
<div class="tab-pane" id="tab-<?php echo $provider; ?>">
<div  id="provider_<?php echo $provider; ?>">												
<h2><div class="page-header" style="color: #125acd;"><?php echo $provider; ?></div></h2>
<div class="form-group">
<label for="inputPassword" class="col-sm-3 control-label"><?php echo $entry_status; ?></label>
<div class="col-sm-9">
<input class="mmos-bootstrap-sw" name="social_login[<?php echo $provider; ?>][enabled]" value="1" type="checkbox" data-on-text="<?php echo $text_enabled; ?>" data-off-text="<?php echo $text_disabled ; ?>" data-on-color="success" data-off-color="danger" <?php echo (isset($value['settings']['enabled']) && $value['settings']['enabled'] ==1) ? 'checked' : ''  ?>>         
</div>
</div>                   
<div class="form-group">
<label for="" class="col-sm-3 control-label"><i class="fa fa-group"></i> <?php echo $entry_group; ?></label>
<div class="col-sm-6">
<select name="social_login[<?php echo $provider; ?>][group]" class="form-control"> 
<?php foreach ($customer_groups as $group) { ?>
<option value="<?php echo $group['customer_group_id']; ?>" <?php echo (isset($value['settings']['group']) && $value['settings']['group'] == $group['customer_group_id']) ? 'selected="selected"' : '' ?>><?php echo $group['name']; ?></option>
<?php } ?>
</select>
</div>
</div>
<div class="form-group">
<label for="sort" class="col-sm-3 control-label"><?php echo $entry_sort_order; ?></label>
<div class="col-sm-3">
<input type="text" class="form-control" name="social_login[<?php echo $provider; ?>][sort_order]" value="<?php echo isset($value['settings']['sort_order']) ? $value['settings']['sort_order'] : 0; ?>" >
</div>
</div>
<div class="panel panel-default">
<div class="panel-body">                                                                                                                  
<div class="row">
<?php foreach ($languages as $language): ?>
<div class="col-sm-12">
<div class="form-group"> 
<label class="col-sm-12"><?php echo $custom_text; ?></label>
<div class="col-sm-12">																			
<div class="input-group input-group">
<span class="input-group-addon" id="sizing-addon3"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
<input type="text" id="<?php echo $provider; ?>_custom_text_<?php echo $language['language_id']; ?>" class="form-control custom-text" value="<?php echo isset($value['settings']['text'][$language['language_id']]) ? $value['settings']['text'][$language['language_id']] : $text_login_with . $provider; ?>" name="social_login[<?php echo $provider; ?>][text][<?php echo $language['language_id']; ?>]" >
</div>    
</div> 
</div> 
<div class="form-group">
<label class="col-sm-12"><?php echo $text_preview; ?></label>
<div class="col-sm-12">																
<a  class="btn  btn-social btn-<?php echo $provider == 'Live' ? 'microsoft' : strtolower($provider); ?>"><i class="fa fa-<?php echo $provider == 'Live' ? 'windows' : ($provider =='Vkontakte' ? 'vk' : strtolower($provider)); ?>"></i> <span id="<?php echo $provider; ?>_custom_text_<?php echo $language['language_id']; ?>_preview" ><?php echo isset($value['settings']['text'][$language['language_id']]) ? $value['settings']['text'][$language['language_id']] : $text_login_with . $provider; ?></span></a>
</div>
</div> 
</div> 
<?php endforeach; ?>
</div> 
</div>
</div>
<div class="form-group">
<label for="key" class="col-sm-12"><?php echo $provider . ' ' . $value['languages']['text_key']; ?></label>
<div class="col-sm-12">
<input type="text" value="<?php echo isset($value['settings']['key']) ? $value['settings']['key'] : ''; ?>" class="form-control" name="social_login[<?php echo $provider; ?>][key]"   placeholder="<?php echo $provider . ' ' . $value['languages']['text_key']; ?>">
</div>
</div>
<div class="form-group">
<label for="secret" class="col-sm-12"><?php echo $provider . ' ' . $value['languages']['text_secret']; ?></label>
<div class="col-sm-12">
<input type="text" class="form-control" value="<?php echo isset($value['settings']['secret']) ? $value['settings']['secret'] : ''; ?>" name="social_login[<?php echo $provider; ?>][secret]"   placeholder="<?php echo $provider . ' ' . $value['languages']['text_secret']; ?>">
</div> 
</div>
<div class="form-group">
<label for="flag" class="col-sm-2 control-label"><?php echo $entry_scope ?></label>
<div class="col-sm-10">
<input type="text" class="form-control" value="<?php echo isset($value['settings']['scope']) ? $value['settings']['scope'] : ''; ?>" name="social_login[<?php echo $provider; ?>][scope]"  placeholder="Enter Flags (optional)">
</div>  
</div>
<div class="form-group">
<label for="link" class="col-sm-12"><?php echo $provider . ' ' . $value['languages']['text_redirect']; ?></label>
<div class="col-sm-12">
<?php
$redirect = in_array($provider, $redirect_short_link) ? $shop_link_social : $shop_link_social . 'index.php?route=mmos_social/mmos_social&hauth.done=' . $provider;
;
?>
<input type="text" class="form-control"  value="<?php echo $redirect; ?>" readonly />
</div>
</div>
</div>
</div>                                        
<?php } ?>
</div>

</div>
</div>                                        
</div>                   
</div>                   
</div>                   
</div>                   

<div class="tab-pane" id="supporttabs"">
<div class="panel ">
<div class="panel-body ">
<!-- begin MMOSolution.com -->
<div class="row">
<div class="col-md-6 col-xs-12">

<h2 class="text-success text-center">Thank You For Choosing MMO Solution  <i class="fa fa-trophy"></i></h2>
<div class="panel-body text-center">
<h4><i class="fa fa-tags"></i> About <?php echo $heading_title; ?></h4>
<h5><i class="fa fa-lock"></i> Installed Version: V.<?php echo $MMOS_version; ?> </h5>
<h5><i class="fa fa-tree"></i> Latest version: <span id="mmos_latest_version"><a href="http://mmosolution.com/index.php?route=product/search&search=<?php echo trim(strip_tags($heading_title)); ?>" target="_blank">Unknown -- Check</a></span></h5>
<br>

<h5 class="hidden-sm"><a style="background: url('//mmosolution.com/image/mmosolution_20x20.gif') 0px 0px no-repeat; padding-left: 25px; " title="go to MMOS market"  href="http://mmosolution.com" target="_blank" class="text-success">Get More Extensions on our site <span id="ontabspromotion"></span></a></h5>
<h5 class="hidden-sm"><a style="  background: url('//mmosolution.com/image/opencart.gif') 0px 0px no-repeat; padding-left: 20px; " title="go to Opencart Market"  href="http://www.opencart.com/index.php?route=extension/extension&filter_username=mmosolution" target="_blank"> Get More Our Extensions on Opencart Market</a></h5><br>
</div>
</div>
<div class="col-md-6 col-xs-12">
<h3><i class="fa fa-info-circle"></i> Please inform us if you get any troubles & give feedback!</h3>

<div id="contact-infor" class="text-center">
<h4> <i class="fa fa-envelope-o text-primary"></i> <a href="mailto:support@mmosolution.com?Subject=<?php echo trim(strip_tags($heading_title)) . ' OC ' . VERSION; ?>" target="_top">support@mmosolution.com</a></h4>
<h4><i class="fa fa-globe text-success"></i> <a href="http://MMOSolution.com" target="_blank">Www.MMOSolution.com</a></h4>
<h4><i class="fa fa-ticket text-warning"></i> <a href="http://MMOSolution.com/support/" target="_blank">Submit a support Ticket</a></h4>
<h4><i class="fa fa-hand-o-right"></i> <a href="http://MMOSolution.com/support/" target="_blank">Do you need custom-work, custom extensions, fix extensions of another developer? Resolve your site troubles.. ?</a></h4>
<br>

<h3><i class="fa fa-heart-o text-danger"></i> Follow us on the social media web sites.</h3>
<a href="http://www.facebook.com/MMOSolution" target="_blank" title=" Facecook.com"><i class="fa fa-2x fa-facebook-square"></i></a>
<a class="text-danger" href="http://plus.google.com/+Mmosolution" target="_blank" title="Google Plus"><i class="fa  fa-2x fa-google-plus-square"></i></a>
<a class="text-warning" href="http://MMOSolution.com/mmosolution_rss.rss" target="_blank" title="RSS"><i class="fa fa-2x fa-rss-square"></i></a>
<a href="http://twitter.com/MMOSolution" target="_blank" title="Twitter"><i class="fa fa-2x fa-twitter-square"></i></a>
<a class="text-danger" href="http://www.youtube.com/MMOSolution" target="_blank" title="Youtube.com"><i class="fa fa-2x fa-youtube-square"></i></a>
</div>
</div>
<div id="relate-products"></div> 
<script type="text/javascript"><!--

var productcode = '<?php echo $MMOS_code_id; ?>';
$('a[href="#supporttabs"]').bind('click', function () {
$('#ontabspromotion').html('(' + $('#mmos-offer').html() + ')');
});

//--></script>
<!-- DO NOT REMOVE -->
<script type="text/javascript" src="//mmosolution.com/support.js"></script>

</div>
<!-- end MMOSolution.com -->
</div>
</div>
</div>
</div>                                        
</form>
</div>
</div>
</div>
</div>

<script type="text/javascript"><!--
$('#mmosolution a:first').tab('show');
$(document).on('change', 'input.custom-text', function () {
var change_id = $(this).attr('id');
$('#' + change_id + '_preview').html($('#' + change_id).val());
});
$('#savestay').click(function () {

$('#form').attr('action', $('#form').attr('action') + '&stay=1');
});
//--></script>

<script type="text/javascript" src="//mmosolution.com/support.js"></script>
<script type="text/javascript"><!--
var productcode = '<?php echo $MMOS_code_id; ?>';
//--></script>

<script type="text/javascript"><!--
$("input.mmos-bootstrap-sw").bootstrapSwitch();
$('#savestay').click(function () {
$('#mmosolution-form').attr('action', $('#mmosolution-form').attr('action') + '&stay=1');
});
//--></script>
<?php echo $footer; ?>


