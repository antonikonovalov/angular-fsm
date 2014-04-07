# Use
index.html

```
<script src="bower_components/angular-fsm/angular-fsm.min.js"></script>
```

app.js/coffee

```
app.config(['FsmProvider',(FsmProvider)->
  FsmProvider.config(
    initial:'init'
    actions:
      introduce: ->
        console.debug "Please introduce yourself first!"
        @

      login: (symbol) ->
        console.debug "Welcome,", symbol.data;
        @login =  symbol.data;

        unless @session
          @session = {}

        unless @session[@login]
          @session[@login] = []

        @

      quit: ->
        console.debug "Bye bye!"

        @

      say: (symbol) ->
        index = parseInt(symbol.data)
        if @session[@login][index]
          console.debug @session[@login][index]
        else
          console.debug "No record"

        @

      remember: (symbol) ->
        @session[@login].push(symbol.raw)

        @

      normalize:(symbol) ->
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
```

Ands run when need

```
…
    Fsm.process(rawSymbol)
…
```