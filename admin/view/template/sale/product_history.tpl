<table class="table table-bordered">
  <thead>
    <tr>
      <td class="text-left"><?php echo $column_date_added; ?></td>
      <td class="text-left"><?php echo $column_status; ?></td>
      <td class="text-left"><?php echo $column_notify; ?></td>
      <td class="text-left"><?php echo $column_comment; ?></td>
      <!-- # Update Start By: Ismail Ashour -->
      <td class="text-left"><?php echo $column_purchase_source; ?></td>
      <td class="text-left"><?php echo $column_purchase_price; ?></td>
      <td class="text-left"><?php echo $column_product_details; ?></td>
      <td class="text-left"><?php echo $column_delivery_date; ?></td>
      <td class="text-left"><?php echo $column_order_recipient; ?></td>
      <!-- # Update End -->
    </tr>
  </thead>
  <tbody>
    <?php if ($histories) { ?>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="text-left"><?php echo $history['date_added']; ?></td>
      <td class="text-left"><?php echo $history['status']; ?></td>
      <td class="text-left"><?php echo $history['notify']; ?></td>
      <td class="text-left"><?php echo $history['comment']; ?></td>
       <!-- # Update Start By: Ismail Ashour -->
      <?php if ($history['order_status_id'] == $config_complete_status): ?>
      <td class="text-left"><?php echo $history['purchase_source']; ?></td>
      <td class="text-left"><?php echo $history['purchase_price']; ?></td>
      <td class="text-left"><?php echo $history['product_details']; ?></td>
      <td class="text-left"><?php echo date('Y-m-d', strtotime($history['delivery_date'])); ?></td>
      <td class="text-left"><?php echo $history['order_recipient']; ?></td>
      <?php else: ?>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      <?php endif; ?>
      <!-- # Update End -->
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>

<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
