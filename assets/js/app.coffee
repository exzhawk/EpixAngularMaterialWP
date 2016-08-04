angular
.module 'EpixAngularMaterialWPApp', ['ngMaterial', 'ngRoute', 'ngAnimate', 'ngMessages', 'headerController',
  'indexController',
  'postController']
.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider)->
  $routeProvider
  .when '/',
    templateUrl: 'assets/partial/index.html'
    controller: 'IndexCtrl'
  .when '/post/tag/:slug',
    templateUrl: 'assets/partial/index.html'
    controller: 'IndexCtrl'
  .when '/post/category/:slug',
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
.run ($rootScope)->
  $rootScope.$on '$routeChangeSuccess', ->
    document.querySelector('#main > md-content').scrollTop = 0
.directive 'compile', ['$compile', ($compile)->
  (scope, element, attrs)->
    scope.$watch (scope)->
      scope.$eval attrs.compile
    ,
      (value)->
        element.html(value)
        $compile(element.contents())(scope)
        return
    return
]
