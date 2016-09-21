<div class="tree-menu">
    <ul class="information">
        <?php foreach ($informations as $information) { ?>
            <li>
                <a class="link" href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a>
            </li>
        <?php } ?>
    </ul>
</div>