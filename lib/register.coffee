{Config, Database} = require './database'

module.exports =
  activate: ->
    Config.checkAndLoadDefaults()
    Database.ensureActive()
