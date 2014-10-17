{View} = require 'space-pen'

{Class, Pupil, Session} = require '../../database'

AttendanceRangeView = require './select/attendance-range'

module.exports =
  class AttendanceSummary extends View
    @content: ->
      @div =>
        @h1 'Attendance Summary'
        @button class: 'image-button primary', click: 'printSummary', =>
          @span "Print Summary"
          @i class: 'icon-file-pdf bg-cobalt'
        for session in Session.all()
          pupils = Session.pupilsInSession(session.idSessions, new Date)
          @h2 session.name
          @h3 pupils['present'] + '/' + pupils['total'] + '/' + pupils['all']
          @div class: 'summary-bar', =>
            @div class: 'bar', =>
              @div class: 'present', style: "width:" + ((pupils['present'] / pupils['all']) * 100) + '%'
              @div class: 'absent', style: "width:" + ((pupils['absent'] / pupils['all']) * 100) + '%'
              @div class: 'missing', style: "width:" + ((pupils['missing'] / pupils['all']) * 100) + '%'
          @h4 'Absent'
          @ul =>
            for pupil in Session.absentPupilsInSession(session.idSessions, new Date)
              @li pupil.firstName + ' ' + pupil.lastName + ' (' + Class.find('idClass', pupil.classId).name + ')'

    printSummary: (event, element) ->
      $('#mainBody').append(new AttendanceRangeView)
