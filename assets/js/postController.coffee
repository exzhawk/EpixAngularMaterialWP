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
.run ->
  scrollButton = ->
    mainContent = document.querySelector('#main > md-content')
    transformMargin = parseInt(mainContent.style.transform.replace('translate3d(0px, ', '').replace('px, 0px)', ''))
    footerHeight = document.querySelector('.footer').scrollHeight
    offsetMargin = 10
    transformHeight = -mainContent.scrollHeight + mainContent.clientHeight + mainContent.scrollTop - transformMargin + footerHeight - offsetMargin
    try
      document.querySelector('#pop-comment-button').style.transform = 'translateY(' + transformHeight + 'px) translateX(20px)'

    requestAnimationFrame scrollButton
  #  angular.element(document.querySelector('#main > md-content')).on 'scroll', (e)->
  #    scrollButton()

  requestAnimationFrame scrollButton
