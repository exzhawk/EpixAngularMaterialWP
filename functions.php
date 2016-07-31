<?php
/**
 * Created by PhpStorm.
 * User: Epix
 * Date: 2016/7/14
 * Time: 15:45
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
		$response = new WP_REST_Response( $result );

		return $response;

	}
endif;
add_action( 'rest_api_init', 'register_routes' );

if ( ! function_exists( 'custom_excerpt_length' ) ):
	function custom_excerpt_length( $length ) {
		return 20;
	}
endif;
add_filter( 'excerpt_length', 'custom_excerpt_length', 999 );
