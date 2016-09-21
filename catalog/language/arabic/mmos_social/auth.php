<?php

$_['mmos_heading_title'] = 'إكمال الاشتراك';
// Text
$_['mmos_text_provider_email_already_exists'] = "<span id='mmos_social_warning'>
    البريد الالكتروني المرجع من المزود %s (%s) مشترك فعليا معنا، لذا يمكنك في هذه الحالة تسجيل الدخول مباشرة من خلال بريدك الالكتروني وكلمة المرور الخاصة بك.</span>
    <script type=\"text/javascript\">
    var div=$('#mmos_social_warning').closest('div.alert');
     div.after('<div class=\"alert alert-danger\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button> <i class=\"fa fa-exclamation-triangle\"></i> '+$('#mmos_social_warning').html()+'</div>');
     div.remove();
    </script>";
$_['mmos_text_provider_login_common_error'] = "<span id='mmos_social_warning'>
    نأسف، هذا الطلب مرفوض، أو أن هناك بعض المشاكل عند التسجيل من خلال حسابات التواصل الاجتماعي، نعتذر على الخلل الفني.</span>
    <script type=\"text/javascript\">
    var div=$('#mmos_social_warning').closest('div.alert');
     div.after('<div class=\"alert alert-danger\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button> <i class=\"fa fa-exclamation-triangle\"></i> '+$('#mmos_social_warning').html()+'</div>');
     div.remove();
    </script>";
$_['mmos_text_social_account_created'] = "تم إنشاء حسابك بنجاح.
    افحص بريدك الالكتروني للحصوص على كلمة المرور في حال رغبتك في الدخول لاحقا.";
$_['mmos_text_logined_by_social'] = "قمت بالتسجيل بواسطة <span style=\"text-transform: capitalize;\">%s</span>!";
$_['mmos_text_required_customer_fields'] = "أهلا بك، <strong>%s</strong>.<br>
    <span class=\"text-warning\">من فضلك أدخل الحقول الضرورية لإكمال الاشتراك!</span>";
$_['mmos_button_dismiss_social_login'] = "شكرا، سوف أغادر";
