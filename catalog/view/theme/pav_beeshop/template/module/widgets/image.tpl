<?php if ( isset($thumbnailurl) )  { ?>
<div class="widget-images box <?php echo $addition_cls ?>  <?php if( isset($stylecls)&&$stylecls ) { ?>box-<?php echo $stylecls;?><?php } ?>">
	<?php if( $show_title ) { ?>
	<div class="widget-heading"><h3 class="panel-title"><?php echo $heading_title?></h3></div>
	<?php } ?>
	<div class="widget-inner img-adv box-content clearfix">
		<div class="image-item effect-adv">
			<!-- # Update Start By: Ismail Ashour -->
			<?php if( $link ){ ?>
			<a href="<?php echo $link; ?>">
				<span class="icon icon-expand"></span>
			<img class="img-responsive" alt=" " src="<?php echo $thumbnailurl; ?>"/></a>
			<?php } else { ?>
			<img class="img-responsive" alt=" " src="<?php echo $thumbnailurl; ?>"/>
			<?php } ?>
			<!-- # Update End -->
		</div>
	</div>
</div>
<?php } ?>