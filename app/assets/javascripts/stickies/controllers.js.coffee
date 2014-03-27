StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->
    $scope.stickies = Sticky.query()
    $scope.sticks = $scope.stickies
    $scope.collapseArchive = true
    $scope.zIndex = 0;

    $scope.focusSticky = (sticky) ->
      $scope.zIndex += 1
      sticky.zIndex = $scope.zIndex
      console.log $scope.zIndex

    $scope.toggleArchive = () ->
      $scope.collapseArchive = !$scope.collapseArchive

    $scope.editSticky = (sticky) ->
      $scope.stickies.titlechange = sticky.title
      $scope.stickies.bodychange = sticky.body
      sticky.hiddentext = true

    $scope.changeContent = (sticky) ->
      sticky.title = $scope.stickies.titlechange
      sticky.body = $scope.stickies.bodychange
      sticky.hiddentext = false
      Sticky.update {id: sticky.id}, sticky

    $scope.archive = (sticky) ->
      sticky.archive = true
      Sticky.update {id: sticky.id}, sticky


    $scope.createSticky = () ->
      console.log("Sticky Created")

    $scope.letGoSticky = (sticky, $index) ->
      left = $('.sticky-note')[$index].style.left
      top = $('.sticky-note')[$index].style.top
      sticky.left = left
      sticky.top = top
      Sticky.update {id: sticky.id}, sticky

]