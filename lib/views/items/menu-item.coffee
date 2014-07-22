{View} = require 'space-pen'

{Menu} = require '../../database'

module.exports =
  class MenuItem extends View
    @content: (key) ->
      @tr =>
        @td =>
          @input type: 'text', value: @item(key)[0], outlet: 'choice'
        @td =>
          @input type: 'date', value: @item(key)[1], outlet: 'date'
        @td =>
          @input type: 'checkbox', outlet: 'default'
        @td =>
          @a href: '#', "Delete", outlet: 'delete'

    @item: (key) ->
      if Menu.data()[key]
        return Menu.data()[key]
      else
        return ["Add New", null, null]

    initialize: (key) ->
      unless key
        key = new Date().getTime() / 1000
      else
        if Menu.data()[key][2]
          @default.prop 'checked', true

      @choice.on 'change', ->
        Menu.setChoice(key, $(this).val())

      @date.on 'change', ->
        Menu.setDate(key, $(this).val())

      @default.on 'change', ->
        Menu.setDefault(key, $(this).prop('checked'))

      @delete.on 'click', ->
        Menu.delete key
        $(this).parent('td').parent('tr').remove()
        return false
