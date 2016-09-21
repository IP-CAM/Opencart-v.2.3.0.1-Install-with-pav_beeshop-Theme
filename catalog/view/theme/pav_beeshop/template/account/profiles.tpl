<?php
$helper    =  ThemeControlHelper::getInstance( $this->registry );
echo $header; ?>
<?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class ="main-columns container">
  <div class ="row"><?php if( $SPAN[0] ): ?>
    <aside id  ="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
      <?php echo $column_left; ?>
    </aside>
    <?php endif; ?>
    
    <div id ="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
      <div id ="content">
        
        <!-- # Update Start By: Ismail Ashour -->
        <div class="panel-heading block-border">
          <h3 class="panel-title"><b><?php echo $heading_title; ?></b></h3>
        </div>
        <div>
          <?php if (is_array($customers) && count($customers) > 0 ): ?>
          <div class="products-block" style="padding-bottom: 40px">
          <div class=" products-row">
            <?php $i=0; foreach ($customers as $customer): ?>
            
              <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2 product-col border">
                <div class="product-block">
                  <?php if ($customer['thumb']) {    ?>
                  <div class="">
                    <div class="product-img img">
                      <a title="<?php echo $customer['name']; ?>" href="<?php echo $customer['href']; ?>">
                        <img class="img-responsive" src="<?php echo $customer['thumb']; ?>" title="<?php echo $customer['name']; ?>" alt="<?php echo $customer['name']; ?>" />
                      </a>
                    </div>
                  </div>
                  <?php } ?>
                  
                  <div class="product-meta">
                    <h5 class="name">
                    <a href="<?php echo $customer['href']; ?>">
                      <?php echo $customer['name']; ?>
                    </a>
                    </h5>
                  </div>
                </div>
              </div>

            <?php $i++; if ($i%6==0 ): ?>
              <div class="clearfix"></div>
            <?php endif; ?>
            
            <?php endforeach; ?>
            </div>
          </div>
          <?php else: ?>
          <div style="padding-bottom: 40px">
            <h3><?php echo $text_no_beneficiaries; ?></h3>
          </div>
          <?php endif; ?>
        </div>
        <div class="clearfix"></div>
        <!-- # Update End -->

        <?php if (!$customers) { ?>
        <div class ="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>
        <div class ="buttons">
          <div class ="right"><a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?></a></div>
        </div>
        <?php } ?>
        
        
      <?php echo $content_bottom; ?></div>
    </div>
    <?php if( $SPAN[2] ): ?>
    <aside id  ="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">
      <?php echo $column_right; ?>
    </aside>
  <?php endif; ?></div>
</div>
<?php echo $footer; ?>