StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->

    $scope.init = () ->
      $scope.collapseArchive = true
      $scope.zIndex = 0;
      $scope.shadow = {};
      $scope.movingSticky = {}
      $scope.innerWidth = window.innerWidth 

      Sticky.query (data) ->
        $scope.stickies = []
        angular.forEach data, (sticky, index) ->
          sticky.left = sticky.left_ratio * $scope.innerWidth + "px"
          $scope.stickies.push sticky 

      $(window).on "resize", 
        () ->
          if window.innerWidth != $scope.innerWidth
            angular.forEach $scope.stickies, (sticky, index) ->
              sticky.left = sticky.left_ratio * window.innerWidth + "px"
            $scope.innerWidth = window.innerWidth

    $scope.init()


    $scope.clearSearch = () ->
      $scope.searchSticky = "" 

    $scope.onMove = (event, ui, sticky, $index) ->
      $scope.movingSticky = sticky


    $scope.unArchive = () ->
      $scope.movingSticky.archive = false
      Sticky.update {id: $scope.movingSticky.id}, $scope.movingSticky

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
      sticky.left_ratio = parseFloat(sticky.left) / $scope.innerWidth
      sticky.title = "New Sticky"
      sticky.body = "Type content here"
      sticky.archive = false
      s = Sticky.save {}, sticky
      s.left = sticky.left
      console.log s
      console.log sticky
      $scope.stickies.push s
      $scope.focusSticky(s)
     
    $scope.letGoSticky = (sticky, $index) ->
      left = $('.sticky-note')[$index].style.left
      top = $('.sticky-note')[$index].style.top
      ratio = parseFloat(left)/$scope.innerWidth
      sticky.left_ratio = ratio
      sticky.left = left
      sticky.top = top
      Sticky.update {id: sticky.id}, sticky

]