angular
.module 'EpixAngularMaterialWPApp', ['ngMaterial', 'ngRoute', 'ngMessages', 'headerController','indexController', 'postController']
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
.config ['$httpProvider', ($httpProvider)->
  $httpProvider.interceptors.push('TemplateURLProcessor');
]
