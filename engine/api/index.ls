require! <[path fs-extra]>

(engine,io) <- (->module.exports = it) _

api = engine.router.api

asset-path = root: "static/s/asset"
asset-path.board-banner = path.join(asset-path.root, "board", "banner")
asset-path.board-avatar = path.join(asset-path.root, "board", "avatar")
fs-extra.ensure-dir-sync asset-path.board-banner
fs-extra.ensure-dir-sync asset-path.board-avatar

api.post \/test, engine.multi.parser, (req, res, next) ->
  lc = {}
  banner = (req.{}files.[]banner.0 or {}).path or null
  avatar = (req.{}files.[]avatar.0 or {}).path or null
  detail = req.body{starttime, endtime}
  io.query """
  insert into board (title, slug, description, owner, detail, state)
  values ($1,$2,$3,$4,$5,$6) returning key
  """, <[title slug description]>.map(-> req.body[it]) ++ [1, detail, 'pending']
    .then (r={}) ->
      lc.key = (r.[]rows.0 or {}).key
      if !lc.key => throw new Error()
      # TODO deal with image
      if banner => new Promise (res, rej) ->
        fs-extra.copy banner, path.join(asset-path.board-banner, "#{lc.key}.png"), (e) -> res!
      else Promise.resolve!
    .then ->
      if avatar => new Promise (res, rej) ->
        fs-extra.copy avatar, path.join(asset-path.board-avatar, "#{lc.key}.png"), (e) -> res!
      else Promise.resolve!
    .then -> res.send!


  res.send!
