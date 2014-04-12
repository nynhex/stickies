StickyRouter = angular.module "StickyRouter", ["ngRoute"]

StickyRouter.config [ "$routeProvider", 
  ($routeProvider) ->
    $routeProvider.when "/", 
      templateUrl: "/view/free"
      controller: "StickyCtrl"

    $routeProvider.when "/free", 
      templateUrl: "/view/free"
      controller: "StickyCtrl"

    $routeProvider.when "/list", 
      templateUrl: "/view/list"
      controller: "StickyCtrl"

    $routeProvider.when "/grid", 
      templateUrl: "/view/grid"
      controller: "StickyCtrl"
]