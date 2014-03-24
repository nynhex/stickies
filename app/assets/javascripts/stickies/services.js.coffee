StickyService = angular.module "StickyService", ["ngResource"]

StickyService.factory "Sticky", [ "$resource",
  ($resource) ->
    return $resource "/stickies/:id.json",
        id: "@id"
        update:
          method: "PATCH"
]