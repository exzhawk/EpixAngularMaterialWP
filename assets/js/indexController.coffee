angular
.module 'indexController', ['ngMaterial','WPAPI','ngSanitize']
.controller 'IndexCtrl', ['$scope', 'PostService', ($scope, PostService)->
  $scope.posts = PostService.query();
]
