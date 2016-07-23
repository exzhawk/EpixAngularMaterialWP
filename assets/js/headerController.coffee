angular
.module 'headerController', ['ngMaterial', 'WPAPI']
.controller 'HeaderCtrl', ['$scope', '$rootScope', '$mdSidenav', '$mdMenu', 'UserService', 'MenuService',
  ($scope, $rootScope, $mdSidenav, $mdMenu, UserService, MenuService)->
    $scope.$mdMenu = $mdMenu
    #    $scope.testMenu = ($mdOpenMenu, $event)->
    #      console.log $mdMenu
    #      console.log $mdOpenMenu
    $scope.openMenu = ($mdOpenMenu, $event)->
      $mdOpenMenu($event)
      angular.element(document).bind 'mousemove', (e)->
        target = angular.element(e.target)
        if target[0].tagName == 'MD-BACKDROP' and target.hasClass('md-menu-backdrop') and !target.hasClass('ng-enter')
          $mdMenu.hide()
      return
    $scope.$mdSidenav = $mdSidenav
    $scope.current_user_id = CURRENT_USER_ID
    if CURRENT_USER_ID == "0"
      $rootScope.current_user = null
    else
      $scope.adminUrl = BLOG_URL + '/wp-admin/'
      $rootScope.current_user = UserService.get {}
    $scope.keyword = ''
    $scope.search = ->
      if $scope.keyword.length != 0
        search_url = 'https://www.google.com/search?q=site%3A' + BLOG_BARE_URL + '+' + $scope.keyword
        location.href = search_url
    $scope.menu = MenuService.get()

]