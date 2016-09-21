<?php
$helper =  ThemeControlHelper::getInstance( $this->registry );
echo $header; ?>
<?php require( ThemeControlHelper::getLayoutPath( 'common/mass-header.tpl' )  ); ?>
<div class="main-columns container">
  <div class="row">
    <!-- Right Column -->
    <?php if( $SPAN[0] ): ?>
    <aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
      <div id="column-right" class="hidden-xs sidebar">
        <div class="panel panel-default">
          <div style="text-align: center; padding-bottom: 20px">
            <img src="<?php echo $personal_pic; ?>" />
          </div>
          <div class="panel-heading">
            <h4 class="panel-title"><?php echo $text_profile_details; ?></h4>
          </div>
          <div class="list-group">
            <li class="list-group-item"><b><?php echo $text_customer_group; ?>:</b> <?php echo $user_group; ?></li>
            <li class="list-group-item"><b><?php echo $text_user_name; ?>:</b> <?php echo $user_name; ?></li>
            <li class="list-group-item"><b><?php echo $text_country; ?>:</b> <?php echo $user_country; ?></li>
            <li class="list-group-item"><b><?php echo $text_city; ?>:</b> <?php echo $user_city; ?> </li>
            
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
          <h3 class="pull-left"><?php echo $text_heading; ?>/ <?php echo $user_name; ?></h3>
          <?php if (isset($customer)): ?>
          <h3 class="pull-right"><?php echo $text_views; ?>: <?php echo $views; ?></h3>
          <?php endif; ?>
          <div class="clearfix"></div>
        </div>
        <?php if ($products) { ?>
        <div id="products">
          <div class="products-block row">
            
            <?php foreach ($products as $i => $product) { ?>
            <!--            <div class=" products-row">-->
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
            
            <!--            </div>-->
            <?php } ?>
            <div class="clearfix"></div>
          </div>
          
          <?php } ?>
          <?php if (!$products) { ?>
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
          
          <?php if($user_type == 'benef'): ?>
          <div class="clearfix box-product-infomation tab-v3">
            <ul class="nav nav-tabs " role="tablist">
              <li class="active">
                <a href="#tab-reason" data-toggle="tab">
                  <?php echo $text_reason; ?>
                </a>
              </li>
            </ul>
            <div class="tab-content text-left" style="padding-top: 5px; line-height: 190%; text-align: justify;">
              <div class="tab-pane  active" id="tab-reason">
                <div id="reason" class="space-20"></div>
                <p>
                  <?php echo $reason; ?>
                </p>
              </div>
            </div>
          </div>
          <?php endif; ?>
          <div class="clearfix"></div>
          <div class="clearfix box-product-infomation tab-v3">
            <ul class="nav nav-tabs " role="tablist">
              <li class="active">
                <a href="#tab-review" data-toggle="tab">
                  <?php echo $tab_review; ?>
                </a>
              </li>
            </ul>
            <div class="tab-content text-left">
              <div class="tab-pane  active" id="tab-review">
                <div id="review" class="space-20"></div>
                <p>
                  <a href="#review-form" class="popup-with-form btn btn-sm btn-primary" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" >
                    <?php echo $text_write; ?>
                  </a>
                </p>
                <div class="hide">
                  <div id="review-form" class="panel review-form-width">
                    <div class="panel-body">
                      <form class="form-horizontal" id="form-review">
                        <input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>" />
                        
                        <h2><?php echo $text_write; ?></h2>
                        <div class="form-group required">
                          <div class="col-sm-12">
                            <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                            <input type="text" name="name" value="" id="input-name" class="form-control" />
                          </div>
                        </div>
                        <div class="form-group required">
                          <div class="col-sm-12">
                            <label class="control-label" for="input-review"><?php echo $entry_comment; ?></label>
                            <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                            <div class="help-block">
                              <?php echo $text_note; ?>
                            </div>
                          </div>
                        </div>
                        <div class="form-group">
                          <div class="col-sm-12">
                            <div class="checkbox">
                              <label><input name="by_email" type="checkbox" > <?php echo $text_by_email; ?></label>
                            </div>
                          </div>
                        </div>
                        <div class="buttons">
                          <div class="pull-right">
                            <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary">
                            <?php echo $button_continue; ?>
                            </button>
                          </div>
                        </div>
                      </form></div></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          <?php echo $content_bottom; ?></div>
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
  <script type="text/javascript"><!--
  $('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();
  $('#review').fadeOut('slow');
  $('#review').load(this.href);
  $('#review').fadeIn('slow');
  });
  $('#review').load('index.php?route=account/profile/review&customer_id=<?php echo $customer_id; ?>');
  $('#button-review').on('click', function() {
  $.ajax({
  url: 'index.php?route=account/profile/write&customer_id=<?php echo $customer_id; ?>',
  type: 'post',
  dataType: 'json',
  data: $("#form-review").serialize(),
  beforeSend: function() {
  $('#button-review').button('loading');
  },
  complete: function() {
  $('#button-review').button('reset');
  },
  success: function(json) {
  $('.alert-success, .alert-danger').remove();
  if (json['error']) {
  $('#review-form').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
  }
  if (json['success']) {
  $('#review-form').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
  $('input[name=\'name\']').val('');
  $('textarea[name=\'text\']').val('');
  }
  }
  });
  });
  //--></script>