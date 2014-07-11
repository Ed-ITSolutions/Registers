{View} = require 'space-pen'
{Session} = require '../../database'

module.exports =
  class SessionItemView extends View
    @content: ->
      @li =>
        @input type: 'text', outlet: 'sessionName'
        @input type: 'text', outlet: 'sessionTime'
        @a outlet: 'delete', href: "#", "Delete"

    initialize: (key) ->
      @sessionName.attr 'value', key
      @sessionName.attr 'data-key', key
      @sessionTime.attr 'value', Session.all()[key]
      @sessionTime.attr 'data-key', key

      @sessionName.on 'change', ->
        key = $(this).attr("data-key")
        newKey = $(this).val()
        Session.updateName(key, newKey)
        $(this).attr 'data-key', newKey
        $(this).parent('li').children('input:last').attr 'data-key', newKey

      @sessionTime.on 'change', ->
        Session.updateTime($(this).attr('data-key'), $(this).val())

      @delete.on 'click', ->
        key = $(this).parent('li').children('input:last').attr 'data-key'
        Session.remove(key)
        $(this).parent('li').remove()
        return false
