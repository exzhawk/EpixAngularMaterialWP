angular
.module 'WPAPI', ['ngResource']
.factory 'PostService', ['$resource', ($resource) ->
  $resource('wp-json/wp/v2/posts')
]
