CSON = require 'season'
fs = require 'fs'
{Database} = require '../database'
Session = require './session'

module.exports =
  keys: [
    ["school-name", "Set Name in Config"],
    ["use-attendance", true],
    ["use-dinner", true],
    ["data-export-directory", "db/export/"],
    ["dinner-style", "choice"],
    ["dinner-session", "Morning"]
  ]

  options: {
    "dinner-style": [
      "choice",
      "yes/no"
    ],
    "dinner-session": "Session.dinnerChoiceList()"
  }

  checkAndLoadDefaults: ->
    if fs.existsSync Database.path() + '/config.cson'
      data = CSON.readFileSync(Database.path() + '/config.cson')
    else
      data = {}

    @keys.forEach (key) ->
      unless key[0] in Object.keys(data)
        data[key[0]] = key[1]

    CSON.writeFileSync(Database.path() + '/config.cson', data)

    Session.loadDefaults()

  all: ->
    require('ipc').sendSync('get-from-cache', 'config')

  value: (key) ->
    @all()[key]

  humanizeKey: (key) ->
    key.split("-").map((item) ->
      item.charAt(0).toUpperCase() + item.slice 1
    ).join " "

  toKey: (string) ->
    string.toLowerCase().split(" ").join("-")

  set: (key, value) ->
    data = CSON.readFileSync(Database.path() + '/config.cson')
    data[key] = value
    CSON.writeFileSync(Database.path() + '/config.cson', data)

  toggle: (key) ->
    data = CSON.readFileSync(Database.path() + '/config.cson')
    data[key] = !(data[key])
    CSON.writeFileSync(Database.path() + '/config.cson', data)
