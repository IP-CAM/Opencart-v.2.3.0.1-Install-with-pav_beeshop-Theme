<?php
	$objlang = $this->registry->get('language');
	$autosearch = $helper->renderModule( 'pavautosearch' );
	$megamenu = $helper->renderModule('pavmegamenu');
?>
<header id="header_skincare">	
		<div class="container">

			<!-- logo -->
			<?php if( $logoType=='logo-theme'){ ?>
			<div id="logo-theme" class="logo">
				<a href="<?php echo $home; ?>">
					<img src="image/catalog/logo_theme.png" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
				</a>
			</div>
			<?php } elseif ($logo) { ?>
			<div id="logo" class="logo">
				<a href="<?php echo $home; ?>">
					<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
				</a>
			</div>
			<?php } ?> 



			<?php echo $cart; ?>
					
			<div id="search" class="search pull-right hidden-xs hidden-sm">
				<div class="dropdown">
					<div class="dropdown-toggle"  data-toggle="dropdown">
					    <i class="button-search fa fa-search"></i>
					    <?php echo $objlang->get('text_search'); ?>
					 </div>
					 <div class="dropdown-menu pull-right fix-width">
					 	<?php echo $search; ?>
					 </div>
				</div>
			</div>
			
			<div class="dropdown pull-left account hidden-xs hidden-sm">
				<div class="dropdown-toggle" data-toggle="dropdown">
			      <i class="fa fa-user"></i>
			     <?php echo $objlang->get('text_account'); ?>
			      <span class="caret"></span>
			    </div>
			    <div class="dropdown-menu">
                    <ul class="links-account">
                        <li><a href="<?php echo $wishlist; ?>"><span class="fa fa-heart"></span><?php echo $text_wishlist; ?></a></li>
                        <li><a href="<?php echo $account; ?>"><span class="fa fa-user"></span><?php echo $text_account; ?></a></li>
                        <li><a href="<?php echo $shopping_cart; ?>"><span class="fa fa-shopping-cart"></span><?php echo $text_shopping_cart; ?></a></li>
                        <li><a href="<?php echo $checkout; ?>"><span class="fa fa-file"></span><?php echo $text_checkout; ?></a></li>
                    </ul>
                </div>
			</div>

			<div class="dropdown pull-left setting hidden-xs hidden-sm">
				<div class="dropdown-toggle" data-toggle="dropdown">
			      <i class="fa fa-cog"></i>
			      <?php echo $objlang->get('text_setting'); ?>
			      <span class="caret"></span>
			    </div>
			    <div class="dropdown-menu">
                    <div class="language">
						<?php echo $language; ?>
					</div>
					<div class="currency">
						<?php echo $currency; ?>
					</div> 
                </div>
			</div>
	        
			
		</div>

		<!-- menu -->
		<div id="pav-mainnav">
			<div class="container">
			<?php
			if (count($megamenu) && !empty($megamenu)) {
			?>
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
			                    <li><a href="<?php echo $home; ?>" title="<?php echo $objlang->get('text_home'); ?>"><?php echo $objlang->get('text_home'); ?></a></li>
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





