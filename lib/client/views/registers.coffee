{View} = require 'space-pen'

{Class, Session} = require '../../database'

SessionCellView = require './sub-views/session-register-cell'

module.exports =
  class RegistersView extends View
    @content: ->
      @div =>
        @h1 "Take a Register"
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th "Class"
              for session in Session.all()
                @th session.name

          @tbody =>
            for klass in Class.all()
              @tr =>
                @td klass.name
                for session in Session.all()
                  @td =>
                    @subview 'sessioncell', new SessionCellView(klass, session)
