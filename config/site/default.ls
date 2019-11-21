(->
  config = do
    debug: false
    is-production: false
    domain: \battledash.dev
    facebook:
      clientID: \1234
    google:
      clientID: \1234
  if module? => module.exports = config
)!

