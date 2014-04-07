'use strict'

app = angular.module('chatBotApp',['fsm'])

app.config(['FsmProvider',(FsmProvider)->
  FsmProvider.config test:"test"
])