{View} = require 'space-pen'

module.exports =
  class SessionItemView extends View
    @content: (session) ->
      @tr =>
        @td =>
          @input type: 'text', value: session.name, placeholder: 'Session Name'
        @td =>
          @input type: 'text', value: session.startTime, placeholder: 'HH:MM:SS'
