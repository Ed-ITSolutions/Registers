app = require 'app'
BrowserWindow = require 'browser-window'

IPCEvents = require './ipc-events'

{Database} = require './database'

window = null

app.on 'window-all-closed', ->
  app.quit()

app.on 'ready', ->
  window = new BrowserWindow {width:800, height:600}
  window.loadUrl 'file://' + __dirname + '/../assets/html/app.html'

  dbConn = Database.loadConnection()
  dbConn.connect()

  IPCEvents.bindEvents(window, dbConn)

  window.on 'closed', ->
    window = null

    app.quit()
