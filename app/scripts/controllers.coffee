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

  $scope.converter = new Showdown.converter()

  $scope.md2html = (md) ->
    $scope.converter.makeHtml(md)

  $scope.html2md = (html) ->
    html_ = html.split("\n").map($.trim).filter( (line) ->
      line != ""
    ).join "\n"
    toMarkdown html_
])

.value('ui.config',
  jq:
    wysihtml5:
      useLineBreaks: false
      autoLink: true
      parserRules: wysihtml5ParserRules
      stylesheets: ['/css/app.css']
)

.directive('editable', () ->
  (scope, element, attrs) ->
    id = attrs.id
    ed = $('#'+id).data("wysihtml5").editor
    ed.on 'load', () ->
      scope.$watch 'content', () ->
        ed.focus()
        ed.composer.commands.exec 'insertHTML', scope.content
    ed.on 'change', () ->
      scope.pouchdb.get scope.pageId, (err, doc) ->
        doc.content = $('#'+id).val()
        scope.pouchdb.put doc, (err, res) ->
          console.log res
)

.controller('EditCtrl', [
  '$scope'
  '$routeParams'

($scope, $routeParams) ->

  $scope.pageId = $routeParams.id
  console.log $scope.pageId

  Pouch 'idb://pages', (err,db) ->
    $scope.pouchdb = db
    db.get $scope.pageId, (err, doc) ->
      if err
        db.put {_id:$scope.pageId, content:''}
        $scope.content = ''
      else
        console.log doc
        $scope.$apply () ->
          $scope.content = doc.content
          console.log $scope.content
          console.log doc.content

])

.controller('PageCtrl', [
  '$scope'
  '$routeParams'

($scope, $routeParams) ->

  $scope.pageId = $routeParams.id
  console.log $scope.pageId

  Pouch 'idb://pages', (err,db) ->
    $scope.pouchdb = db
    db.get $scope.pageId, (err, doc) ->
      if err
        db.put {_id:$scope.pageId, content:''}
        $scope.content = ''
      else
        console.log doc
        $scope.$apply () ->
          $scope.content = doc.content
          console.log $scope.content
          console.log doc.content

])

.controller('AllCtrl', [
  '$scope'

($scope) ->

  Pouch 'idb://pages', (err, db) ->
    db.allDocs {include_docs: true}, (err, response) ->
      console.log response.rows
      $scope.$apply () ->
          $scope.docs = response.rows
])
