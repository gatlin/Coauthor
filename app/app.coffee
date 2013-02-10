'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
])

App.config([
  '$routeProvider'
  '$locationProvider'

($routeProvider, $locationProvider, config) ->

  $routeProvider

    .when('/new', {templateUrl: '/partials/page.html'})

    # Catch all
    .otherwise({redirectTo: '/new'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])
