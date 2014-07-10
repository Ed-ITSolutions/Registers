{View} = require 'space-pen'
{Config} = require '../../database'

module.exports =
  class ConfigItemView extends View
    @content: ->
      @li =>
        @label outlet: 'label'
        @input outlet: 'input'

    initialize: (key) ->
      @label.html Config.humanizeKey(key)

      value = Config.all()[key]

      if value.constructor == Boolean
        @applyCheckbox(value)
      else
        if key in Object.keys(Config.options)
          @applySelect(key, value)
        else
          @applyText(value)

    applyCheckbox: (value) ->
      @input.attr 'type', 'checkbox'
      @input.attr 'checked', value

      @input.on 'change', ->
        key = Config.toKey($(this).parent('li').children('label').html())
        Config.toggle(key)

    applyText: (value) ->
      @input.attr 'type', 'text'
      @input.attr 'value', value

      @input.on 'change', ->
        key = Config.toKey($(this).parent('li').children('label').html())
        Config.set(key, $(this).val())

    applySelect: (key, value) ->
      @input.remove()

      @label.parent('li').append("<select></select>")

      select = @label.parent('li').children("select")
      Config.options[key].forEach (option) ->
        if value == option
          selected = " SELECTED"
        else
          selected = ""

        select.append("<option" + selected + ">" + option + "</option>")

      select.on 'change', ->
        key = Config.toKey($(this).parent('li').children('label').html())
        Config.set(key, $(this).val())
