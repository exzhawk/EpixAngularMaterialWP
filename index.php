<!DOCTYPE html>
<html lang="en" ng-app="EpixAngularMaterialWPApp" ng-controller="HeaderCtrl">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="theme-color" content="#3F51B5">
	<base href="<?php bloginfo( 'url' ); ?>/">
	<title><?php bloginfo( 'name' ); ?></title>
	<link rel="profile" href="http://gmpg.org/xfn/11">
	<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>">
	<link rel="alternate" type="application/rss+xml" title="<?php bloginfo( 'name' ); ?> > Feed"
	      href="<?php bloginfo( 'rss2_url' ); ?>">
	<?php echo get_theme_mod( 'google_analytics', '' ); ?>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,500,700,400italic">
	<link rel="stylesheet" href="http://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/angular_material/1.0.9/angular-material.css">
</head>
<body layout="row" layout-fill ng-cloak>
<md-sidenav class="md-sidenav-left" md-component-id="left" md-whiteframe="4">
	<md-content layout="row">
		<md-button ng-click="$mdSidenav('left').toggle()">
			<md-icon>arrow_back</md-icon>
		</md-button>
		<h3 flex class="sidenav-title"><?php bloginfo( 'name' ); ?></h3>
	</md-content>
	<form layout-padding layout="row" ng-submit="search()">
		<md-input-container flex>
			<label>&nbsp;</label>
			<input ng-model="keyword" placeholder="Type to Search" type="text" flex>
		</md-input-container>
		<md-button class="md-icon-button" ng-disabled="keyword.length==0" ng-click="search()">
			<md-icon>search</md-icon>
		</md-button>
	</form>
	<md-list ng-repeat="submenu in menu">
		<md-list-item ng-href="{{submenu.url}}">
			<p>{{submenu.title}}</p>
		</md-list-item>
		<md-list-item class="submenu" ng-repeat="subsubmenu in submenu.children" ng-href="{{subsubmenu.url}}">
			<p>{{subsubmenu.title}}</p>
		</md-list-item>
	</md-list>
