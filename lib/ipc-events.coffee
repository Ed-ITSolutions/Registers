ipc = require 'ipc'

module.exports =
  bindEvents: (window, dbConn) ->
    ipc.on('open-dev-tools', (event, object) ->
      window.toggleDevTools()
    )

    ipc.on('run-query', (event, query) ->
      dbConn.query(query, (err, rows) ->
        event.returnValue = rows
      )
    )
