{View} = require 'space-pen'

module.exports =
  class ConfigItemView extends View
    @content: (row) ->
      @div =>
        @label outlet: 'label', row.descriptiveName
        @div class: 'input-control text', =>
          @input outlet: 'input', 'data-id': row.idConfig

    initialize: (row) ->
      if row.type == "text"
        @applyText(row)

    applyText: (row) ->
      @input.attr('value', row.value)
