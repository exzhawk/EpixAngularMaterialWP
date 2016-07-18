angular
.module 'headerController', ['ngMaterial']
.controller 'HeaderCtrl', ['$scope', '$mdSidenav', ($scope, $mdSidenav)->
  $scope.openLeft = ->
    $mdSidenav('left').open()
]