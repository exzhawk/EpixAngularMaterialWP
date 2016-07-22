angular
.module 'EpixAngularMaterialWPApp', ['ngMaterial', 'ngRoute', 'ngMessages', 'headerController', 'indexController',
  'postController']
.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider)->
  $routeProvider
  .when '/',
    templateUrl: 'assets/partial/index.html'
    controller: 'IndexCtrl'
  .when '/post/:slug',
    templateUrl: 'assets/partial/post.html'
    controller: 'PostCtrl'
  .otherwise
      redirectTo: '/'

  $locationProvider.html5Mode(true)
  return
]
.factory 'TemplateURLProcessor', ($q)->
  request: (config) ->
    if config.url.startsWith 'assets/'
      config.url = TEMPLATE_URL + config.url
    config
.factory 'WPNonce', ($q)->
  request: (config) ->
    if config.url.startsWith 'wp-json/'
      config.headers['X-WP-Nonce'] = NONCE
    config
.config ['$httpProvider', ($httpProvider)->
  $httpProvider.interceptors.push('TemplateURLProcessor');
  $httpProvider.interceptors.push('WPNonce');
]
.config ['$mdThemingProvider', ($mdThemingProvider)->
  $mdThemingProvider.theme('footer-dark', 'default')
  .dark()
  return
]
