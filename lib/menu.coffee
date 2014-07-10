Menu = require 'menu'
BrowserWindow = require 'browser-window'

module.exports =
  template: [
    {
      label: 'File',
      submenu: [
        {
          label: 'Toggle DevTools',
          accelerator: 'Alt+Command+I',
          click: ->
            BrowserWindow.getFocusedWindow().toggleDevTools()
        }
      ]
    },
    {
      label: "Classes"
      submenu: [
        {
          label: 'View Class Lists'
          click: ->
            MainView.openView("class-list-view")
        }
      ]
    },
    {
      label: 'Help',
      submenu: [
        {
          label: 'About Registers'
        }
      ]
    }
  ]

  activate: ->
    applicationMenu = Menu.buildFromTemplate @template
    Menu.setApplicationMenu applicationMenu
