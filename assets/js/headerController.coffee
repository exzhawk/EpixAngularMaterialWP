angular
.module 'headerController', ['ngMaterial', 'WPAPI']
.controller 'HeaderCtrl', ['$scope', '$rootScope', '$location', '$httpParamSerializer', '$routeParams', '$mdSidenav',
  '$mdMenu',
  'UserService', 'MenuService', 'PostService', 'DateRangeService',
  ($scope, $rootScope, $location, $httpParamSerializer, $routeParams, $mdSidenav, $mdMenu, UserService, MenuService, PostService, DateRangeService)->
    $rootScope.headerScope = $scope
    $scope.$mdMenu = $mdMenu
    $scope.openMenu = ($mdOpenMenu, $event)->
      $mdOpenMenu($event)
      angular.element(document).bind 'mousemove', (e)->
        target = angular.element(e.target)
        if target[0].tagName == 'MD-BACKDROP' and target.hasClass('md-menu-backdrop')
          $mdMenu.hide()
      return
    $scope.$mdSidenav = $mdSidenav
    $scope.adminUrl = BLOG_URL + '/wp-admin/'
    $scope.current_user_id = CURRENT_USER_ID
    $rootScope.CURRENT_USER_ID = CURRENT_USER_ID
    if CURRENT_USER_ID == "0"
      $rootScope.current_user = null
    else
      $rootScope.current_user = UserService.get {}
    $scope.keyword = ''
    $scope.search = ->
      if $scope.keyword.length != 0
        search_url = 'https://www.google.com/search?q=site%3A' + BLOG_BARE_URL + '+' + $scope.keyword
        location.href = search_url
    $scope.menu = MenuService.get()
    $scope.recentPosts = PostService.query()
    $scope.date_range = DateRangeService.get {}, (data)->
      $scope.knownMinDate = new Date(data['first_date'])
      $scope.startDate = if $routeParams.after then new Date($routeParams.after) else $scope.knownMinDate
      $scope.knownMaxDate = new Date(data['last_date'])
      $scope.endDate = if $routeParams.before then new Date($routeParams.before) else $scope.knownMaxDate
      $scope.filterButtonValid = true
    addDay = (date)->
      return new Date(date.getTime() + 86400000)
    $scope.filterByDate = ->
      filterDate = {}
      if $scope.startDate > $scope.knownMinDate
        filterDate['after'] = $scope.startDate.toISOString()
      if addDay($scope.endDate) <= $scope.knownMaxDate
        filterDate['before'] = addDay($scope.endDate).toISOString()
      url = ['/?', $httpParamSerializer(filterDate)].join('')
      $location.url(url)
]