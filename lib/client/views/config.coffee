{View} = require 'space-pen'

{Config, Session} = require '../../database'

ConfigTextView = require './sub-views/config/text'
ConfigCheckboxView = require './sub-views/config/checkbox'
ConfigSessionsDropdownView = require './sub-views/config/sessions-dropdown'
SessionItemView = require './sub-views/session-item'

module.exports =
  class ConfigView extends View
    @content: ->
      @div =>
        @h1 "Configuration"
        @form =>
          @fieldset id: 'config-menu', outlet: 'configMenu', =>
            for setting in Config.all()
              if setting.type == 'text'
                @subview 'configitemview', new ConfigTextView(setting)
              else if setting.type == 'checkbox'
                @subview 'configitemview', new ConfigCheckboxView(setting)
              else if setting.type == 'sessionsDropdown'
                @subview 'configitemview', new ConfigSessionsDropdownView(setting)
        @h2 "Sessions"
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th "Session Name"
              @th "Start Time"
          @tbody =>
            for session in Session.all()
              @tr =>
                @td =>
                  @input type: 'text', value: session.name, placeholder: 'Session Name'
                @td =>
                  @input type: 'text', value: session.startTime, placeholder: 'HH:MM:SS'
