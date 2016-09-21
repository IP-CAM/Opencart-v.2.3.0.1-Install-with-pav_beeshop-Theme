
<?php if ($is_error) { ?>
    <?php if ($redirect) { ?>
        <script type="text/javascript">
            //location.href = '<?php echo $redirect; ?>';//disabled because of loading popup  in every page
        </script>
    <?php } ?>
<?php } else { ?>
    <div>
        <h3 class="text-center text-info"><?php echo $text_required_customer_fields; ?></h3>
        <hr>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal" id="social_login_required_fields_form" onsubmit="return false;">
            <?php foreach ($fields as $field): ?>
                <div class="form-group-sm required">
                    <?php if ($field == 'customer_group_id') { ?>
                    
                        <label class="control-label" for="input-customer_group"><?php echo $entry_customer_group; ?></label>
                        
                            <select name="customer_group_id" id="input-customer_group" class="form-control">
                                <option value=""><?php echo $text_select; ?></option>
                                <?php foreach ($coustomer_groups as $coustomer_group) { ?>
                                    <?php if ($coustomer_group['customer_group_id'] == $customer_group_id) { ?>
                                        <option value="<?php echo $coustomer_group['customer_group_id']; ?>" selected="selected"><?php echo $coustomer_group['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $coustomer_group['customer_group_id']; ?>"><?php echo $coustomer_group['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>

                            <?php if ($error_customer_group) { ?>
                                <div class="text-danger"><?php echo $error_customer_group; ?></div>
                            <?php } ?>
                       
                    <?php } elseif ($field == 'country_id') { ?>
					
                        <label class="control-label" for="input-country"><?php echo $entry_country; ?></label>
                        
                            <select name="country_id" id="input-country" class="form-control">
                                <option value=""><?php echo $text_select; ?></option>
                                <?php foreach ($countries as $country) { ?>
                                    <?php if ($country['country_id'] == $country_id) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>

                            <?php if ($error_country) { ?>
                                <div class="text-danger"><?php echo $error_country; ?></div>
                            <?php } ?>
                       
                    <?php } elseif ($field == 'zone_id') { ?>
                        <label class="control-label" for="input-zone"><?php echo $entry_zone; ?></label>
                        
                            <select name="zone_id" id="input-zone" class="form-control">
                            </select>
                            <?php if ($error_zone) { ?>
                                <div class="text-danger"><?php echo $error_zone; ?></div>
                            <?php } ?>
                       
                    <?php } else { ?>
                        <label class="control-label" for="input-<?php echo $field; ?>"><?php echo ${'entry_' . $field}; ?></label>
                        
                            <input type="text" name="<?php echo $field; ?>" value="<?php echo ${$field}; ?>" placeholder="<?php echo ${'entry_' . $field}; ?>" id="input-<?php echo $field; ?>" class="form-control">
                            <?php if (${'error_' . $field}) { ?>
                                <div class="text-danger"><?php echo ${'error_' . $field}; ?></div>
                            <?php } ?>
                       

                    <?php } ?>
                </div>   
            <?php endforeach; ?>
            <div class="text-right">
                <input type="button" name="dismiss_complete_social_login" value="<?php echo $button_dismiss_social_login; ?>" class="btn btn-default btn-sm"/>
                <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" />
            </div>
        </form>
    </div>
    <script type="text/javascript"><!--
    $('#social_login_required_fields_form select[name=\'country_id\']').on('change', function() {
            $.ajax({
                url: 'index.php?route=account/account/country&country_id=' + this.value,
                dataType: 'json',
                beforeSend: function() {
                    $('#social_login_required_fields_form select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
                },
                complete: function() {
                    $('.fa-spin').remove();
                },
                success: function(json) {
                    if (json['postcode_required'] == '1') {
                        $('#social_login_required_fields_form  input[name=\'postcode\']').parent().parent().addClass('required');
                    } else {
                        $('#social_login_required_fields_form input[name=\'postcode\']').parent().parent().removeClass('required');
                    }

                    html = '<option value=""><?php echo $text_select; ?></option>';

                    if (json['zone'] && json['zone'] != '') {
                        for (i = 0; i < json['zone'].length; i++) {
                            html += '<option value="' + json['zone'][i]['zone_id'] + '"';

                            if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                                html += ' selected="selected"';
                            }

                            html += '>' + json['zone'][i]['name'] + '</option>';
                        }
                    } else {
                        html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                    }

                    $('#social_login_required_fields_form select[name=\'zone_id\']').html(html);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });

        $('#social_login_required_fields_form select[name=\'country_id\']').trigger('change');
        //--></script>

    <script type="text/javascript">
        $('#social_login_required_fields_form').on('click', 'input[type=submit], input[name="dismiss_complete_social_login"]', function() {
            //alert('click');

            var formData = $('#social_login_required_fields_form').serializeArray();
            var dismiss = this.name == 'dismiss_complete_social_login';
            if (dismiss) {
                formData.push({name: this.name, value: this.value});

                //close modal
                $('#social_login_required_fields_form').closest('div.modal').modal('hide');

            }
            $.ajax({
                url: 'index.php?route=mmos_social/mmos_social/save',
                type: 'post',
                dataType: 'json',
                data: formData,
                beforeSend: function() {
                    $('#social_login_required_fields_form input[type=submit]').button('loading');
                },
                success: function(json) {
                    console.log(json);
                    if (!dismiss) {
                        if (json['redirect']) {
                            location.href = json['redirect'];
                        } else if (json['error']) {
                            $('#social_login_required_fields_form .alert, #social_login_required_fields_form .text-danger').remove();
                            if (json['error']['warning']) {
                                $('#social_login_required_fields_form').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                            }
                            for (i in json['error']) {
                                
                                /*  var element = $('#input-' + i.replace('_', '-')); */
								var element = $('#input-' + i);
                                if ($(element).parent().hasClass('input-group')) {
                                    $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                                } else {
                                    $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                                }
                            }

                            // Highlight any found errors
                            $('.text-danger').parent().parent().addClass('has-error');
                        }
                    }

                },
                error: function() {
                    alert('something error!');
                },
                complete: function() {
                    $('#social_login_required_fields_form input[type=submit]').button('reset');
                }
            });
            return false;
        });
    </script>
    <script type="text/javascript">
        $(function() {
            $('#social_login_modal_title').html('<?php echo addslashes($heading_title); ?>');
            $('#social_login_required_fields_form').closest('div.modal').modal('show');
        });

    </script>
<?php } ?>