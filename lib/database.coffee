CSON = require 'season'
fs = require 'fs'

exports = exports ? this
exports.Database =
  path: ->
    CSON.readFileSync('data-path.cson')['path']

  ensureActive: ->


ClassList = require './models/class-list'
Config = require './models/config'
PupilList = require './models/pupil-list'
Register = require './models/register'

exports.ClassList = ClassList
exports.Config = Config
exports.PupilList = PupilList
exports.Register = Register
