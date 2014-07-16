{View} = require 'space-pen'
{Config, Session} = require '../../database'

_ = require 'underscore'

module.exports =
  class ConfigItemView extends View
    @content: (key) ->
      @li =>
        @label outlet: 'label', Config.humanizeKey(key)
        @input outlet: 'input'

    initialize: (key) ->
      value = Config.value(key)

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
      if _.isArray(Config.options[key])
        options = Config.options[key]
      else
        options = eval(Config.options[key])

      options.forEach (option) ->
        if value == option
          selected = " SELECTED"
        else
          selected = ""

        select.append("<option" + selected + ">" + option + "</option>")


      select.on 'change', ->
        key = Config.toKey($(this).parent('li').children('label').html())
        Config.set(key, $(this).val())
