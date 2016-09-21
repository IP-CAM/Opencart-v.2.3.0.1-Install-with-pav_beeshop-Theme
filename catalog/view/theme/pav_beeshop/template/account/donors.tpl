<?php
$helper =  ThemeControlHelper::getInstance( $this->registry );
echo $header;
?>
<?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns container">
  <div class="row">
    <!-- Right Column -->
    <?php if( $SPAN[0] ): ?>
    <aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
      <div id="column-right" class="hidden-xs sidebar">
        <div class="panel panel-default">
          <div style="text-align: center; padding-bottom: 20px">
            <img src="" />
          </div>
          <div class="panel-heading">
            <h4 class="panel-title"></h4>
          </div>
          <div class="list-group">
            <li class="list-group-item"><b>:</b> </li>
            <li class="list-group-item"><b>:</b> </li>
            <li class="list-group-item"><b>:</b> </li>
            <li class="list-group-item"><b>:</b>  </li>
            
          </div>
        </div>
      </div>
    </aside>
    <?php endif; ?>
    <!-- End Right Column -->
    
    <div id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
      <div id="content">
        <div class="pull-left">
          <?php require( ThemeControlHelper::getLayoutPath( 'common/mass-container.tpl' )  ); ?>
        </div>
        <?php echo $content_top; ?>
        <div style="padding-bottom: 40px">
          <h3 class="pull-left">/ </h3>
          <?php if (isset($customer)): ?>
          <h3 class="pull-right"><?php echo $text_views; ?>: <?php echo $views; ?></h3>
          <?php endif; ?>
          <div class="clearfix"></div>
        </div>
        <?php if (isset($products)) { ?>
        <div id="products">
          <div class="products-block row">
            
            <?php foreach ($products as $i => $product) { ?>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-4 product-col border">
              <?php $objlang = $this->registry->get('language');  $ourl = $this->registry->get('url');   ?>
              
              <div class="product-block">
                <?php if ($product['thumb']) {    ?>
                <div class="image">
                  <div class="product-img img">
                    <a class="img" title="<?php echo $product['name']; ?>" href="<?php echo $product['href']; ?>">
                      <img class="img-responsive" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
                    </a>
                  </div>
                  <?php if( (!isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode']) && !isset($add_to_cart_forbidden) ) { ?>
                  <div class="action add-links clearfix">
                    
                    <div class="cart">
                      <button data-loading-text="Loading..." class="btn-action" type="button" data-toggle="tooltip" data-placement="top" title="<?php echo $button_cart; ?>" onclick="cart.addcart('<?php echo $product['product_id']; ?>', '<?php echo $product['customer_id']; ?>', 1);">
                      <i class="fa fa-shopping-cart"></i>
                      </button>
                    </div>
                  </div>
                  
                  <?php } ?>
                </div>
                <?php } ?>
                
                <div class="product-meta">
                  
                  <h6 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h6>
                  <?php if( isset($product['description']) ){ ?>
                  <p class="description"><?php echo utf8_substr( strip_tags($product['description']),0,200);?>...</p>
                  <?php } ?>
                  <?php if ($product['price']) { ?>
                  <div class="price">
                    <span class="price-new"><?php echo $product['price']; ?></span>
                  </div>
                  <?php } ?>
                  
                </div>
              </div>
            </div>
            
            <?php } ?>
            <div class="clearfix"></div>
          </div>
          
          <?php } ?>
          <?php if (!isset($products)) { ?>
          <div class="content">
            <div class="wrapper"><?php echo $text_empty; ?></div>
          </div>
          <div class="buttons">
            <div class="right">
              <a href="<?php echo $continue; ?>" class="button btn btn-default"><?php echo $button_continue; ?>
              </a>
            </div>
          </div>
          <?php } ?>
          <div class="clearfix"></div>

          <?php echo $content_bottom; ?>
        </div>
      </div>
      
      <!-- Left Column -->
      <?php if( $SPAN[2] ): ?>
      <aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">
        <?php echo $column_left; ?>
      </aside>
      <?php endif; ?>
      <!-- End Left Column -->
    </div>
  </div>
  <?php echo $footer; ?>
  <!-- # Update Start By: Ismail Ashour -->
  <!-- # Update End -->