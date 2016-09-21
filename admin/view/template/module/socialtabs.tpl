<?php 
/*
* Socialtabs Module
* Developed for OpenCart 2.x
* Author Gedielson Peixoto - http://www.gepeixoto.com.br
* @03/2015
* Under GPL license.
*/
echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-socialtabs" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-socialtabs" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_position; ?></label>
            <div class="col-sm-10">
              <select name="socialtabs_position" class="form-control">
                <?php foreach ($positions as $position => $position_text) { ?>
                <?php if ($socialtabs_position == $position) { ?>
                <option value="<?php echo $position; ?>" selected="selected"><?php echo $position_text; ?></option>
                <?php } else { ?>
                <option value="<?php echo $position; ?>"><?php echo $position_text; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="socialtabs_status" class="form-control">
                <?php if ($socialtabs_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-facebook" data-toggle="tab"><?php echo $tab_facebook; ?></a></li>
            <li><a href="#tab-twitter" data-toggle="tab"><?php echo $tab_twitter; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active in" id="tab-facebook">
              <div class="form-group">
                <label for="input-page-url" class="col-sm-2 control-label"><?php echo $entry_page_url; ?></label>
                <div class="col-sm-10">
                  <div class="input-group">
                    <span class="input-group-addon">https://www.facebook.com/</span>
                    <input type="text" id="input-page-url" name="socialtabs_page_url" value="<?php echo $socialtabs_page_url; ?>" placeholder="<?php echo $entry_page_url; ?>" class="form-control">
                    <?php if ($error_page_url) { ?>
                    <div class="text-danger"><?php echo $error_page_url; ?></div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-facebook-height"><?php echo $entry_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" id="input-facebook-height" name="socialtabs_facebook_height" value="<?php echo $socialtabs_facebook_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  <?php if ($error_facebook_height) { ?>
                  <div class="text-danger"><?php echo $error_facebook_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_show_cover; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_cover" value="true" <?php echo ($socialtabs_show_cover == 'true' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_yes; ?>
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_cover" value="false" <?php echo ($socialtabs_show_cover == 'false' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_no; ?>    
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_show_faces; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_faces" value="true" <?php echo ($socialtabs_show_faces == 'true' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_yes; ?>
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_faces" value="false" <?php echo ($socialtabs_show_faces == 'false' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_no; ?>    
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_show_posts; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_posts" value="true" <?php echo ($socialtabs_show_posts == 'true' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_yes; ?>
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_posts" value="false" <?php echo ($socialtabs_show_posts == 'false' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_no; ?>    
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-locale"><span data-toggle="tooltip" data-html="true" data-trigger="click" title="<?php echo htmlspecialchars($help_locale); ?>"><?php echo $entry_locale; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" id="input-locale" name="socialtabs_locale" value="<?php echo $socialtabs_locale; ?>" placeholder="<?php echo $entry_locale; ?>" class="form-control" />
                </div>
              </div>
            </div>
            <div class="tab-pane fade" id="tab-twitter">
              <div class="form-group">
                <label for="input-widget-id" class="col-sm-2 control-label"><span data-toggle="tooltip" data-html="true" data-trigger="click" title="<?php echo htmlspecialchars($help_widget_id); ?>"><?php echo $entry_widget_id; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" id="input-widget-id" name="socialtabs_widget_id" value="<?php echo $socialtabs_widget_id; ?>" placeholder="<?php echo $entry_widget_id; ?>" class="form-control">
                  <?php if ($error_widget_id) { ?>
                  <div class="text-danger"><?php echo $error_widget_id; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-twitter-height"><?php echo $entry_height; ?></label>
                <div class="col-sm-10">
                  <input type="text" id="input-twitter-height" name="socialtabs_twitter_height" value="<?php echo $socialtabs_twitter_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  <?php if ($error_twitter_height) { ?>
                  <div class="text-danger"><?php echo $error_twitter_height; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_theme; ?></label>
                <div class="col-sm-10">
                  <select name="socialtabs_theme" class="form-control">
                    <?php if ($socialtabs_theme == 'light') { ?>
                    <option value="light" selected="selected"><?php echo $text_light; ?></option>
                    <option value="dark"><?php echo $text_dark; ?></option>
                    <?php } else { ?>
                    <option value="light"><?php echo $text_light; ?></option>
                    <option value="dark" selected="selected"><?php echo $text_dark; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-limit"><span data-toggle="tooltip" title="<?php echo htmlspecialchars($help_limit); ?>"><?php echo $entry_limit; ?></span></label>
                <div class="col-sm-10">
                  <input type="number" id="input-limit" name="socialtabs_limit" value="<?php echo $socialtabs_limit; ?>" placeholder="<?php echo $entry_limit; ?>" class="form-control" />
                  <?php if ($error_limit) { ?>
                  <div class="text-danger"><?php echo $error_limit; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_show_replies; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_replies" value="true" <?php echo ($socialtabs_show_replies == 'true' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_yes; ?>
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="socialtabs_show_replies" value="false" <?php echo ($socialtabs_show_replies == 'false' ? 'checked="checked" ' : ''); ?>/>
                    <?php echo $text_no; ?>    
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-related-users"><span data-toggle="tooltip" title="<?php echo htmlspecialchars($help_related_users); ?>"><?php echo $entry_related_users; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" id="input-related-users" name="socialtabs_related_users" value="<?php echo $socialtabs_related_users; ?>" placeholder="<?php echo $entry_related_users; ?>" class="form-control" />
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>