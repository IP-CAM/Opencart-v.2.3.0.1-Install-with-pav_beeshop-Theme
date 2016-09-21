<?php  echo $header; ?> <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns container">
    
  <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-container.tpl' )  ); ?>
  <div class="row"><?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
  
   <div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="content">
    <div class="content-inner">
    <?php echo $content_top; ?>

      <h3 class="page-title"><?php echo $heading_title; ?></h3>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $new; ?>" class="btn btn-primary"><?php echo $button_new_need; ?></a></div>
      </div>
      <?php if ($objects) { ?>
      <div class="table-responsive">
        <table class="table table-bordered table-hover">
          <thead>
            <tr>
              <td class="text-center" style="width: 200px"><?php echo $column_date_added; ?></td>
              <td class="text-center"><?php echo $column_product; ?></td>
              <td class="text-center" style="width: 200px"><?php echo $column_status; ?></td>
              <td class="text-center" style="width: 200px"><?php echo $column_donor; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($objects as $object) { ?>
            <tr>
              <td class="text-center"><?php echo $object['date_added']; ?></td>
              <td class="text-center">
                <a href="<?php echo $object['product_url']; ?>" target="_blank">
                  <?php echo $object['product']; ?>
                </a></td>
              <td class="text-center"><?php echo $object['status']; ?></td>
              <td class="text-center">
                <a href="<?php echo $object['donor_url']; ?>" target="_blank">
                  <?php echo $object['donor']; ?>
                </a>
              </td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </div>
      <div class="text-center"><?php echo $pagination; ?></div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?>
   </div> 
 </div>
   </div> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?></div>
</div>
<?php echo $footer; ?>