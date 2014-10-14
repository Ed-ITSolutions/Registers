{View} = require 'space-pen'

{Config, Register, Session} = require '../../database'

SelectClassView = require './sub-views/select-class'

AttendanceSummaryView = require './attendance-summary'
DinnersSummaryView = require './dinners-summary'
RegisterView = require './register'

module.exports =
  class HomeView extends View
    @content: ->
      @div =>
        @h1 "Registers"
        @h2 Config.setting('name')

        @div class: 'tile bg-darkRed', click: 'openAttendanceSummary', =>
          @div class: 'tile-content icon', =>
            @i class: 'icon-diary'
          @div class: 'brand bg-black', =>
            @span class: 'name', 'Attendance Summary'

        @div class: 'tile bg-darkRed', click: 'openDinnersSummary', =>
          @div class: 'tile-content icon', =>
            @i class: 'icon-file-pdf'
          @div class: 'brand bg-black', =>
            @span class: 'name', 'Dinners Summary'


        if localStorage.getItem('class')
          @div class: 'tile bg-green double', click: 'takeRegister', =>
            @div class: 'tile-content icon', =>
              @i class: 'icon-clipboard-2'
            @div class: 'brand bg-black', =>
              @span class: 'name', 'Take Register'
        else
          @div class: 'tile bg-green double', click: 'selectClass', =>
            @div class: 'tile-content icon', =>
              @i class: 'icon-clipboard-2'
            @div class: 'brand bg-black', =>
              @span class: 'name', 'Select a Class'

    openAttendanceSummary: (event, element) ->
      $('#mainBody').html(new AttendanceSummaryView)

    openDinnersSummary: (event, element) ->
      $('#mainBody').html(new DinnersSummaryView)

    selectClass: (event, element) ->
      $('#mainBody').append(new SelectClassView)

    takeRegister: (event, element) ->
      register = Register.findOrCreate(localStorage.getItem('class'), Session.current().idSessions)
      view = new RegisterView(register)
      $('#mainBody').html(view)
      view.loadData()

      return false
