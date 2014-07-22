{View} = require 'space-pen'

module.exports =
  class MenuEntry extends View
    @content: (key, item) ->
      @li id: 'entry', "[" + key + "] " + item[0]

    initialize: (key, item) ->
      @key = key
      @item = item

    applyBindings: ->
      item = @item
      key = @key
      $(document).bind('keydown', "" + key, ->
        $('.last-done').parent('td').parent('tr').children('td:last-of-type').children('input').attr 'value', item[0]
        $('.last-done').parent('td').parent('tr').children('td:last-of-type').children('input').attr 'data-value', item[0]
      )
