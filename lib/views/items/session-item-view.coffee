{View} = require 'space-pen'
{Session} = require '../../database'

module.exports =
  class SessionItemView extends View
    @content: (key) ->
      @li =>
        @input type: 'text', outlet: 'sessionName', value: key, 'data-key': key
        @input type: 'text', outlet: 'sessionTime', value: Session.all()[key], 'data-key': key
        @a outlet: 'delete', href: "#", "Delete"

    initialize: (key) ->
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
