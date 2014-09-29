{View} = require 'space-pen'

{Config, Session} = require '../../database'

ConfigItemView = require './sub-views/config-item'
SessionItemView = require './sub-views/session-item'

module.exports =
  class ConfigView extends View
    @content: ->
      @div =>
        @h1 "Configuration"
        @form =>
          @fieldset id: 'config-menu', outlet: 'configMenu', =>
            for setting in Config.all()
              @subview 'configitemview', new ConfigItemView(setting)
        @h2 "Sessions"
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th "Session Name"
              @th "Start Time"
          @tbody =>
            for session in Session.all()
              @subview 'sessionitem', new SessionItemView(session)
