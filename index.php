<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
	<base href="<?php bloginfo( 'url' ); ?>/">
	<title>Blog ww</title>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,500,700,400italic">
	<link rel="stylesheet" href="http://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet"
	      href="<?php echo get_template_directory_uri(); ?>/bower_components/angular-material/angular-material.css">
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular/angular.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-route/angular-route.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-animate/angular-animate.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-aria/angular-aria.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-messages/angular-messages.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-resource/angular-resource.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-sanitize/angular-sanitize.js"
	        type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/bower_components/angular-material/angular-material.js"
	        type="text/javascript" defer></script>

	<script type="text/javascript">
		API_URL = '<?php echo rest_get_url_prefix();?>/wp/v2/';
		TEMPLATE_URL = '<?php echo get_template_directory_uri();?>/';
	</script>

	<link rel="stylesheet" href="<?php echo get_template_directory_uri(); ?>/assets/css/app.css">
	<script src="<?php echo get_template_directory_uri(); ?>/assets/js/API.js" type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/assets/js/app.js" type="text/javascript" defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/assets/js/headerController.js" type="text/javascript"
	        defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/assets/js/indexController.js" type="text/javascript"
	        defer></script>
	<script src="<?php echo get_template_directory_uri(); ?>/assets/js/postController.js" type="text/javascript"
	        defer></script>
</head>
<body ng-app="EpixAngularMaterialWPApp">
<div ng-controller="HeaderCtrl" layout="row" layout-fill>
	<md-sidenav class="md-sidenav-left" md-component-id="left" md-whiteframe="4">
		233
	</md-sidenav>
	<md-content flex>
		<md-toolbar>
			<div class="md-toolbar-tools">
				<md-button ng-click="openLeft()" hide-gt-md>
					<md-icon>menu</md-icon>
				</md-button>
				<h2>
					<a href="./">Epix Sphere</a>
				</h2>
				<span flex></span>
			</div>
		</md-toolbar>
		<div ng-view layout-padding flex></div>
	</md-content>
</div>

</body>
</html>
