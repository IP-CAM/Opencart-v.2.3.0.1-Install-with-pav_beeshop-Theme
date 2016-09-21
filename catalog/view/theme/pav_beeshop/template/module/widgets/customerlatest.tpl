<?php
	$objlang = $this->registry->get('language');
	$config = $this->registry->get('config');
?>
<?php if( !empty($customers) ) { ?>
<div id="blog-carousel" class="widget-customers owl-carousel-play latest-posts latest-posts-v1 panel-default <?php $addition_cls?> <?php if ( isset($stylecls)&&$stylecls) { ?>box-<?php echo $stylecls; ?><?php } ?>">
	<?php if( $show_title ) { ?>
	<div class="panel-heading block-border">
		<h3 class="panel-title"><?php echo $heading_title; ?></h3>
	</div>
	<?php } ?>
	<div class="carousel-inner owl-carousel" data-show="1" data-pagination="false" data-navigation="true">
		<?php
			$itemsperpage = 4;
			$cols = 4;
			$pages = array_chunk( $customers, $itemsperpage); $span = 12/$cols;
		?>
		<?php foreach ($pages as  $k => $tcustomers ) {   ?>
		<div class="item <?php if($k==0) {?>active<?php } ?>">
			<?php foreach( $tcustomers as $i => $customer ) {  $i=$i+1;?>
			<?php if( $i%$cols == 1 ) { ?>
			<div class="row products-row">
				<?php } ?>
				<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-<?php  echo ($cols > 2 && $cols % 2 == 0) ? $span * 2 : $span; ?> col-xs-12 product-col">
					<div class="blog-item">
						<div class="latest-posts-body">
							<div class="latest-posts-img-profile">
								<?php if( $customer['thumb']  )  { ?>
								<div class="latest-posts-image ">
									<a href="<?php echo $customer['href'];?>" class="blog-article">
										<img src="<?php echo $customer['thumb'];?>" title="<?php echo $customer['name'];?>" alt="<?php echo $customer['name'];?>" class="img-responsive"/>
									</a>
								</div>
								<?php } ?>
							</div>
							<div class="latest-posts-meta">
								<h4 class="latest-posts-title">
								<a href="<?php echo $customer['href'];?>" title="<?php echo $customer['name'];?>"><?php echo $customer['name'];?></a>
								</h4>
								<!-- # Update Start By: Ismail Ashour -->
								<!--
								<div class="shortinfo">
									<?php $customer['description'] = strip_tags($customer['description']); ?>
									<?php echo utf8_substr( $customer['description'],0, 150 );?>...
								</div>
								<div class="blog-readmore">
									<a class="btn btn-outline-inverse text-light" href="<?php echo $customer['link'];?>"><?php echo $objlang->get('text_readmore');?></a>
								</div>
								-->
								<!-- # Update End -->
							</div>
						</div>
					</div>
				</div>
				<?php if( $i%$cols == 0 || $i==count($tcustomers) ) { ?>
			</div>
			<?php } ?>
			<?php } //endforeach; ?>
		</div>
		<?php } ?>
		
	</div>
	<?php if( count($customers) > 4 ) { ?>
	<div class="carousel-controls">
		<a class="carousel-control left center" href="#blog-carousel" data-slide="prev"><i class="fa fa-angle-left"></i></a>
		<a class="carousel-control right center" href="#blog-carousel" data-slide="next"><i class="fa fa-angle-right"></i></a>
	</div>
	<?php } ?>
</div>
<?php } ?>