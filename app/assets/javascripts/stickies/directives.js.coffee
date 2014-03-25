Draggable = angular.module "Draggable", [] 

Draggable.directive 'dragMe', 
  () ->
    return {
      restrict: 'A',
      link: (scope, elem, attr, ctrl) ->
        elem.draggable();
        return
      }
      
