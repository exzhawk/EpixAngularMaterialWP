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
.directive 'gist', ['$timeout', ($timeout)->
  restrict: 'E',
  replace: true,
  template: '<div class="gist"></div>',
  link: (scope, element, attrs)->
    $timeout ->
      gistId = attrs.id
      fileName = attrs.file
      iframe = document.createElement('iframe')
      iframe.setAttribute('width', '100%');
      iframe.setAttribute('frameborder', '0');
      iframe.id = 'gist-' + gistId
      element[0].appendChild(iframe)
      iframeHtml = '<html><head><base target="_parent"></head>
                    <body onload="parent.document.getElementById(\'' + iframe.id + '\').style.height=document.body.scrollHeight + \'px\'">
                    <script type="text/javascript">
                      window.retargetLinks=function(){
                        var as=document.querySelectorAll("a");
                        var asl=as.length;
                        for (var i=0;i<asl;i++){as[i].setAttribute("target","_blank")}
                      }
                    </script>
                    <script src="https://gist.github.com/' + gistId + '.js?file=' + fileName + '" onload="retargetLinks()"></script>
                    </body></html>'
      doc = iframe.document || iframe.contentDocument || iframe.contentWindow
      doc.open()
      doc.writeln iframeHtml
      doc.close()
    ,
      0
]
.config ['$mdDateLocaleProvider', ($mdDateLocaleProvider)->
  $mdDateLocaleProvider.formatDate = (date)->
    return if date then date.toISOString().slice(0, 10) else null
  $mdDateLocaleProvider.parseDate = (dateString) ->
    return if Date.parse(dateString) then new Date(dateString) else new Date(NaN)
  return
]