</md-sidenav>
<md-content flex layout="column" id="main">
	<md-toolbar md-scroll-shrink>
		<div class="md-toolbar-tools">
			<md-button ng-click="$mdSidenav('left').toggle()" hide-gt-sm>
				<md-icon>menu</md-icon>
			</md-button>
			<h2>
				<a href="./"><?php bloginfo( 'name' ); ?></a>
			</h2>
			<span flex></span>
			<div hide-sm hide-xs layout="row">
				<form ng-submit="search()">
					<md-input-container>
						<label>&nbsp;</label>
						<input ng-model="keyword" placeholder="Type to Search" type="text">
					</md-input-container>
					<md-button class="md-icon-button" ng-disabled="keyword.length==0" ng-click="search()">
						<md-icon>search</md-icon>
					</md-button>
				</form>
				<md-menu ng-repeat="submenu in menu" md-offset="0 -10">
					<md-button ng-click="openMenu($mdOpenMenu,$event)" ng-mouseover="openMenu($mdOpenMenu,$event)">
						{{submenu.title}}
					</md-button>
					<md-menu-content ng-mouseleave="$mdMenu.hide()">
						<md-menu-item>
							<md-button ng-href="{{submenu.url}}">
								{{submenu.title}}
							</md-button>
						</md-menu-item>
						<md-menu-divider ng-if="submenu.children.length!=0"></md-menu-divider>
						<md-menu-item ng-repeat="subsubmenu in submenu.children">
							<md-button ng-href="{{subsubmenu.url}}">
								{{subsubmenu.title}}
							</md-button>
						</md-menu-item>
					</md-menu-content>
				</md-menu>
			</div>
			<md-button ng-if="current_user_id!='0'" ng-href="{{adminUrl}}" class="md-icon-button" target="_blank">
				<md-icon>build</md-icon>
			</md-button>
		</div>
	</md-toolbar>
	<md-content>
		<md-content layout="column" layout-gt-md="row" id="container">
			<div ng-view layout-padding flex></div>
			<md-content id="right-sidebar" layout-padding layout="row" layout-gt-md="column" layout-wrap>
				<md-card id="date-filter-widget" class="right-sidebar-widget">
					<md-card-title>
						<md-card-title-text>
							<span class="md-headline">Filter by date</span>
							<span class="md-subhead">Show only posts in date range</span>
						</md-card-title-text>
					</md-card-title>
					<md-card-content layout="column">
						<section layout="row">
							<span flex>From Date</span>
							<md-datepicker ng-model="startDate" md-max-date="endDate" md-min-date="knownMinDate"
							               md-open-on-focus>
							</md-datepicker>
						</section>
						<section layout="row">
							<span flex>To Date</span>
							<md-datepicker ng-model="endDate" md-min-date="startDate" md-max-date="knownMaxDate"
							               md-open-on-focus>
							</md-datepicker>
						</section>
						<md-button ng-disabled="!filterButtonValid" ng-click="filterByDate()">
							show filtered posts
						</md-button>
					</md-card-content>
				</md-card>
				<md-card id="recent-post-widget" class="right-sidebar-widget">
					<md-card-title>
						<md-card-title-text>
							<span class="md-headline">Recent Posts</span>
						</md-card-title-text>
					</md-card-title>
					<md-list class="md-dense">
						<md-list-item class="md-2-line" ng-repeat="recentPost in recentPosts"
						              ng-href="{{recentPost.link}}">
							<div class="md-list-item-text">
								<h3 ng-bind-html="recentPost.title.rendered"></h3>
								<p>{{recentPost.modified}}</p>
							</div>
						</md-list-item>
					</md-list>
				</md-card>
			</md-content>
		</md-content>
		<md-content class='footer' md-theme="footer-dark" layout="row" layout-wrap>
			<md-button ng-href="http://creativecommons.org/licenses/by-sa/4.0/">
				All contents without explicit declaration are licensed under CC-SA-4.0 License
			</md-button>
			<md-button ng-href="https://wordpress.org/">
				Powered by Wordpress
			</md-button>
			<md-button ng-href="https://material.google.com/">
				Material Design by Google
			</md-button>
			<md-button ng-href="http://blog.exz.me">
				Theme by Epix Zhang
			</md-button>
			<md-button ng-if="current_user_id=='0'" ng-href="{{adminUrl}}" class="md-icon-button" target="_blank">
				<md-icon>build</md-icon>
			</md-button>
		</md-content>
	</md-content>
</md-content>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-route.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-animate.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-aria.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-messages.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-resource.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angular_material/1.0.9/angular-material.js"></script>


<script type="text/javascript">
	API_URL = '<?php echo rest_get_url_prefix();?>/wp/v2/';
	TEMPLATE_URL = '<?php echo get_template_directory_uri();?>/';
	NONCE = '<?php echo wp_create_nonce( 'wp_rest' );?>';
	CURRENT_USER_ID = '<?php echo wp_get_current_user()->ID;?>';
	BLOG_URL = '<?php echo rtrim( get_bloginfo( 'url' ), '/' );?>';
	BLOG_BARE_URL = '<?php echo preg_replace( '#^https?://#', '', rtrim( get_bloginfo( 'url' ), '/' ) );?>'
</script>

<link rel="stylesheet" href="<?php echo get_template_directory_uri(); ?>/assets/css/app.css">
<script src="<?php echo get_template_directory_uri(); ?>/assets/js/API.js"></script>
<script src="<?php echo get_template_directory_uri(); ?>/assets/js/app.js"></script>
<script src="<?php echo get_template_directory_uri(); ?>/assets/js/headerController.js"></script>
<script src="<?php echo get_template_directory_uri(); ?>/assets/js/indexController.js"></script>
<script src="<?php echo get_template_directory_uri(); ?>/assets/js/postController.js"></script>
</body>
</html>
