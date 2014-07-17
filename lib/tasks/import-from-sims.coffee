{ClassList, Config, Database, PupilList} = require '../database'

remote = require 'remote'
dialog = remote.require 'dialog'

xml2js = require 'xml2js'
fs = require 'fs'


module.exports =
  run: ->
    files = dialog.showOpenDialog({ properties: [ 'openFile' ]})

    parser = new xml2js.Parser()

    Database.clearForImport()

    fs.readFile files[0], (err, data) ->
      parser.parseString data, (err, result) ->
        result['SuperStarReport']['Record'].forEach (record) ->
          PupilList.addPupil(record.ChosenName[0], record.Surname[0], record.UPN[0], record.RegGroup[0])
          ClassList.addClass(record.RegGroup[0])
