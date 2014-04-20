StickyCtrls = angular.module "StickyCtrls", []

StickyCtrls.controller "StickyCtrl", [ "$scope", "Sticky"
  ($scope, Sticky) ->

    $scope.init = () ->
      # initialize scoped variables
      $scope.openArchive = false
      $scope.zIndex = 0;
      $scope.shadow = {};
      $scope.draggingSticky = {}
      $scope.innerWidth = window.innerWidth 

      # asynchronous request to retrieve sticky notes
      Sticky.query (data) ->
        $scope.stickies = []
        angular.forEach data, (sticky, index) ->
          sticky.left = sticky.left_ratio * $scope.innerWidth + "px"
          $scope.stickies.push sticky 

      # bind resize event on window that collapses stickynotes with the width of screen
      $(window).on "resize", 
        () ->
          # execute logic only when the width is resized
          if window.innerWidth != $scope.innerWidth
            index = 0

            # iterate through all sticky notes and change each note's left position accordingly
            for sticky in $scope.stickies
              if not sticky.archive
                dom = $('.sticky-note')[index]
                sticky.left = sticky.left_ratio * window.innerWidth + "px"
                dom.style.left = sticky.left
                index += 1
            $scope.innerWidth = window.innerWidth

    # call the initialize function when controller gets loaded into view
    $scope.init()

    # asynchronous request to delete specific sticky note
    $scope.destroy = (sticky) ->
      index = $scope.stickies.indexOf sticky
      $scope.stickies.splice(index, 1)
      Sticky.delete {id: sticky.id}

    # clear text in search input box
    $scope.clearSearch = () ->
      $scope.searchSticky = "" 

    # keep reference of archived sticky note that is being dragged
    $scope.onDrag = (event, ui, sticky, $index) ->
      $scope.draggingSticky = sticky

    # unarchive callback when archived sticky note is dragged into drop zone
    $scope.unArchive = () ->
      $scope.draggingSticky.archive = false

      # asychronous request to update recently unarchived sticky note
      Sticky.update {id: $scope.draggingSticky.id}, $scope.draggingSticky, 
        (data) ->
          $scope.draggingSticky.updated_at = data.updated_at 

    # mousedown callback to focus sticky note being clicked
    $scope.focusSticky = (sticky) ->
      $scope.zIndex += 1
      sticky.zIndex = $scope.zIndex
      if sticky != $scope.shadow
        $scope.shadow.stickyShadow = false
        $scope.shadow = sticky
        $scope.shadow.stickyShadow = true
      else
        $scope.shadow.stickyShadow = !$scope.shadow.stickyShadow

    # open or close archive container
    $scope.toggleArchiveContainer = () ->
      $scope.openArchive = !$scope.openArchive

    # display edit form inside sticky note
    $scope.editForm = (sticky) ->
      sticky.hiddentext = true

    # edit sticky and make asynchronous update
    $scope.editSticky = (sticky) ->
      sticky.hiddentext = false
      Sticky.update {id: sticky.id}, sticky

    # change state of sticky note to archive
    $scope.archive = (sticky) ->
      sticky.archive = true
      Sticky.update {id: sticky.id}, sticky, 
        (data) ->
          sticky.updated_at = data.updated_at 

    # create new generic note and make asychronous request to server to persist note
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
      $scope.stickies.push s
      $scope.focusSticky(s)
     
    # upon release of note persist new location to the database
    $scope.finishDrag = (sticky, $index) ->
      left = $('.sticky-note')[$index].style.left
      top = $('.sticky-note')[$index].style.top
      ratio = parseFloat(left)/$scope.innerWidth
      sticky.left_ratio = ratio
      sticky.left = left
      sticky.top = top
      Sticky.update {id: sticky.id}, sticky

]