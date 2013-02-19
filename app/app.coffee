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

    .when('/e/:id', {templateUrl: '/partials/edit.html'})
    .when('/p/:id', {templateUrl: '/partials/page.html'})
    .when('/all',   {templateUrl: '/partials/all.html'})

    # Catch all
    .otherwise({redirectTo: '/p/home'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])
