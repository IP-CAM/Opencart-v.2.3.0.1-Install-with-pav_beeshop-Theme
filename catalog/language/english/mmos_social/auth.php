<?php

$_['mmos_heading_title']    = 'Complete Social Login';
// Text
$_['mmos_text_provider_email_already_exists'] = "<span id='mmos_social_warning'>The email returned by the provider %s (%s) already exist in our database, so in this case you might use the Sign-in to login using your email and password.</span>  
    <script type=\"text/javascript\">
    var div=$('#mmos_social_warning').closest('div.alert');
     div.after('<div class=\"alert alert-danger\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button> <i class=\"fa fa-exclamation-triangle\"></i> '+$('#mmos_social_warning').html()+'</div>');   
     div.remove();
    </script>";
$_['mmos_text_provider_login_common_error'] = "<span id='mmos_social_warning'>Sorry, The request denied or errors occured when try to login via social. Please try again!</span>  
    <script type=\"text/javascript\">
    var div=$('#mmos_social_warning').closest('div.alert');
     div.after('<div class=\"alert alert-danger\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button> <i class=\"fa fa-exclamation-triangle\"></i> '+$('#mmos_social_warning').html()+'</div>');   
     div.remove();
    </script>";
$_['mmos_text_social_account_created'] = "Your account created! Check your mail to get password for login later!";
$_['mmos_text_logined_by_social'] = "You have logined by <span style=\"text-transform: capitalize;\">%s</span>!";
$_['mmos_text_required_customer_fields'] = "Hi <strong>%s</strong>, you almost complete login,<br> 
    <span class=\"text-warning\">please enter additional required fields to finish login!</span>";
$_['mmos_button_dismiss_social_login']="No, I will try social login later!";

