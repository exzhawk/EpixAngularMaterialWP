<?php
/**
 * Created by PhpStorm.
 * User: Epix
 * Date: 2016/7/14
 * Time: 15:45
 */

/**
 * nest comments by parent property
 *
 * @param $comments
 *
 * @return array
 */
function nest_comments( $comments ) {
	$lookup = array();
	foreach ( $comments as $comment ) {
		$comment->children      = array();
		$lookup[ $comment->id ] = $comment;
	}
	$result = array();
	foreach ( $comments as $comment ) {
		if ( $comment->parent != 0 ) {
			$parent_comment = $lookup[ $comment->parent ];
			array_push( $parent_comment->children, $comment );
		} else {
			array_push( $result, $comment );
		}
	}

	return $result;
}

/**
 * setup theme
 */
if ( ! function_exists( 'epixangularmaterialwp_setup' ) ):
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
endif;
add_action( 'after_setup_theme', 'epixangularmaterialwp_setup' );

/**
 * add post_thumbnail element to a post
 */
if ( ! function_exists( 'reg_post_thumbnail' ) ):
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
endif;
add_action( 'rest_api_init', 'reg_post_thumbnail' );

/**
 * add comment_count property to a post
 */
if ( ! function_exists( 'reg_post_comment_count' ) ):
	function reg_post_comment_count() {
		register_rest_field( 'post',
			'comment_count',
			array(
				'get_callback'    => 'get_post_comment_count',
				'update_callback' => null,
				'schema'          => null,
			)
		);
	}


	function get_post_comment_count( $object, $field_name, $request ) {
		$post_id       = $object['id'];
		$comment_count = wp_count_comments( $post_id )->approved;

		return $comment_count;
	}
endif;
add_action( 'rest_api_init', 'reg_post_comment_count' );

/**
 * add get_comments_by_slug to access comment by post slug
 */
if ( ! function_exists( 'register_routes' ) ):
	function register_routes( $routes ) {

		register_rest_route( 'wp/v2', 'comments_slug', array(
			'methods'  => 'GET',
			'callback' => 'get_comments_by_slug',
			'args'     => array(
				'slug' => array(
					'required' => false
				)
			)
		) );

	}

	function get_comments_by_slug( WP_REST_Request $request ) {
		$slug   = $request['slug'];
		$post   = get_page_by_path( $slug, ARRAY_A, 'post' );
		$server = rest_get_server();
		ob_start();
		unset( $_GET['slug'] );
		$_GET['post'] = $post['ID'];
		$server->serve_request( '/wp/v2/comments' );
		$comments = json_decode( ob_get_contents() );
		ob_end_clean();
		$result   = nest_comments( $comments );
		$response = new WP_REST_Response( $result );

		return $response;

	}
endif;
add_action( 'rest_api_init', 'register_routes' );

/**
 * add support for gallery shortcode
 */
if ( ! function_exists( 'epix_galllery_shortcode' ) ):
	remove_shortcode( 'gallery' );
	add_shortcode( 'gallery', 'epix_galllery_shortcode' );
	function epix_galllery_shortcode( $attr ) {
		$images = get_posts( array(
			'include'        => $attr['id'],
			'order'          => 'post__in',
			'post_status'    => 'public',
			'post_type'      => 'attachment',
			'post_mime_type' => 'image',

		) );
		$output = '  <md-grid-list md-cols-xs="2" md-cols-sm="3" md-cols-md="6" md-cols-lg="6" md-cols-gt-lg="10"
				   md-row-height="1:1" md-gutter="12px" md-gutter-gt-sm="8px" class="gallery">';
		foreach ( $images as $image ) {
			$thumbnail_image_url = wp_get_attachment_image_url( $image->ID, 'thumbnail' );
			$full_image_url      = wp_get_attachment_image_url( $image->ID, 'full' );
			$img_output          = '<md-grid-tile  md-rowspan="1" md-colspan="1" 
							ng-click="openGalleryDialog(\''.$image->post_title.'\', \''.$full_image_url.'\', $event)">
							<img src="' . $thumbnail_image_url . '">
							<md-grid-tile-footer>
							<h3>' . $image->post_title . '</h3>
							</md-grid-tile-footer>
							</md-grid-tile>';
			$output .= $img_output;

		}

		$output .= '</md-grid-list>';

		return $output;
	}
endif;


/**
 * limit excerpt length
 */
if ( ! function_exists( 'custom_excerpt_length' ) ):
	function custom_excerpt_length( $length ) {
		return 20;
	}
endif;
add_filter( 'excerpt_length', 'custom_excerpt_length', 999 );

/**
 * allow other types upload to media library
 */
if(!function_exists('enable_extended_upload')):
function enable_extended_upload ( $mime_types =array() ) {

// The MIME types listed here will be allowed in the media library.
// You can add as many MIME types as you want.
//$mime_types['zip'] = 'application/zip';
	$mime_types['json'] = 'application/json';

	return $mime_types;
}
endif;
add_filter('upload_mimes', 'enable_extended_upload');