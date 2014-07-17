{View} = require 'space-pen'

{ClassList, Config, PupilList, Register} = require '../../database'

module.exports =
  class DinnerYesNoPDF extends View
    @content: ->
      @div id: 'pdf', outlet: 'main', =>
        @h1 outlet: 'title', " Dinner Register"
        @h2 outlet: 'date'
        @table id: 'table', =>
          @tr =>
            @th "Class"
            @th "Dinners"

    applyData: ->
      @title.prepend Config.value("school-name")
      @addDate()
      @addClasses()

    addDate: ->
      date = new Date
      @date.html date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear()

    addClasses: ->
      ClassList.all().forEach (klass) ->
        if Register.beenDone(klass, Config.value("dinner-session"))
          $('#table').append("<tr>")
          $('#table').append "<td>" + klass + "</td>"

          dinnerCount = 0
          register = Register.forDate(klass, new Date, Config.value("dinner-session"))
          Object.keys(register).forEach (key) ->
            if register[key]['dinner']
              dinnerCount += 1

          $('#table').append("<td>" + dinnerCount + "</td>")

          $('#table').append("</tr>")
