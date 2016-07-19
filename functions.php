<?php
/**
 * Created by PhpStorm.
 * User: Epix
 * Date: 2016/7/14
 * Time: 15:45
 */
function epixangularmaterialwp_setup() {
	add_theme_support( 'post-thumbnails' );
	add_image_size( 'w320h320', 320, 320, true );
	add_theme_support( 'html5', array(
		'search-form',
		'comment-form',
		'comment-list',
		'gallery',
		'caption',
	) );
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

function reg_post_thumbnail() {
	register_rest_field( 'post',
		'post_thumbnail',
		array(
			'get_callback'    => 'get_post_thumbnail',
			'update_callback' => null,
			'schema'          => null,
		)
	);
}


function get_post_thumbnail( $object, $field_name, $request ) {
	$media_id = $object['featured_media'];
	if ( $media_id == 0 ) {
		$media = '';
	} else {
		$server = rest_get_server();
		ob_start();
		$server->serve_request( '/wp/v2/media/' . $media_id );
		$media = json_decode( ob_get_contents() );
		ob_end_clean();
	}

	return $media;

}

add_action( 'rest_api_init', 'reg_post_thumbnail' );

function custom_excerpt_length( $length ) {
	return 20;
}

add_filter( 'excerpt_length', 'custom_excerpt_length', 999 );
