<?php 
    
    $mode = 'default';
    $cols = array( 'default' => array(5,7),
                   'horizontal' => array(4,7)
    ); 
    $cols = $cols[$mode]; 
?>

<div class="product-info">
    <div class="row">
    <div class="product-info-bg">
    <?php require( ThemeControlHelper::getLayoutPath( 'common/detail/'.$mode.'.tpl' ) );  ?> 
   
  <div class="col-xs-12 col-sm-<?php echo $cols[1]; ?> col-md-<?php echo $cols[1]; ?> col-lg-<?php echo $cols[1]; ?>">
    <h1 class="title-product"><?php echo $heading_title; ?></h1>

        <?php if ($review_status) { ?>
            <div class="rating">
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                        <?php if ($rating < $i) { ?>
                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                        <?php } else { ?>
                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i></span>
                        <?php } ?>
                    <?php } ?>
                    <a href="#review-form" class="popup-with-form" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $reviews; ?></a> / <a href="#review-form"  class="popup-with-form" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $text_write; ?></a>

            </div>
        <?php } ?>

        <?php if ($price) { ?>
            <div class="price detail">
                <ul class="list-unstyled">
                    <?php if (!$special) { ?>
                        <li>
                            <span class="price-new"> <?php echo $price; ?> </span>
                        </li>
                    <?php } else { ?>

                        <li> <span class="price-new"> <?php echo $special; ?> </span> <span class="price-old"><?php echo $price; ?></span> </li>
                    <?php } ?>
                </ul>
            </div>
        <?php } ?>
        <div class="product-metadata">
            <ul class="list-unstyled">
                <?php if ($stock) { ?>
                    <li><span class="check-box"></span><?php echo $text_stock; ?> <span><i class="fa fa-check"></i> <?php echo $stock; ?></span></li>
                <?php } ?>
                <?php if ($tax) { ?>
                    <li><?php echo $text_tax; ?> <span><?php echo $tax; ?></span></li>
                <?php } ?>

                <?php if ($discounts) { ?>
                    <li>
                    </li>
                    <?php foreach ($discounts as $discount) { ?>
                        <li><?php echo $discount['quantity']; ?> <?php echo $text_discount; ?> <?php echo $discount['price']; ?></li>
                    <?php } ?>
                <?php } ?>
     
                <?php if ($manufacturer) { ?>
                    <li><?php echo $text_manufacturer; ?> <span><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></span></li>
                <?php } ?>
                <li><?php echo $text_model; ?> <span><?php echo $model; ?></span></li>
                <?php if ($reward) { ?>
                    <li><?php echo $text_reward; ?> <span><?php echo $reward; ?></span></li>
                <?php } ?>
                <?php if ($points) { ?>
                    <li><?php echo $text_points; ?> <span><?php echo $points; ?></span></li>
                <?php } ?>
            </ul>
          <?php if ($tags) { ?>
          <p><?php echo "<b>".$text_tags."</b>"; ?>
            <?php for ($i = 0; $i < count($tags); $i++) { ?>
            <?php if ($i < (count($tags) - 1)) { ?>
            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo trim($tags[$i]['tag']); ?></a>,
            <?php } else { ?>
            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo trim($tags[$i]['tag']); ?></a>
            <?php } ?>
            <?php } ?>
          </p>
          <?php } ?>
        </div>

        <hr>
        
        <div id="product">
            <?php if ($options) { ?>
                <h3><?php echo $text_option; ?></h3>
                <?php foreach ($options as $option) { ?>
                    <?php if ($option['type'] == 'select') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                <option value=""><?php echo $text_select; ?></option>
                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                        <?php if ($option_value['price']) { ?>
                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                        <?php } ?>
                                    </option>
                                <?php } ?>
                            </select>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'radio') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label"><?php echo $option['name']; ?></label>
                            <div id="input-option<?php echo $option['product_option_id']; ?>">
                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                            <?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                        </label>
                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'checkbox') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label"><?php echo $option['name']; ?></label>
                            <div id="input-option<?php echo $option['product_option_id']; ?>">
                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                            <?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                        </label>
                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'image') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label"><?php echo $option['name']; ?></label>
                            <div id="input-option<?php echo $option['product_option_id']; ?>">
                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                            <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                        </label>
                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'text') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'textarea') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'file') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label"><?php echo $option['name']; ?></label>
                            <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                            <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'date') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <div class="input-group date">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                </span></div>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'datetime') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <div class="input-group datetime">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                        </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'time') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <div class="input-group time">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                        </div>
                    <?php } ?>
                <?php } ?>
            <?php } ?>
            <?php if ($recurrings) { ?>
                <hr>
                <h3><?php echo $text_payment_recurring ?></h3>
                <div class="form-group required">
                    <select name="recurring_id" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($recurrings as $recurring) { ?>
                            <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                        <?php } ?>
                    </select>
                    <div class="help-block" id="recurring-description"></div>
                </div>
            <?php } ?>

            <div class="form-group">
                <label class="control-label pull-left qty"><?php echo $entry_qty; ?>:</label>
                <div class="quantity-adder pull-left">
                    <div class="quantity-number pull-left">
                        <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                    </div>
                    <span class="add-down add-action pull-left">
                        <i class="fa fa-minus"></i>
                    </span>
                    <span class="add-up add-action pull-left">
                        <i class="fa fa-plus"></i>
                    </span>
                </div>
            </div>

            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />

            <div class="action pull-left">
                <div class="cart pull-left">
                    <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-inverse btn-primary"><?php echo $button_cart; ?></button>
                </div>
                <div class="pull-left">  
                    <button type="button" data-toggle="tooltip" class="wishlist btn btn-default btn-outline" title="<?php echo $button_wishlist; ?>" onclick="wishlist.addwishlist('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button>
                </div>
                <div class="pull-left">
                    <button type="button" data-toggle="tooltip" class="compare btn btn-default btn-outline" title="<?php echo $button_compare; ?>" onclick="compare.addcompare('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
         <hr>

        
        <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
        <?php } ?> 

            <!-- ACCORDION INFOR -->
            <div class="accordion accordion-v3 noborder collapse-right">
                    <div class="panel-group" id="accordion-v5">
                            
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion-v5" href="#collapse-v5-description">
                                            <?php echo $tab_description; ?>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapse-v5-description" class="panel-collapse collapse active in">
                                    <div class="panel-body nopadding">
                                        <?php echo $description; ?>
                                    </div>    
                                </div>        
                            </div>
                            <?php if ($attribute_groups) { ?>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" class="collapsed" data-parent="#accordion-v5" href="#collapse-v5-attribute_groups">
                                            <?php echo $tab_attribute; ?>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapse-v5-attribute_groups" class="panel-collapse collapse">
                                    <div class="panel-body nopadding">
                                        <table class="table table-bordered">
                                            <?php foreach ($attribute_groups as $attribute_group) { ?>
                                                <thead>
                                                    <tr>
                                                        <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                                                        <tr>
                                                            <td><?php echo $attribute['name']; ?></td>
                                                            <td><?php echo $attribute['text']; ?></td>
                                                        </tr>
                                                    <?php } ?>
                                                </tbody>
                                            <?php } ?>
                                        </table>
                                    </div>    
                                </div>        
                            </div>
                            <?php } ?>
                             <?php if ($review_status) { ?>
                             <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion-v5" class="collapsed" href="#collapse-v5-tab_review">
                                            <?php echo $tab_review; ?>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapse-v5-tab_review" class="panel-collapse collapse">
                                    <div class="panel-body nopadding">
                                         <div id="review"></div>
                                            <p> <a href="#review-form"  class="popup-with-form btn btn-sm btn-primary" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $text_write; ?></a></p>

                                           <div class="hide"> <div id="review-form" class="panel review-form-width"><div class="panel-body">
                                            <form class="form-horizontal ">
                                             
                                                <h2><?php echo $text_write; ?></h2>
                                                <div class="form-group required">
                                                    <div class="col-sm-12">
                                                        <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                                        <input type="text" name="name" value="" id="input-name" class="form-control" />
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <div class="col-sm-12">
                                                        <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                                        <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                                                        <div class="help-block"><?php echo $text_note; ?></div>
                                                    </div>
                                                </div>
                                                <div class="form-group required">
                                                    <div class="col-sm-12">
                                                        <label class="control-label"><?php echo $entry_rating; ?></label>
                                                        &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                                                        <input type="radio" name="rating" value="1" />
                                                        &nbsp;
                                                        <input type="radio" name="rating" value="2" />
                                                        &nbsp;
                                                        <input type="radio" name="rating" value="3" />
                                                        &nbsp;
                                                        <input type="radio" name="rating" value="4" />
                                                        &nbsp;
                                                        <input type="radio" name="rating" value="5" />
                                                        &nbsp;<?php echo $entry_good; ?></div>
                                                </div>
                                                <div class="form-group required">
                                                    <div class="col-sm-12">
                                                        <label class="control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
                                                        <input type="text" name="captcha" value="" id="input-captcha" class="form-control" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-12"> <img src="index.php?route=tool/captcha" alt="" id="captcha" /> </div>
                                                </div>
                                                <div class="buttons">
                                                    <div class="pull-right">
                                                        <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                                                    </div>
                                                </div>
                                            </form></div></div></div>
                                    </div>    
                                </div>        
                            </div>
                             <?php  } ?>
                    </div>
            </div>

 
            <!-- ACCORDION INFOR -->
    
        <!-- AddThis Button BEGIN -->
        <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
        <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script> 
        <!-- AddThis Button END --> 
        
  </div>
    </div><!-- End div bg -->
</div>
</div>
<?php if ($products) {  $heading_title = $text_related; $customcols = 5; ?>
<div class="panel panel-default product-grid"> <?php require( PAVO_THEME_DIR."/template/common/products_owl_module.tpl" );  ?> </div>
<?php } ?>
