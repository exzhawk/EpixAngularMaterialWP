angular
.module 'postController', ['ngMaterial', 'WPAPI', 'ngSanitize', 'ngMessages']
.controller 'PostCtrl', ['$scope', '$mdMedia', '$routeParams', 'PostService', 'TagService', 'CategoryService',
  'CommentService', 'CommentSlugService',
  ($scope, $mdMedia, $routeParams, PostService, TagService, CategoryService, CommentService, CommentSlugService)->
    $scope.reply =
      author_name: ''
      author_email: ''
      author_url: ''
      content: ''
    $scope.post = PostService.slug {slug: $routeParams.slug}, -> $scope.reply.post = $scope.post.id
    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    $scope.$mdMedia = $mdMedia;
    $scope.comments = CommentSlugService.query {slug: $routeParams.slug}
    $scope.post_comment = ->
      console.log $scope.reply
      CommentService.save $scope.reply
    return
]

