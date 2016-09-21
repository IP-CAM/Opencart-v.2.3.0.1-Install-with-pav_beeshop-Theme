<?php if ($error_warning) { ?>
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
  <button type="button" class="close" data-dismiss="alert">&times;</button>
</div>
<?php } ?>
<table class="table table-bordered">
  <thead>
    <tr>
      <td class="text-left" style="width: 200px"><?php echo $column_date_added; ?></td>
      <td class="text-left"><?php echo $column_product; ?></td>
      <td class="text-left" style="width: 200px"><?php echo $column_status; ?></td>
      <td class="text-left" style="width: 100px"></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($products) { ?>
    <?php foreach ($products as $product) { ?>
    <tr>
      <td class="text-left"><?php echo $product['date_added']; ?></td>
      <td class="text-left">
        <a target="_blank" href="<?php echo $product['product_link']; ?>">
          <?php echo $product['name']; ?>
        </a>
      </td>

      <td class="text-left">
        <?php echo $product['status_label']; ?>
      </td>
      <td class="text-left">
        <?php if($product['status'] == 'active'): ?>
          <a href="#" data-product-id="<?php echo $product['product_id']; ?>" data-customer-id="<?php echo $product['customer_id']; ?>" data-status="pending" data-toggle="tooltip" title="" class="btn-activate-delete btn btn-warning" data-original-title="<?php echo $text_pending; ?>"><i class="fa fa-lock"></i></a>
          <a href="#" data-product-id="<?php echo $product['product_id']; ?>" data-customer-id="<?php echo $product['customer_id']; ?>" data-status="delete" data-toggle="tooltip" title="" class="btn-activate-delete btn btn-danger" data-original-title="<?php echo $text_delete; ?>"><i class="fa fa-trash-o"></i></a>
        <?php elseif($product['status'] == 'pending'): ?>
         <a href="#" data-product-id="<?php echo $product['product_id']; ?>" data-customer-id="<?php echo $product['customer_id']; ?>" data-status="active" data-toggle="tooltip" title="" class="btn-activate-delete btn btn-success" data-original-title="<?php echo $text_activate; ?>"><i class="fa fa-thumbs-o-up"></i></a>
         <a href="#" data-product-id="<?php echo $product['product_id']; ?>" data-customer-id="<?php echo $product['customer_id']; ?>" data-status="delete" data-toggle="tooltip" title="" class="btn-activate-delete btn btn-danger" data-original-title="<?php echo $text_delete; ?>"><i class="fa fa-trash-o"></i></a>
        <?php endif; ?>
        
      </td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>

<script type="text/javascript">
<!--
$('a.btn-activate-delete').on('click', function(e) {
  e.preventDefault();

  $.ajax({
    url: 'index.php?route=sale/customer/products&token=<?php echo $token; ?>&customer_id=' + $(this).attr('data-customer-id') + '&product_id=' + $(this).attr('data-product-id') + '&status=' + $(this).attr('data-status'),
    type: 'post',
    dataType: 'html',
    beforeSend: function() {
      $(this).html('loading');
    },
    complete: function() {
      $(this).html('reset');
    },
    success: function(html) {
      $('.alert').remove();

      $('#products').html(html);

      // $('#tab-products textarea[name=\'comment\']').val('');
    }
  });
});
//-->
</script>

<!-- # Update Start By: Ismail Ashour -->
<!-- # Update End -->