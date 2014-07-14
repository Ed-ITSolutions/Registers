{View} = require 'space-pen'
{Config, Register} = require '../../database'

module.exports =
  class RegisterLineView extends View
    @content: ->
      @tr =>
        @td class: 'name', outlet: 'name'
        @td =>
          @input type: 'checkbox', outlet: 'present', name: 'Present'
        @td =>
          @input type: 'text', outlet: 'dinner', name: 'Dinner'

    initialize: (pupil, klass, session) ->
      @name.html pupil.firstName + " " + pupil.lastName

      @present.attr "id", pupil.upn + "-present"
      @dinner.attr "id", pupil.upn + "-dinner"

      @present.attr "data-value", "off"

      unless Config.all()['use-attendance']
        @present.css("display", "none")

      unless Config.all()['use-dinner']
        @dinner.css("display", "none")

      unless session == Config.value("dinner-session")
        @dinner.css("display", "none")

      if Config.value('dinner-style') == "yes/no"
        @dinner.attr 'type', 'checkbox'

      @dinner.on 'change', ->
        $(this).attr("data-value", $(this).val())

      @present.on 'change', ->
        if $(this).prop 'checked'
          $(this).attr("data-value", "on")
        else
          $(this).attr("data-value", "off")

      if Register.beenDone(klass)
        data = Register.forDate(klass,  new Date(), Register.currentSession())

        @present.attr "data-value", data[pupil.upn]['present']
        if data[pupil.upn]['present'] == 'on'
          @present.prop 'checked', true

        @dinner.attr "data-value", data[pupil.upn]['dinner']
        if Config.value('dinner-style') == "yes/no"
          if data[pupil.upn]['dinner'] == 'on'
            @dinner.prop 'checked', true
        else
          @dinner.attr "value", data[pupil.upn]['dinner']
