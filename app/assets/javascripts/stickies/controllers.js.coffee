StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->
    $scope.stickies = Sticky.query()

    console.log $scope.stickies

    $scope.edit = (sticky) ->
      alert("Edit form: "+ sticky.title)

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
      console.log sticky

]