
ld$.find document, "[ld-scope=slider]"
  .map (root) ->
    lrds = new ldSlider root: ld$.find(root, '.ldrs', 0), min: 30, max: 50, step: 0.01

ld$.find document, "[ld-scope=date]"
  .map (root) -> flatpickr ld$.find(root, 'input', 0), {}

ld$.find document, "[ld-scope=richtext]"
  .map (root) ->
    view = new ldView do
      root: root
      action: do
        click: do
          toggle: ->
            view.getAll(\panel).map -> it.classList.add \d-none
            view.getAll(\toggle).map -> it.classList.remove \active
          edit: ->
            view.get(\panel-edit).classList.remove \d-none
            view.get(\edit).classList.add \active
          preview: ->
            view.get(\panel-preview).classList.remove \d-none
            view.get(\preview).classList.add \active
        input: do
          "panel-edit": -> 
            ret = DOMPurify.sanitize(marked(view.get(\panel-edit).value))
            ld$.find(view.get(\panel-preview), '.card-body', 0).innerHTML = ret
      handler:
        panel: ->
ld$.find document, "[ld-scope=select]"
  .map (root) ->
    view = new ldView do
      root: root
      action: do
        input: do
          select: ({node}) ->
            view.get(\input).classList.toggle \d-none, node.value
ld$.find document, "[ld-scope=multiple]"
  .map (root) ->
    view = new ldView do
      root: root
      action: do
        click: do
          choice: ({node}) ->
            node.classList.toggle \active
new Tagify ld$.find(document, '.tagify',0)
