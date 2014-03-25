StickyService = angular.module "StickyService", ["ngResource"]

StickyService.factory "Sticky", [ "$resource",
  ($resource) ->
    return $resource "/stickies/:id.json",
        id: "@id"
      ,
        update:
          method: "PATCH"
]

StickyService.config ["$httpProvider",
  ($httpProvider)->
     $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]