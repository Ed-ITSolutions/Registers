{View} = require 'space-pen'

{Class, Config, Pupil, Session} = require '../../../database'

module.exports =
  class PaperRegisters extends View
    @content: ->
      @div class:'pdf', =>
        for klass in Class.all()
          @h1 Config.setting('name')
          @h2 klass.name
          @table style: 'page-break-after:always;', =>
            @tr =>
              @th 'Name'
              @th 'Present'
            for pupil in Pupil.where('classId', klass.idClass)
              @tr =>
                @td pupil.firstName + ' ' + pupil.lastName
                @td '[]'
