{Config, Database} = require './database'
ipc = require 'ipc'

module.exports =
  activate: ->
    Config.checkAndLoadDefaults()
    Database.loadCache()

    @bindIPCEvents()

  bindIPCEvents: ->
    ipc.on('get-from-cache', (event, object) ->
      event.returnValue = Database.cache.objects[object]
    )
