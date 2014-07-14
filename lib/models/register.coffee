CSON = require 'season'
fs = require 'fs'
{Database} = require '../database'

ClassList = require './class-list'
Session = require './session'

Register =
  record: (klass, inputs) ->
    data = {}

    inputs.each (i) ->
      upn = $(this).attr("id").split("-")[0]
      key = $(this).attr("id").split("-")[1]

      unless data[upn]
        data[upn] = {}

      data[upn][key] = $(this).attr("data-value")

    CSON.writeFileSync(@fileName(klass), data)

  fileName: (klass) ->
    @generateFileName(klass, @currentSession(), @todaysDate())

  generateFileName: (klass, session, fileDate) ->
    file = klass.toLowerCase().replace(" ", "-") + "-" + session + ".cson"
    Database.path() + "/register/" + fileDate + "/" + file

  todaysDate: ->
    date = new Date()
    @fileDate(date)

  fileDate: (date) ->
    date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()

  currentSession: ->
    Session.currentSession()

  beenDone: (klass, session = false) ->
    unless session
      return fs.existsSync @fileName(klass)
    else
      return fs.existsSync @generateFileName(klass, session, @todaysDate())

  forDate: (klass, date, session) ->
    fileName = @generateFileName(klass, session, @fileDate(date))
    CSON.readFileSync(fileName)

  forNow: (klass) ->
    CSON.readFileSync(@fileName(klass))

  notDoneYet: ->
    classes = []
    ClassList.all().forEach (klass) ->
      unless Register.beenDone(klass)
        classes.push(klass)
    return classes

  forCleanUp: ->
    cleanUp = []
    folders = fs.readdirSync(Database.path() + "/register/")
    folders.forEach (folder) ->
      date = new Date
      unless folder == date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()
        cleanUp.push folder
    return cleanUp

  absentChildren: ->
    pupils = {}
    ClassList.all().forEach (klass) ->
      pupils[klass] = []
      if Register.beenDone(klass)
        reg = Register.forNow klass
        Object.keys(reg).forEach (key) ->
          unless reg[key].present == "on"
            pupils[klass].push key

    return pupils

module.exports = Register
