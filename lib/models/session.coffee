{Database} = require '../database'
CSON = require 'season'
fs = require 'fs'

module.exports =
  loadDefaults: ->
    unless fs.existsSync Database.path() + '/sessions.cson'
      data = {
        'Morning': "00:00",
        'Afternoon': '12:00'
      }
      CSON.writeFileSync(Database.path() + '/sessions.cson', data)

  all: ->
    CSON.readFileSync(Database.path() + '/sessions.cson')

  currentSession: ->
    date = new Date
    currentHours = ("0" + date.getHours()).slice(-2)
    currentMinutes = ("0" + date.getMinutes()).slice(-2)

    sessions = @all()
    sessionName = ""
    Object.keys(sessions).forEach (key) ->
      hour = sessions[key].split(":")[0]
      minutes = sessions[key].split(":")[1]

      if currentHours >= hour & currentMinutes >= minutes
        sessionName = key

    return sessionName

  updateName: (key, name) ->
    data = @all()

    data[name] = data[key]
    delete data[key]

    CSON.writeFileSync(Database.path() + '/sessions.cson', data)

  updateTime: (key, time) ->
    data = @all()

    data[key] = time

    CSON.writeFileSync(Database.path() + '/sessions.cson', data)

  remove: (key) ->
    data = @all()

    delete data[key]

    CSON.writeFileSync(Database.path() + '/sessions.cson', data)
