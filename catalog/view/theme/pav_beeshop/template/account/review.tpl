<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>
<table class="table table-v2">
<thead> 
  <tr>
    <th class="text-left" style="width: 50%;"><strong><?php echo $review['author']; ?></strong></th>
    <th class="text-left"><?php echo $review['date_added']; ?></th>
  </tr>  
</thead>
<tbody>
  <tr>
    <td colspan="2"><p><?php echo $review['text']; ?></p></td>
  </tr>
</tbody> 
</table>
<?php } ?>
<div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
<p><?php echo $text_no_reviews; ?></p>
<?php } ?>