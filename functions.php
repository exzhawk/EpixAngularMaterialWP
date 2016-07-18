<?php
/**
 * Created by PhpStorm.
 * User: Epix
 * Date: 2016/7/14
 * Time: 15:45
 */
function epixangularmaterialwp_setup() {
	add_theme_support( 'post-formats', array(
		'aside',
		'image',
		'video',
		'audio',
		'quote',
		'status',
		'gallery',
		'link'
	) );
	register_nav_menus( array(
		'primary' => 'Primary'
	) );
}

add_action( 'after_setup_theme', 'epixangularmaterialwp_setup' );
