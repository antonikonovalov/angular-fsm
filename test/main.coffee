'use strict'

angular.module('chatBotApp')
  .controller 'MainCtrl', [ '$scope',($scope) ->
      $scope.title = "Hello FSM, I am bot."
  ]