app = require 'app'
BrowserWindow = require 'browser-window'
register = require './register'
menu = require './menu'

window = null

app.on 'window-all-closed', ->
  app.quit();

app.on 'ready', ->
  window = new BrowserWindow {width: 800, height: 600}
  window.loadUrl 'file://' + __dirname + '/../index.html'

  register.activate()
  menu.activate()

  window.on 'closed', ->
    window = null

    if (process.platform != 'darwin')
      app.quit();
