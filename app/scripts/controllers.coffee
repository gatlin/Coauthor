'use strict'

### Controllers ###

angular.module('app.controllers', ['ui','ngSanitize'])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
])

.directive('editable', () ->
  return (scope, element, attrs) ->
    element.hallo(
      plugins:
        "halloformat": {}
        "halloheadings": {}
        "halloreundo": {}
        "hallolists": {}
        "hallolink": {}
        "halloindicator": {}
      editable: true
      toolbar: 'halloToolbarFixed'
    )

    element.bind "hallomodified", (event, data) ->
)

.controller('PageCtrl', [
  '$scope'
  '$routeParams'

($scope, $routeParams) ->

  $scope.sourceHtml = '''
    <h2>Page Heading</h2>

    <p class="ui-droppable">Click here to begin editing!</p>
    </ul>
  '''

])

