'use strict'

service = angular.module('fsm.service',[])

class FSMBase

  states: {}

  log: () -> @log "FSM: ",arguments if @debug

  constructor: (@initial,@debug=false) ->
    @current = @initial
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

    @log "Current State ",@current," got symbol ",symbol

    if not state?[symbol]? and state['*']
      @log "Unrecognized symbol ", symbol , ", using *"
      symbol = '*'

    @[state[symbol].action](rawSymbol) if @[state[symbol].action]?

    if state[symbol].next
      @current = state[symbol].next
    else
      @log "Don't know how to handle symbol ",rawSymbol.symbol

    @

service.factory 'fsm.service.Base', [-> FSMBase]

service.factory 'fsm.service.Constructor', ['fsm.service.Base',(FSMBase) ->
    {
      build: (config) ->
        class FSM extends FSMBase
          constructor: (@initial,@states,@debug=false) ->
            super(@initial,@debug)

        for fnName, cb of config.actions
          FSM::[fnName] = cb

        # todo: if debug show table states in console
        new FSM config.initial, config.map, config.debug
    }
  ]

module = angular.module('fsm',['fsm.service'])

module.provider 'Fsm', [->
    # Private variables
    conf = {}

    # Public API for configuration
    @config = (config) ->
      conf = config

    # Method for instantiating
    @$get = ['fsm.service.Constructor',(FSMConstructor) -> FSMConstructor.build(conf)]

    @

  ]