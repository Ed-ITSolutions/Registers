mysql = require 'mysql'

exports = exports ? this

exports.Database =
  loadConnection: ->
    details = {
      host: 'localhost',
      user: 'root',
      password: 'mysql'
    }

    connection = mysql.createConnection(details)

exports.Model = require './database/model'

exports.Class         = require './database/models/class'
exports.Config        = require './database/models/config'
exports.DinnerMenu    = require './database/models/dinner-menu'
exports.DinnerChoice  = require './database/models/dinner-choice'
exports.DinnerMenuAssignment    = require './database/models/dinner-assignment'
exports.Pupil         = require './database/models/pupil'
exports.Register      = require './database/models/register'
exports.RegisterEntry = require './database/models/registerentry'
exports.Session       = require './database/models/session'
