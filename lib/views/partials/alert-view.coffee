{View} = require 'space-pen'
_ = require 'underscore'

module.exports =
  class AlertView extends View
    @content: ->
      @div class: 'alert', =>
        @h3 outlet: 'title'
        @p outlet: 'message'
        @p outlet: 'buttonGroup', =>
          @button outlet: 'close', "Ok"

    initialize: (title, message, confirm = null) ->
      @title.html title
      @message.html message

      @close.on 'click', ->
        $('.alert').remove()

      if _.isFunction(confirm)
        @close.html "Cancel"
        @buttonGroup.prepend "<button id=\"confirm\">Ok</button>"

        @buttonGroup.children('#confirm').on 'click', ->
          confirm()
          $('.alert').remove()
