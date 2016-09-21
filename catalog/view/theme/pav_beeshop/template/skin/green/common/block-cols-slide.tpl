<?php
/**
 * Showcase modules
 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 */


  //$modules = $helper->getCloneModulesInLayout( $blockid, $layoutID ); 


$blockid = 'slideshow';
$blockcls = 'hidden-xs hidden-sm';
$ospans = array(1=>9, 2=>3);
require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>
