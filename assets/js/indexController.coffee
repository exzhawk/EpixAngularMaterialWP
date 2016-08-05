angular
.module 'indexController', ['ngMaterial', 'WPAPI', 'ngSanitize']
.controller 'IndexCtrl', ['$scope', '$mdMedia', '$routeParams', '$location', '$httpParamSerializer', '$rootScope',
  'PostService',
  'TagService', 'CategoryService',
  ($scope, $mdMedia, $routeParams, $location, $httpParamSerializer, $rootScope, PostService, TagService, CategoryService)->
    getTotalpages = (data, header)->
      $scope.totalPage = header()['x-wp-totalpages']
      $scope.pages = [1..$scope.totalPage]
      getPageLink()
    getPageLink = ->
      params = $location.search()
      first_params = JSON.parse(JSON.stringify(params))
      first_params['page'] = 1
      prev_params = JSON.parse(JSON.stringify(params))
      prev_params['page'] = ($scope.currentPage - 1)
      next_params = JSON.parse(JSON.stringify(params))
      next_params['page'] = ($scope.currentPage + 1)
      last_params = JSON.parse(JSON.stringify(params))
      last_params['page'] = $scope.totalPage
      path = $location.path()
      $scope.pageLink =
        first: ['.', path, '?', $httpParamSerializer(first_params)].join('')
        prev: ['.', path, '?', $httpParamSerializer(prev_params)].join('')
        next: ['.', path, '?', $httpParamSerializer(next_params)].join('')
        last: ['.', path, '?', $httpParamSerializer(last_params)].join('')
    $scope.jumpToPage = (page)->
      if page != $scope.currentPage
        $location.search 'page', page
        return
    refreshView = ->
      $scope.currentPage = if $routeParams.page then parseInt($routeParams.page) else 1
      $scope.currentPageSelect = $scope.currentPage
      tax = $location.path()[0..8]
      switch tax
        when '/'
          $scope.posts = PostService.query {page: $scope.currentPage}, getTotalpages
        when '/post/tag'
          $scope.posts = PostService.query params, getTotalpages
        when '/post/cat'
          params = JSON.parse('{"page": "' + $scope.currentPage + '", "filter\[category_name\]": "' + $routeParams.slug + '"}')
          $scope.posts = PostService.query params, getTotalpages
    refreshView()

    $scope.cats = CategoryService.queryObject()
    $scope.tags = TagService.queryObject()
    $scope.$mdMedia = $mdMedia;

    $scope.current_user_id = $rootScope.CURRENT_USER_ID

    return
]
