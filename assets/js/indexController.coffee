angular
.module 'indexController', ['ngMaterial', 'WPAPI', 'ngSanitize']
.controller 'IndexCtrl', ['$scope', '$mdMedia', 'PostService', 'TagService', 'CategoryService', 'MediaService',
  ($scope, $mdMedia, PostService, TagService, CategoryService)->
    $scope.posts = PostService.query()
    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    $scope.$mdMedia = $mdMedia;
    return
]
