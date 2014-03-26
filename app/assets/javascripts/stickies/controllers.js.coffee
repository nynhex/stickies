StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->
    $scope.stickies = Sticky.query()

    $scope.edit = (sticky) ->
      $scope.stickies.titlechange = sticky.title
      $scope.stickies.bodychange = sticky.body
      sticky.hiddentext = true

    $scope.changeTitle = (sticky) ->
      sticky.title = $scope.stickies.titlechange
      sticky.body = $scope.stickies.bodychange
      sticky.hiddentext = false

    $scope.archive = (sticky) ->
      alert("Arcchive: " + sticky.title)

    $scope.createSticky = () ->
      Sticky.save {}, {title: "Title", body: "Content", left: "0px", top: "0px"}

    $scope.letGoSticky = (sticky, $index) ->
      left = $('.sticky-note')[$index].style.left
      top = $('.sticky-note')[$index].style.top
      sticky.left = left
      sticky.top = top
      Sticky.update {id: sticky.id}, sticky

]