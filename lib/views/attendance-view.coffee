{View} = require 'space-pen'
{Config, Database, PupilList, Register} = require '../database'

module.exports =
  class AttendanceView extends View
    @content: ->
      @div class: 'attendance', =>
        @h1 "Attendance Summary"
        @p outlet: 'message', class: 'message'
        @h3 "Absent Pupils"
        @ul outlet: 'absentChildrenList', id: 'absent-children-list'

    applyData: ->
      unless Register.notDoneYet().length == 0
        @message.html Register.notDoneYet().sort().join(", ") + " have not done thier registers yet."

      @absentChildren()

    absentChildren: ->
      absent = Register.absentChildren()

      Object.keys(absent).forEach (key) ->
        unless absent[key].length == 0
          $('#absent-children-list').append("<li id=\"list-" + key + "\"></li>")
          $('#list-' + key).append("<b>" + key + "</b><ul></ul>")
          absent[key].forEach (upn) ->
            pupil = PupilList.findByUPN(key, upn)
            $('#list-' + key + ' ul').append("<li>" + pupil.firstName + " " + pupil.lastName + "</li>")
