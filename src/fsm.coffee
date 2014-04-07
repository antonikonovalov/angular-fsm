'use strict'

service = angular.module('fsm.service',[])

class FSMBase

  states: {}

  constructor: (@initial) ->
    console.log "FSMBase constructor =>", @initial
    @current = @initial
    console.log "FSMBase finish"
    @

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

    if not state?[symbol]? and state['*']
      console.log "Unrecognized symbol ", symbol , ", using *"
      symbol = '*'

    @[state[symbol].action](rawSymbol) if @[state[symbol].action]?

    if state[symbol].next
      @current = state[symbol].next
    else
      console.log "Don't know how to handle symbol ",rawSymbol.symbol

    @

service.factory 'FSMBase', [-> FSMBase]

service.factory 'ConstructorFSM', ['FSMBase',(FSMBase) ->
    {
      build: (config) ->
        class FSM extends FSMBase
          constructor: (@initial,@states) ->
            super(@initial)

        for fnName, cb of config.actions
          FSM::[fnName] = cb

        new FSM config.initial, config.map
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
    @$get = ['ConstructorFSM',(ConstructorFSM) -> ConstructorFSM.build(conf)]

    @

  ]