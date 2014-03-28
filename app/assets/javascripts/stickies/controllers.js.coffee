StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->
    Sticky.query (data) ->
      $scope.stickies = []
      angular.forEach data, (sticky, index) ->
        $scope.stickies.push sticky

    $scope.collapseArchive = true
    $scope.zIndex = 0;
    $scope.shadow = {};
    $scope.movingSticky = {}

    $scope.clearSearch = () ->
      $scope.searchSticky = "" 

    $scope.onMove = (event, ui, sticky, $index) ->
      $scope.movingSticky = sticky
      console.log $scope.movingSticky
      console.log('move is happening')

    $scope.unArchive = () ->
      $scope.movingSticky.archive = false

    $scope.focusSticky = (sticky) ->
      $scope.zIndex += 1
      sticky.zIndex = $scope.zIndex
      $scope.shadow.stickyShadow = false
      $scope.shadow = sticky
      $scope.shadow.stickyShadow = true

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
      sticky = {}
      sticky.top = "90px"
      sticky.left = (window.innerWidth/2 - 125) + "px"
      sticky.title = "New Sticky"
      sticky.body = "Type content here"
      sticky.archive = false
      $scope.stickies.push sticky

    $scope.letGoSticky = (sticky, $index) ->
      left = $('.sticky-note')[$index].style.left
      top = $('.sticky-note')[$index].style.top
      sticky.left = left
      sticky.top = top
      Sticky.update {id: sticky.id}, sticky

]