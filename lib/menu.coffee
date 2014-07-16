Menu = require 'menu'
BrowserWindow = require 'browser-window'
app = require 'app'

module.exports =
  templateDarwin: [
    {
      label: 'File',
      submenu: [
        {
          label: 'Configuration',
          accelerator: 'Command+,'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'config-view')
        },
        {
          type: 'separator'
        },
        {
          label: 'Toggle DevTools',
          accelerator: 'Alt+Command+I',
          click: ->
            BrowserWindow.getFocusedWindow().toggleDevTools()
        },
        {
          label: 'Reload Application',
          accelerator: 'Alt+Command+R',
          click: ->
            BrowserWindow.getFocusedWindow().restart()
        },
        {
          type: 'separator'
        },
        {
          label: 'Quit'
          accelerator: "Command+Q"
          click: ->
            app.quit()
        }
      ]
    },
    {
      label: 'Register'
      submenu: [
        {
          label: "Take Register"
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'register-gateway-view')
        }
      ]
    },
    {
      label: "Data"
      submenu: [
        {
          label: 'Import/Export'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'data-ie-view')
        },
        {
          label: 'Class List'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'class-list-view')
        }
      ]
    },
    {
      label: 'Help',
      submenu: [
        {
          label: 'About Registers'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'about-view')
        }
      ]
    }
  ]

  templateWin32: [
    {
      label: 'File',
      submenu: [
        {
          label: 'Configuration',
          accelerator: 'Alt+,'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'config-view')
        },
        {
          type: 'separator'
        },
        {
          label: 'Toggle DevTools',
          accelerator: 'Alt+Shift+I',
          click: ->
            BrowserWindow.getFocusedWindow().toggleDevTools()
        },
        {
          label: 'Reload Application',
          accelerator: 'Alt+Shift+R',
          click: ->
            BrowserWindow.getFocusedWindow().restart()
        },
        {
          type: 'separator'
        },
        {
          label: 'Quit'
          accelerator: "Alt+Q"
          click: ->
            app.quit()
        }
      ]
    },
    {
      label: 'Register'
      submenu: [
        {
          label: "Take Register"
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'register-gateway-view')
        }
      ]
    },
    {
      label: "Data"
      submenu: [
        {
          label: 'Import/Export'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'data-ie-view')
        },
        {
          label: 'Class List'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'class-list-view')
        }
      ]
    },
    {
      label: 'Help',
      submenu: [
        {
          label: 'About Registers'
          click: ->
            BrowserWindow.getFocusedWindow().send('menu', 'about-view')
        }
      ]
    }
  ]

  activate: ->
    if process.platform == 'darwin'
      applicationMenu = Menu.buildFromTemplate @templateDarwin
    else
      applicationMenu = Menu.buildFromTemplate @templateWin32

    Menu.setApplicationMenu applicationMenu
