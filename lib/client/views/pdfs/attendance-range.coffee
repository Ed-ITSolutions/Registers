{View} = require 'space-pen'

{Class, Config, Session} = require '../../../database'

module.exports =
  class AttendanceRangePDF extends View
    @content: (dates) ->
      klass = 0
      @div class: 'pdf', =>
        @h1 Config.setting('name')
        @h2 'Absent Pupils in Range'
        for date in dates
          for session in Session.all()
            @h3 session.name + ' ' + Session.displayDate(date)
            @ul =>
              for pupil in Session.absentPupilsInSession(session.idSessions, new Date(Date.parse(date)))
                @li pupil.firstName + ' ' + pupil.lastName + ' (' + Class.find('idClass', pupil.classId).name + ')'
