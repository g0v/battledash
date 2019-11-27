(->
  ldc.register \board, <[]>, ->
    view = new ldView do
      root: '[ld-scope=board-create]'
      action: click: do
        submit: ({node}) ->
          if node.classList.contains \disabled => return
          console.log \submit


    form = new ldForm do
      root: '[ld-scope=board-create]'
      submit: view.get(\submit)

  ldc.app \board
)!
