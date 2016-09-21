<?php
$mode = 'default';
$cols = array( 'default' => array(5,7),
'horizontal' => array(4,7)
);
$cols = $cols[$mode];
?>
<div class="product-info">
    <div class="row">
        
        <?php require( ThemeControlHelper::getLayoutPath( 'product/detail/preview/'.$mode.'.tpl' ) );  ?>
        
        <div class="col-xs-12 col-sm-<?php echo $cols[1]; ?> col-md-<?php echo $cols[1]; ?> col-lg-<?php echo $cols[1]; ?>">
            <div class="product-info-bg">
                <h3 class="title-product"><?php echo $heading_title; ?></h3>
                <?php if ($review_status) {/* ?>
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
                <?php */ } ?>
                <?php if ($price) { ?>
                <div class="price detail space-20">
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
                <ul class="list-unstyled">
                    <?php if ($tax) { ?>
                    <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
                    <?php } ?>
                    <?php if ($discounts) { ?>
                    <li>
                    </li>
                    <?php foreach ($discounts as $discount) { ?>
                    <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                    <?php } ?>
                    <?php } ?>
                </ul>
                <?php if ($stock) { ?>
                <ul class="list-unstyled">
                    <li><span class="check-box text-success"><i class="fa fa-check"></i></span> <b><?php echo $text_stock; ?></b> <?php echo $stock; ?></li>
                </ul>
                <?php } ?>
                
                <div class="border-success space-30">
                    <ul class="list-unstyled">
                        <?php if ($manufacturer) { ?>
                        <li><b><?php echo $text_manufacturer; ?></b> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
                        <?php } ?>
                        <li><b><?php echo $text_model; ?></b> <?php echo $model; ?></li>
                        <?php if ($reward) { ?>
                        <li><b><?php echo $text_reward; ?></b> <?php echo $reward; ?></li>
                        <?php } ?>
                        <?php if ($points) { ?>
                        <li><b><?php echo $text_points; ?></b> <?php echo $points; ?></li>
                        <?php } ?>
                    </ul>
                </div>
                
                
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
                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                            </span></div>
                        </div>
                        <?php } ?>
                        <?php if ($option['type'] == 'datetime') { ?>
                        <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                            <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                            <div class="input-group datetime">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                            </div>
                            <?php } ?>
                            
                            <?php if ($option['type'] == 'time') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <div class="input-group time">
                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                                </div>
                                <?php } ?>
                                <?php } ?>
                                <?php } ?>
                                <?php if ($recurrings) { ?>
                                
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
                                <!-- # Update Start By: Ismail Ashour -->
                                <!--
                                <div class="product-extra">
                                    <label class="control-label pull-left qty"><?php echo $entry_qty; ?>:</label>
                                    <div class="quantity-adder pull-left">
                                        <span class="add-down add-action pull-left">
                                            <i class="fa fa-minus"></i>
                                        </span>
                                        <div class="quantity-number pull-left">
                                            <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                                        </div>
                                        
                                        <span class="add-up add-action pull-left">
                                            <i class="fa fa-plus"></i>
                                        </span>
                                    </div>
                                </div>
                                -->
                                <!-- # Update End -->
                                
                                <div class="clearfix"></div>
                                <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                <div class="action">
                                    <!-- # Update Start By: Ismail Ashour -->
                                    <!--
                                    <div class="cart pull-left">
                                        <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-outline-inverse"><i class="fa fa-shopping-cart"></i><?php echo $button_cart; ?></button>
                                    </div> -->
                                    <!-- # Update End -->
                                    <?php if($donor): ?>
                                    <div class="pull-left">
                                        <a data-toggle="tooltip" class="wishlist" title="<?php echo $button_wishlist; ?>" onclick="wishlist.addwishlist('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></a>
                                    </div>
                                    <?php endif; ?>
                                    <!-- # Update Start By: Ismail Ashour -->
                                    <!--
                                    <div class="pull-left">
                                        <a data-toggle="tooltip" class="compare" title="<?php echo $button_compare; ?>" onclick="compare.addcompare('<?php echo $product_id; ?>');"><i class="fa fa-refresh"></i></a>
                                    </div> -->
                                    <!-- # Update End -->
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            
                            <?php if ($minimum > 1) { ?>
                            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
                            <?php } ?>
                            <!-- AddThis Button BEGIN -->
                            <div class="addthis_toolbox addthis_default_style space-padding-tb-20"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
                            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
                            <!-- AddThis Button END -->
                            <div class="tags">
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
                        </div>
                        </div><!-- End div bg -->
                    </div>
<!-- # Update Start By: Ismail Ashour -->
<div class="panel-heading block-border">
    <h3 class="panel-title"><b><?php echo $text_beneficiaries; ?></b></h3>
</div>
<div>
    <?php if (is_array($customers) && count($customers) > 0 ): ?>
    <div class="products-block" style="padding-bottom: 40px">
        <?php foreach ($customers as $key => $customer) { ?>
        <div class=" products-row">
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
        </div>
        <?php } ?>
    </div>
    <?php else: ?>
    <div style="padding-bottom: 40px">
        <h3><?php echo $text_no_beneficiaries; ?></h3>
    </div>
    <?php endif; ?>
</div>
<div class="clearfix"></div>
<!-- # Update End -->
                    <div class="clearfix box-product-infomation tab-v3">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
                            <?php if ($attribute_groups) { ?>
                            <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
                            <?php } ?>
                            <?php if ($review_status) { ?>
                            <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
                            <?php } ?>
                            <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_name'][$languageID]) ) { ?>
                            <li><a href="#tab-customtab" data-toggle="tab"><?php echo $productConfig['product_customtab_name'][$languageID]; ?></a></li>
                            <?php } ?>
                        </ul>
                        <div class="tab-content text-left">
                            <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
                            <?php if ($attribute_groups) { ?>
                            <div class="tab-pane" id="tab-specification">
                                <table class="table table-v2">
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
                            <?php } ?>
                            <?php if ($review_status) { ?>
                            <div class="tab-pane" id="tab-review">
                                <div id="review" class="space-20">
                                </div>
                                <p> <a href="#review-form"  class="popup-with-form btn btn-sm btn-primary" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;" ><?php echo $text_write; ?></a></p>
                                <div class="hide"> <div id="review-form" class="panel review-form-width"><div class="panel-body">
                                    <form class="form-horizontal" id="form-review">
                                        
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
                                        <?php if ($site_key) { ?>
                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
                                            </div>
                                        </div>
                                        <?php } ?>
                                        <div class="buttons">
                                            <div class="pull-right">
                                                <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                                            </div>
                                        </div>
                                    </form></div></div>
                                </div>
                            </div>
                            <?php } ?>
                            <?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_content'][$languageID]) ) { ?>
                            <div id="tab-customtab" class="tab-content custom-tab">
                                <div class="inner">
                                    <?php echo html_entity_decode( $productConfig['product_customtab_content'][$languageID], ENT_QUOTES, 'UTF-8'); ?>
                                </div>
                            </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>
                <?php if ($products) {  $heading_title = $text_related; $customcols = 4; ?>
                <div class="panel-default product-grid"> <?php require( PAVO_THEME_DIR."/template/common/products_owl_module.tpl" );  ?> </div>
                <?php } ?>