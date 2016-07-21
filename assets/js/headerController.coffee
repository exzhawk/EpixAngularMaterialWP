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
    $scope.openLeft = ->
      $mdSidenav('left').open()
    if CURRENT_USER_ID == "0"
      $rootScope.current_user = null
    else
      $rootScope.current_user = UserService.get {}, ->
    $scope.menu = MenuService.get()

]