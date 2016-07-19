array2idObject = (items)->
  result = {}
  for item in items
    result[item.id] = item
  return result

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