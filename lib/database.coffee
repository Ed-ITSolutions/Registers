CSON = require 'season'
fs = require 'fs'
rimraf = require 'rimraf'

exports = exports ? this
exports.Database =
  path: ->
    CSON.readFileSync(__dirname + '/../data-path.cson')['path']

  ensureActive: ->

  clearForImport: ->
    rimraf.sync(@path() + "pupils/", (e) ->
      alert("Deletion Error: " + e)
    )
    fs.unlinkSync(@path() + "class-list.cson")


ClassList = require './models/class-list'
Config = require './models/config'
PupilList = require './models/pupil-list'
Register = require './models/register'
Session = require './models/session'

exports.ClassList = ClassList
exports.Config = Config
exports.PupilList = PupilList
exports.Register = Register
exports.Session = Session
