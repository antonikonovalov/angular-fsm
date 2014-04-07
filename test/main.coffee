'use strict'

angular.module('chatBotApp')
  .controller 'MainCtrl', [
    '$scope'
    'Fsm'
    ($scope,Fsm) ->
      console.log "Fsm",Fsm
      $scope.title = "Hello FSM, I am bot. Commands: *,login,memorize,exit,say,exit"
      $scope.input = ""

      $scope.onSubmit = () ->
        rawSymbol = angular.copy($scope.input)
        Fsm.process(rawSymbol)
        $scope.input = ""
  ]