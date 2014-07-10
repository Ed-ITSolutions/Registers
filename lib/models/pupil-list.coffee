CSON = require 'season'
fs = require 'fs'

{Database} = require '../database'

module.exports =
  forClass: (klass) ->
    pupils = CSON.readFileSync(@fileName(klass))[klass]

  fileName: (klass) ->
    file = klass.toLowerCase().replace(" ", "-") + ".cson"
    Database.path() + "/pupils/" + file

  findByUPN: (klass, upn) ->
    pupils = @forClass(klass)
    index = null
    pupils.forEach (pupil) ->
      if pupil.upn == upn
        index = pupils.indexOf pupil
    pupils[index]

  addPupil: (firstName, lastName, upn, klass) ->
    pupil = {}
    pupil['firstName'] = firstName
    pupil['lastName'] = lastName
    pupil['upn'] = upn

    if fs.existsSync @fileName(klass)
      data = CSON.readFileSync(@fileName(klass))
    else
      data = {}
      data[klass] = []

    data[klass].push pupil

    CSON.writeFileSync(@fileName(klass), data)
