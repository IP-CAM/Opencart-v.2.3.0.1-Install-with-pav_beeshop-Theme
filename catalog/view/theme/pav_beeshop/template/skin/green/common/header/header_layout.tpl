<?php
	$autosearch = $helper->renderModule( 'pavautosearch' );
	$megamenu = $helper->renderModule('pavmegamenu');
	
?>
<header id="header_healthcare">	
		<div class="container">

		<div class="row">

			<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
				<!-- logo -->
				<?php if( $logoType=='logo-theme'){ ?>
				<div id="logo-theme" class="logo pull-left">
					<a href="<?php echo $home; ?>">
						<img src="image/catalog/logo_theme.png" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
					</a>
				</div>
				<?php } elseif ($logo) { ?>
				<div id="logo" class="logo pull-left">
					<a href="<?php echo $home; ?>">
						<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
					</a>
				</div>
				<?php } ?> 
			</div>

			<div class="col-xs-12 col-sm-8 col-md-6 col-lg-6 hidden-xs hidden-sm">
				<?php
			 if(isset($autosearch) &&  !empty($autosearch)) { ?>
				<div id="search-auto" class="search-wrapper pull-right">
					<?php echo $autosearch ?>
				</div> 
				<?php } else { ?>
					<div class="input-group">
						<input type="text" name="search" placeholder="<?php echo $text_search; ?>..." value="<?php echo $search; ?>" class="form-control" />
						<span class="input-group-addon">
							<i class="button-search fa fa-search"></i>
						</span>
					</div>		
				<?php }  ?>
			</div>

			<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 hidden-xs hidden-sm">
				<?php echo $cart; ?>
			
				<div class="btn-group pull-right quick-access">

					<div class="btn-group">
						<button type="button" class="btn btn-normal dropdown-toggle" data-toggle="dropdown">
					      <i class="fa fa-user"></i>
					      <i class="fa fa-angle-down"></i>
					    </button>
					    <div class="dropdown-menu pull-right">
		                    <ul class="links-account">
		                        <li><a class="wishlist" href="<?php echo $wishlist; ?>"><span class="fa fa-heart"></span><?php echo $text_wishlist; ?></a></li>
		                        <li><a class="account" href="<?php echo $account; ?>"><span class="fa fa-user"></span><?php echo $text_account; ?></a></li>
		                        <li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>"><span class="fa fa-shopping-cart"></span><?php echo $text_shopping_cart; ?></a></li>
		                        <li><a class="last checkout" href="<?php echo $checkout; ?>"><span class="fa fa-file"></span><?php echo $text_checkout; ?></a></li>
		                    </ul>
		                </div>
					</div>

					<div class="btn-group">
						<button type="button" class="btn btn-normal dropdown-toggle" data-toggle="dropdown">
					      <i class="fa fa-cog"></i>
					      <i class="fa fa-angle-down"></i>
					    </button>
					    <div class="dropdown-menu pull-right">
		                    <div class="language">
								<?php echo $language; ?>
							</div>
							<div class="currency">
								<?php echo $currency; ?>
							</div> 
		                </div>
					</div>

		        </div>
			</div>
		</div>

		</div>

		<!-- menu -->
		<div id="pav-mainnav">
			<div class="container">
			<?php
			/**
			 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
			 */
			if (count($megamenu) && !empty($megamenu)) { ?>    
			<?php echo $megamenu; ?>
			<?php } elseif ($categories) { ?>
			    <div class="navbar navbar-inverse"> 
			        <nav id="mainmenutop" class="pav-megamenu" role="navigation"> 
			            <div class="navbar-header">
			                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
			                    <span class="sr-only">Toggle navigation</span>
			                    <span class="fa fa-bars"></span>
			                </button>
			            </div>

			            <div class="collapse navbar-collapse navbar-ex1-collapse">
			                <ul class="nav navbar-nav">
			                    <li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home'); ?>"><?php echo $this->language->get('text_home'); ?></a></li>
			                    <?php foreach ($categories as $category) { ?>

			                        <?php if ($category['children']) { ?>			
			                            <li class="parent dropdown deeper ">
			                                <a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
			                                    <b class="fa fa-angle-down"></b>
			                                    <span class="triangles"></span>
			                                </a>
			                            <?php } else { ?>
			                            <li>
			                                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
			                            <?php } ?>
			                            <?php if ($category['children']) { ?>
			                                <ul class="dropdown-menu">
			                                    <?php for ($i = 0; $i < count($category['children']);) { ?>
			                                        <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
			                                        <?php for (; $i < $j; $i++) { ?>
			                                            <?php if (isset($category['children'][$i])) { ?>
			                                                <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
			                                            <?php } ?>
			                                        <?php } ?>
			                                    <?php } ?>
			                                </ul>
			                            <?php } ?>
			                        </li>
			                    <?php } ?>
			                </ul>
			            </div>	
			        </nav>
			    </div>   
			<?php } ?>
			</div>
		</div>
</header>	