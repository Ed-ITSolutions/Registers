{View} = require 'space-pen'

{Config, Session} = require '../../database'

SessionTileView = require './sub-views/session-tile'

AttendanceSummaryView = require './attendance-summary'
DinnersSummaryView = require './dinners-summary'

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


        for session in Session.all()
          @subview 'sessiontile', new SessionTileView(session)

    openAttendanceSummary: (event, element) ->
      $('#mainBody').html(new AttendanceSummaryView)

    openDinnersSummary: (event, element) ->
      $('#mainBody').html(new DinnersSummaryView)
