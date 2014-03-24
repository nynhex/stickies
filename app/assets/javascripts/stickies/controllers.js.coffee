StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->
    $scope.hello = "Hello World"
    $scope.stickies = Sticky.query()

    $scope.edit = (sticky) ->
      alert("Edit form: "+ sticky.title)

    $scope.archive = (sticky) ->
      alert("Arcchive: " + sticky.title)
]