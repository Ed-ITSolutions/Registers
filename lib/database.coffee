CSON = require 'season'
fs = require 'fs'
rimraf = require 'rimraf'
Cache = require './cache'

exports = exports ? this
exports.Database =
  cache: {}

  path: ->
    CSON.readFileSync(__dirname + '/../data-path.cson')['path']

  clearForImport: ->
    rimraf.sync(@path() + "pupils/", (e) ->
      alert("Deletion Error: " + e)
    )
    if(fs.existsSync(@path() + "class-list.cson"))
      fs.unlinkSync(@path() + "class-list.cson")

  loadCache: ->
    @cache = Cache
    @cache.cacheFolder(@path())

exports.ClassList = require './models/class-list'
exports.Config = require './models/config'
exports.Menu = require './models/menu'
exports.PupilList = require './models/pupil-list'
exports.Register = require './models/register'
exports.Session = require './models/session'
