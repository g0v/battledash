
ld$.find document, "[ld-scope=image]"
  .map (root) ->
    ldf = new ldFile {root: ld$.find(root,'input',0)}
    ldf.on \load, ->
      url = URL.createObjectURL(it.0.file)
      ld$.find(root, '[ld=preview]', 0).style.backgroundImage = "url(#url)"


ld$.find document, "[ld-scope=slider]"
  .map (root) ->
    ldrs = new ldSlider root: ld$.find(root, '.ldrs', 0), min: 30, max: 50, step: 0.01
    ldrs.input.setAttribute \type, \text


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
            if view.get(\input) => that.classList.toggle \d-none, node.value == \_other
ld$.find document, "[ld-scope=multiple]"
  .map (root) ->
    view = new ldView do
      root: root
      action: do
        click: do
          choice: ({node}) ->
            node.classList.toggle \active
ld$.find document, "[ld-scope=tags]"
  .map (root) ->
    new Tagify ld$.find(root, 'textarea', 0)
