StickyRouter = angular.module "StickyRouter", ["ngRoute"]

StickyRouter.config [ "$routeProvider", 
  ($routeProvider) ->
    $routeProvider.when "/", 
      templateUrl: "/stickies"
      controller: "StickyCtrl"
]