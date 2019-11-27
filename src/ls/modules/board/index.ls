(->
  ldc.register \board, <[auth]>, ({auth}) ->
    auth.get!then ->
      view = new ldView do
        root: '[ld-scope=board-create]'
        action: click: do
          submit: ({node}) ->
            #if node.classList.contains \disabled => return
            console.log \submit
            ld$.fetch \/d/test/, {method: \POST, body: form.getfd!}, {}
              .then -> console.log \done.
              .catch -> console.log "failed:", it
      form = new ldForm do
        root: '[ld-scope=board-create]'
        submit: view.get(\submit)

  ldc.app \board
)!
