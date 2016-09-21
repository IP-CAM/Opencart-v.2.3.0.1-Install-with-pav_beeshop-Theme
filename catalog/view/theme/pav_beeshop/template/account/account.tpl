<?php  echo $header; ?> <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns container">
    
  <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-container.tpl' )  ); ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php if( $SPAN[0] ): ?>

			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 
  
   <div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>"><div id="content">
    <div class="content-inner">
    <?php echo $content_top; ?>  
      <h3><?php echo $text_my_account; ?></h3>
      <ul class="list-unstyled">
        <li><a href="<?php echo $profile; ?>"><?php echo $text_profile; ?></a></li>
        <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
        <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
        <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>

        <?php if($donor): ?>
        <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
        <?php endif; ?>

      </ul>
      
      <?php if($config_group_donor_id == $customer_group_id):?>
      
      <h3><?php echo $text_my_orders; ?></h3>
      <ul class="list-unstyled">
        <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      </ul>

      <?php elseif($config_group_benef_id == $customer_group_id): ?>

      <h3><?php echo $text_my_needs; ?></h3>
      <ul class="list-unstyled">
        <li><a href="<?php echo $needs; ?>"><?php echo $text_needs; ?></a></li>
      </ul>

      <?php endif; ?>
      <h3><?php echo $text_my_newsletter; ?></h3>
      <ul class="list-unstyled">
        <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
      </ul>
      <?php echo $content_bottom; ?>
      </div>
    </div>
   </div> 
<?php if( $SPAN[2] ): ?>
	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">
    <div style="text-align: center; padding-bottom: 20px">
    <!-- # Update Start By: Ismail Ashour -->
     <img src="<?php echo $personal_pic; ?>" />
     <!-- # Update End -->
    </div>
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?></div>
</div>
<?php echo $footer; ?>
