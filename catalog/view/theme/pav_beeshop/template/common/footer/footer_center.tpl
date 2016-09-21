<?php
  $objlang = $this->registry->get('language');
?>
<div class="<?php echo str_replace('_','-',$blockid); ?> <?php echo $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
  <div class="container">
      <div class="row">
        <?php if( $content=$helper->getLangConfig('widget_site_info') ) {?>
        <div class="column col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <div class="panel-heading"><h4 class="panel-title"><?php echo $objlang->get('text_about_us'); ?></h4></div>
            <div class="panel-body">
                <?php echo $content; ?>
            </div>
        </div>          
        <?php } ?>
        <div class="column col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <div class="panel-heading"><h4 class="panel-title"><?php echo $objlang->get('text_useful_link'); ?></h4></div>
            <div class="panel-body">
              <div class="row">
                <ul class="lists col-xs-12 col-sm-12 col-md-6">
                  <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                  <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                  <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
                  <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                  <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                </ul>
                <ul class="lists col-xs-12 col-sm-12 col-md-6">
                <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
                <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
              </ul>
              </div>
            </div>
        </div>
        <?php if( $content=$helper->getLangConfig('widget_contact_us') ) {?>
        <div class="column col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <div class="panel-heading"><h4 class="panel-title"><?php echo $objlang->get('text_contact_us'); ?></h4></div>
            <div class="panel-body">
                <?php echo $content; ?>
            </div>
        </div>          
        <?php } ?>

      </div>
  </div>
</div>