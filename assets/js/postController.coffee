angular
.module 'postController', ['ngMaterial', 'WPAPI', 'ngSanitize', 'ngMessages']
.controller 'PostCtrl', ['$scope', '$compile', '$routeParams', '$mdMedia', '$mdBottomSheet', 'PostService',
  'TagService', 'CategoryService', 'CommentService', 'CommentSlugService',
  ($scope, $compile, $routeParams, $mdMedia, $mdBottomSheet, PostService, TagService, CategoryService, CommentService, CommentSlugService)->
    $scope.reply =
      author_name: ''
      author_email: ''
      author_url: ''
      content: ''
      parent: 0
    $scope.post = PostService.slug {slug: $routeParams.slug}, -> $scope.reply.post = $scope.post.id
    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    $scope.$mdMedia = $mdMedia
    $scope.comments = CommentSlugService.query {slug: $routeParams.slug}
    $scope.post_comment = ->
      console.log $scope.reply
      CommentService.save $scope.reply

    $scope.hideBottomSheet = ->
      $mdBottomSheet.hide()

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
    return
]
