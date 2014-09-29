{View} = require 'space-pen'

{Session, Register} = require '../../../database'

module.exports =
  class SessionTileView extends View
    @content: (session) ->
      @div class: 'tile double bg-lime', click: 'openRegister', 'data-session': session.idSessions, =>
        @div class: 'tile-content icon', =>
          @i class: 'icon-diary'
        @div class: 'brand bg-black', =>
          @span class: 'name', session.name
          if session.idSessions == Session.current().idSessions
            @div class: 'badge bg-green', outlet: 'badge', =>
              @i class: 'icon-unlocked'
          else
            @div class: 'badge bg-red', outlet: 'badge', =>
              @i class: 'icon-locked'

    openRegister: (event, element) ->
      session = Session.find('idSessions', $(this).attr('data-session'))

      if session.idSessions == Session.current().idSessions

      else
        alert('You can\'t do the ' + session.name + ' register yet')
