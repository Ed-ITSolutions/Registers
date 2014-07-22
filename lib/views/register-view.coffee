{View} = require 'space-pen'
{PupilList, Register, Config, Menu} = require '../database'
AlertView = require './partials/alert-view'
MenuEntry = require './partials/menu-entry'

RegisterLine = require './items/register-line'

module.exports =
  class RegisterView extends View
    @content: ->
      @div class: 'register', =>
        @h1 "Register", outlet: 'title'
        @h2 outlet: "date"
        @p outlet: 'message'
        @div outlet: 'menuDiv', =>
          @ul outlet: 'menuUl', id: 'menu'
        @input type: 'hidden', outlet: 'className', id: 'class-name'
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
        $('.main-body').prepend new AlertView("Register Saved", "Your Register has been saved!")

    applyData: (klass) ->
      date = new Date()
      @date.html(date.toDateString())

      @title.append(" " + klass)

      @className.attr("value", klass)

      @date.append(" " + Register.currentSession())

      unless Config.all()['use-dinner']
        @dinnerChoice.html(" ")

      if Config.value("dinner-session") == Register.currentSession()
        @loadMenu()
      else
        @menuDiv.css("display", "none")

      PupilList.forClass(klass).forEach (pupil) ->
        $('.pupils').append(new RegisterLine(pupil, klass, Register.currentSession()))

      @applyKeyBindings()

      if Register.beenDone(klass)
        @message.html("This register has already been submitted")
        $('.pupils input').prop 'disabled', true
        $('input[type=submit]').prop 'disabled', true


    applyKeyBindings: ->
      current = 0
      $(document).bind('keydown', '/', ->
        $(window).scrollTop(20 * current)
        unless current == 0
          $('.pupils input[name=Present]')[current - 1].classList.remove('last-done')

        $('.pupils input[name=Present]')[current].checked = true
        $('.pupils input[name=Present]')[current].dataset.value = "on"
        $('.pupils input[name=Present]')[current].classList.add('last-done')
        current += 1
      )

      $(document).bind('keydown', '\\', ->
        $(window).scrollTop(20 * current)
        unless current == 0
          $('.pupils input[name=Present]')[current - 1].classList.remove('last-done')

        $('.pupils input[name=Present]')[current].classList.add('last-done')
        current += 1
      )

    loadMenu: ->
      items = Menu.itemsFor(new Date)
      key = 1
      items.forEach (item) ->
        view = new MenuEntry(key, item)
        $('#menu').append(view)
        view.applyBindings()

        key += 1
