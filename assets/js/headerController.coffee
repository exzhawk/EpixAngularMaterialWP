angular
.module 'headerController', ['ngMaterial', 'WPAPI']
.controller 'HeaderCtrl', ['$scope', '$rootScope', '$mdSidenav', 'UserService',
  ($scope, $rootScope, $mdSidenav, UserService)->
    $scope.openLeft = ->
      $mdSidenav('left').open()
    if CURRENT_USER_ID == "0"
      $rootScope.current_user = null
    else
      $rootScope.current_user = UserService.get({}, ->
        console.log $rootScope.current_user
      )
]