angular
.module 'postController', ['ngMaterial', 'WPAPI', 'ngSanitize', 'ngMessages']
.controller 'PostCtrl', ['$scope', '$compile', '$routeParams','$rootScope','$timeout', '$mdMedia', '$mdBottomSheet', 'PostService',
  'TagService', 'CategoryService', 'CommentService', 'CommentSlugService',
  ($scope, $compile, $routeParams,$rootScope,$timeout, $mdMedia, $mdBottomSheet, PostService, TagService, CategoryService, CommentService, CommentSlugService)->
    $scope.reply =
      author_name: ''
      author_email: ''
      author_url: ''
      content: ''
      parent: 0
    $scope.replyTo = 'Post'
    loadCount = 3
    scrollToComment = ->
      if loadCount == 0
        $timeout ->
          scrollDistance = document.querySelector('#comments').offsetTop
          scrollObject = document.querySelector('#main>md-content')
          console.log scrollObject.scrollHeight
          scrollObject.scrollTop = scrollDistance
    $scope.post = PostService.slug {slug: $routeParams.slug}, ->
      $scope.reply.post = $scope.post.id
      loadCount -= 1
      scrollToComment()
    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    $scope.$mdMedia = $mdMedia
    $scope.comments = CommentSlugService.query {slug: $routeParams.slug}, ->
      loadCount -= 1
      scrollToComment()
    $rootScope.headerScope.recentPosts.$promise.then ->
      loadCount-=1
      scrollToComment()
    $scope.post_comment = ->
      CommentService.save $scope.reply
      .$promise.then ->
        console.log(233)
        $scope.comments = CommentSlugService.query {slug: $routeParams.slug}
        $scope.hideBottomSheet()
        $scope.reply.content = ''

    $scope.hideBottomSheet = ->
      $mdBottomSheet.hide()

    $scope.replyToComment = (commentId, commentName)->
      $scope.replyTo = commentName
      $scope.reply.parent = commentId
      $scope.popComment()

    $scope.replyToPost = ->
      $scope.replyTo = 'Post'
      $scope.reply.parent = 0
      $scope.popComment()

    $scope.popComment = ->
      $mdBottomSheet.show
        templateUrl: 'assets/partial/comment-popup.html'
        controller: angular.noop
        locals:
          parent: $scope
        controllerAs: 'commentCtrl'
        bindToController: true
        clickOutsideToClose: false
        disableBackdrop: true
        escapeToClose: true
        disableParentScroll: false

    buttonHtml = '''
    <md-button class="md-fab md-fab-bottom-right" id="pop-comment-button" ng-click="popComment()">
      <md-icon>comment</md-icon>
    </md-button>
    '''
    buttonElement = $compile(buttonHtml)($scope)
    angular.element(document).find('body').append(buttonElement)
    $scope.$on '$destroy', ->
      angular.element(document.querySelector('#pop-comment-button')).remove()
      angular.element(document.querySelector('.comment-popup')).remove()
    return
]
