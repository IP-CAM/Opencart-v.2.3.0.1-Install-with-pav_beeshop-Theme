<div class="panel panel-default panel-v4 <?php echo $addition_cls; ?>">
	<?php if( $show_title ) { ?>
		<div class="widget-heading panel-heading block-borderbox">
			<h4 class="panel-title" data-number-split="2"><?php echo $heading_title?></h4>
		</div>
	<?php } ?>

	<div class="widget-inner panel-body tree-menu block-content">
		<ul class="list-arrow">
			<?php foreach ($categories_list as $category){ ?>
			<li><a href="<?php echo $category['href']; ?>"><span class="title"><?php echo $category['name']; ?></span></a></li>
			<?php } ?>
		</ul>
	</div>
</div>

