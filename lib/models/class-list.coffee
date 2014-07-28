CSON = require 'season'
fs = require 'fs'

{Database} = require '../database'

module.exports =
  all: ->
    require('ipc').sendSync('get-from-cache', 'class-list')["classes"]

  hasPupils: (klass) ->
    fs.existsSync @pupilFileName(klass)

  pupilFileName: (klass) ->
    file = klass.toLowerCase().replace(" ", "-") + ".cson"
    Database.path() + "/pupils/" + file

  pdfFileName: (klass) ->
    klass.toLowerCase().replace(" ", "-") + "-register.pdf"

  addClass: (klass) ->
    if fs.existsSync Database.path() + '/class-list.cson'
      data = CSON.readFileSync(Database.path() + '/class-list.cson')
    else
      data = {}
      data["classes"] = []

    unless klass in data["classes"]
      data["classes"].push klass
      CSON.writeFileSync(Database.path() + '/class-list.cson', data)
