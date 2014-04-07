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

      login: (symbol) -> …

      quit: -> …

      say: (symbol) ->
        …

      remember: (symbol) ->
       …

      normalize:(symbol) ->
        …

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