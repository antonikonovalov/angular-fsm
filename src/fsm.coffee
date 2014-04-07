'use strict'

service = angular.module('fsm.service',[])

class FSM
  states: {}

  #  constructor: (@initial) ->
  #    @current = @initial

  setInitialState: (initial) ->
    @initial = initial
    @

  setCurrentState: (current) ->
    @current = current
    @

  reset: () ->
    @current = @initial

  addState: (state,symbol,next,action) ->
    unless @states[state]?
      @states[state] = {}

    @states[state][symbol] =
      next:next
      action:action

    @

  removeState: (state,symbol) ->
    if symbol?
      delete @states[state][symbol]
    else
      delete @states[state]

    @

  normalize:(symbol) -> symbol:symbol

  process: (rawSymbol) ->
    state = @states[@current]
    rawSymbol = @normalize(rawSymbol)

    symbol = rawSymbol.symbol

    console.log "Current State ",@current," got symbol ",symbol

    if not state[symbol] and state['*']
      console.log "Unrecognized symbol ", symbol , ", using *"
      symbol = '*'

    state[symbol].action(rawSymbol) if state[symbol].action?

    if state[symbol].next
      @current = state[symbol].next
    else
      console.log "Don't know how to handle symbol ",rawSymbol.symbol

    @

service.factory 'FSM', [-> FSM]

module = angular.module('fsm',['fsm.service'])

module.provider 'Fsm', [->
    # Private variables
    conf = {}

    # Private constructor

    # Public API for configuration
    @config = (config) ->
      conf = config

    # Method for instantiating
    @$get = [
      'FSM'
      (FSM) ->
        console.log "FSM =>", FSM
        new FSM()
    ]
    @

  ]