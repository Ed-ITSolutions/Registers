{View} = require 'space-pen'

{Config} = require '../../../../database'

module.exports =
  class ConfigTextView extends View
    @content: (row) ->
      @div =>
        @label outlet: 'label', row.descriptiveName
        @div class: 'input-control text', =>
          @input outlet: 'input', 'data-id': row.idConfig, value: row.value, change: 'save'

    save: (event, element) ->
      Config.update({
        value: element.val()
      }, 'idConfig', element.attr('data-id'))
