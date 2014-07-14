{View} = require 'space-pen'
{PupilList, Register, Config} = require '../database'

RegisterLine = require './items/register-line'

module.exports =
  class RegisterView extends View
    @content: ->
      @div class: 'register', =>
        @h1 "Register", outlet: 'title'
        @h2 outlet: "date"
        @p outlet: 'message'
        @input type: 'hidden', outlet: 'className', id: 'class-name'
        @form =>
          @table class: 'pupils', =>
            @tr =>
              @th "Name"
              @th " "
              @th "Dinner Choice", outlet: 'dinnerChoice'
          @input type: 'submit', outlet: 'button', value: "Record Register"

    initialize: ->
      @button.on 'click', ->
        $('.pupils input').prop 'disabled', true
        Register.record($('#class-name').attr("value"), $('.pupils input'))
        alert("Register Saved")

    applyData: (klass) ->
      date = new Date()
      @date.html(date.toDateString())

      @title.append(" " + klass)

      @className.attr("value", klass)

      @date.append(" " + Register.currentSession())

      unless Config.all()['use-dinner']
        @dinnerChoice.html(" ")

      PupilList.forClass(klass).forEach (pupil) ->
        $('.pupils').append(new RegisterLine(pupil, klass, Register.currentSession()))

      @applyKeyBindings()

      if Register.beenDone(klass)
        @message.html("This register has already been submitted")
        $('.pupils input').prop 'disabled', true
        $('input[type=submit]').prop 'disabled', true


    applyKeyBindings: ->
      $(document).bind('keydown', '/', ->
        alert("foo")
      )
