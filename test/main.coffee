'use strict'

angular.module('chatBotApp')
  .controller 'MainCtrl', [
    '$scope'
    'Fsm'
    ($scope,Fsm) ->
      $scope.title = "FSM. Commands: *,login,memorize,exit,say,exit"
      $scope.input = ""

      $scope.onSubmit = () ->
        rawSymbol = angular.copy($scope.input)
        Fsm.process(rawSymbol)
        $scope.input = ""
  ]