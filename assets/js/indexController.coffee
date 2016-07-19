angular
.module 'indexController', ['ngMaterial', 'WPAPI', 'ngSanitize']
.controller 'IndexCtrl', ['$scope', 'PostService', 'TagService', 'CategoryService', 'MediaService',
  ($scope, PostService, TagService, CategoryService)->
    $scope.posts = PostService.query()
    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    return
]
