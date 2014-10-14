{View} = require 'space-pen'

{Config, Session} = require '../../../../database'

module.exports =
  class ConfigSessionsDropdownView extends View
    @content: (row) ->
      @div =>
        @label outlet: 'label', row.descriptiveName
        @div class: 'input-control select', =>
          @select outlet: 'select', 'data-id': row.idConfig, change: 'save', =>
            for session in Session.all()
              @option value: session.idSessions, session.name

    initialize: (row) ->
      @select.val(row.value)

    save: (event, element) ->
      Config.update({
        value: element.val()
      }, 'idConfig', element.attr('data-id'))
