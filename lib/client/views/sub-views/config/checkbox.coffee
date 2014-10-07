{View} = require 'space-pen'

{Config} = require '../../../../database'

module.exports =
  class ConfigCheckboxView extends View
    @content: (row) ->
      @div class: 'input-control switch', =>
        @label =>
          @span class: 'choice', row.descriptiveName
          @input type: 'checkbox', 'data-id': row.idConfig, outlet: 'check', change: 'save'
          @span class: 'check'

    initialize: (row) ->
      if row.value == 'true'
        @check.prop 'checked', true

    save: (event, element) ->
      if element.prop 'checked'
        value = "true"
      else
        value = "false"

      Config.update({
        value: value
      }, 'idConfig', element.attr('data-id'))
