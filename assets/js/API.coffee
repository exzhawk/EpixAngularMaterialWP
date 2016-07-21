array2idObject = (items)->
  result = {}
  for item in items
    result[item.id] = item
  return result
array2firstObject = (items)->
  return items[0]

angular
.module 'WPAPI', ['ngResource']
.factory 'PostService', ['$resource', ($resource) ->
  $resource 'wp-json/wp/v2/posts',
    page: 1
    per_page: 10
  ,
    query:
      method: 'GET'
      isArray: true
      cache: true
    slug:
      method: 'GET'
      isArray: false
      cache: true
      transformResponse: [angular.fromJson, array2firstObject]
]
.factory 'CategoryService', ['$resource', ($resource)->
  $resource 'wp-json/wp/v2/categories',
    per_page: 100
  ,
    query:
      method: 'GET'
      isArray: true
      cache: true
    queryObject:
      method: 'GET'
      isArray: false
      cache: true
      transformResponse: [angular.fromJson, array2idObject]
]
.factory 'TagService', ['$resource', ($resource)->
  $resource 'wp-json/wp/v2/tags',
    per_page: 100
  ,
    query:
      method: 'GET'
      isArray: true
      cache: true
    queryObject:
      method: 'GET'
      isArray: false
      cache: true
      transformResponse: [angular.fromJson, array2idObject]
]
.factory 'MediaService', ['$resource', ($resource)->
  $resource 'wp-json/wp/v2/media/:id',
    get:
      method: 'GET'
      isArray: false
      cache: true
]
.factory 'CommentService', ['$resource', ($resource)->
  $resource 'wp-json/wp/v2/comments'
]
.factory 'CommentSlugService', ['$resource', ($resource)->
  $resource 'wp-json/wp/v2/comments_slug',
    per_page: 100
  ,
    query:
      method: 'GET'
      isArray: true
      cache: true
]
.factory 'UserService', ['$resource', ($resource)->
  $resource 'wp-json/wp/v2/users/:userId',
    userId: CURRENT_USER_ID
  ,
    get:
      method: 'GET'
      isArray: false
      cache: true
]
.factory 'MenuService', ['$resource', ($resource)->
  $resource 'wp-json/wp-api-menus/v2/menu-locations/:location',
    location: 'primary'
  ,
    get:
      method: 'GET'
      isArray: true
      cache: true

]