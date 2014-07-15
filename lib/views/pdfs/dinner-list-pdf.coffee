{View} = require 'space-pen'

{ClassList, Config, PupilList, Register} = require '../../database'

module.exports =
  class DinnerListPDF extends View
    @content: ->
      @div id: 'pdf', outlet: 'main', =>
        @h1 outlet: 'title', " Dinner Register"

    applyData: ->
      @title.prepend Config.value("school-name")
      @addDate()
      @addClasses()

    addDate: ->
      date = new Date
      $('#pdf').append "<h2>" + date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear() + "</h2>"

    addClasses: ->
      ClassList.all().forEach (klass) ->
        if Register.beenDone(klass, Config.value("dinner-session"))
          $('#pdf').append "<h3>" + klass + "</h3>"
          $('#pdf').append "<table id=\"" + klass + "-list\"></table>"
          table = $('#' + klass + '-list')
          table.append("<tr><th>Pupil</th><th>Choice</th></tr>")
          register = Register.forDate(klass, new Date, Config.value("dinner-session"))
          Object.keys(register).forEach (key) ->
            if register[key]['dinner']
              pupil = PupilList.findByUPN(klass, key)
              table.append("<tr><td>" + pupil.firstName + " " + pupil.lastName + "</td><td>" + register[key]['dinner'] + "</td></tr>")
