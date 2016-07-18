angular
.module 'postController', ['ngMaterial', 'WPAPI', 'ngSanitize']
.controller 'PostCtrl', ['$scope', '$routeParams', 'PostService', ($scope, $routeParams, PostService)->
#  $scope.posts = PostService.query();
  console.log($routeParams.slug)

]
