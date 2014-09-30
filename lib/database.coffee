fs = require 'fs'
ini = require 'ini'
mysql = require 'mysql'

exports = exports ? this

exports.Database =
  loadConnection: ->
    iniDetails = ini.parse(fs.readFileSync('./connect.ini', 'utf-8'))

    details = {
      host: iniDetails['MySQLConnection']['host'],
      user: iniDetails['MySQLConnection']['user'],
      password: iniDetails['MySQLConnection']['password']
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
