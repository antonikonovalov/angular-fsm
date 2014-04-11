'use strict'

app = angular.module('chatBotApp',['fsm'])

app.config(['FsmProvider',(FsmProvider)->
  FsmProvider.config(
    initial:'init'
    debug: true
    actions:
      introduce: ->
        @log "Please introduce yourself first!"
        @

      login: (symbol) ->
        @log "Welcome,", symbol.data;
        @login =  symbol.data;

        unless @session
          @session = {}

        unless @session[@login]
          @session[@login] = []

        @

      quit: ->
        @log "Bye bye!"

        @

      say: (symbol) ->
        index = parseInt(symbol.data)
        if @session[@login][index]
          @log @session[@login][index]
        else
          @log "No record"

        @

      remember: (symbol) ->
        @session[@login].push(symbol.raw)

        @

      normalize:(symbol) ->
        return unless symbol
        obj = {}
        match = symbol.match(/^(\S+)(.*)$/)
        if match.length > 1
          obj =
            symbol: match[1]
            data: match[2]
            raw: symbol
        else
          obj =
            symbol: "*"
            data: symbol
            raw: symbol

    map:
      init:
        "*":
          next:"init"
          action:"introduce"
        login:
          next:"session"
          action: "login"
        exit:
          next:"init"
          action: "quit"


      session:
        "*":
          next:"session"
        exit:
          next:"init"
        say:
          next:"session"
          action: "say"
        memorize:
          next:"store"

      store:
        "*":
          next:"store"
          action: "remember"
        exit:
          next:"session"
  )
])
