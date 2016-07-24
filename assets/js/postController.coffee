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
    $scope.post = PostService.slug {slug: $routeParams.slug}, -> $scope.reply.post = $scope.post.id
    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    $scope.$mdMedia = $mdMedia
    $scope.$mdBottomSheet = $mdBottomSheet
    $scope.comments = CommentSlugService.query {slug: $routeParams.slug}
    $scope.post_comment = ->
      console.log $scope.reply
      CommentService.save $scope.reply

    $scope.hideBottomSheet = ->
      console.log 233
      $mdBottomSheet.hide()

    $scope.popComment = ->
      $mdBottomSheet.show
        templateUrl: 'assets/partial/comment-popup.html'
        controller: angular.noop
        locals:
          parent : $scope
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
.run ->
  scrollButton = ->
    mainContent = document.querySelector('#main > md-content')
    transformMargin = parseInt(mainContent.style.transform.replace('translate3d(0px, ', '').replace('px, 0px)', ''))
    footerHeight = document.querySelector('.footer').scrollHeight
    offsetMargin = 10
    transformHeight = -mainContent.scrollHeight + mainContent.clientHeight + mainContent.scrollTop - transformMargin + footerHeight - offsetMargin
    try
#      document.querySelector('#pop-comment-button').style.transform = 'translateY(' + transformHeight + 'px) translateX(20px)'
    requestAnimationFrame scrollButton
  requestAnimationFrame scrollButton
