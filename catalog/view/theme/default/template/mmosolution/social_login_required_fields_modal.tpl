
<div id="social_login_required_fields_modal_wrapper">
    <!-- Large modal -->
    <!--
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#social_login_required_fields_modal">Large modal</button>
    -->

    <div id="social_login_required_fields_modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="social_login_modal_title">Social Login</h4>
                </div>
                <div class="modal-body">
                    <?php echo $mmos_social_login_required_fields_form; ?>
                </div>
            </div>
        </div>
    </div>
    
</div>
