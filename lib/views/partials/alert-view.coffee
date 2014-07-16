{View} = require 'space-pen'
_ = require 'underscore'

module.exports =
  class AlertView extends View
    @content: (title, message) ->
      @div class: 'alert', =>
        @h3 outlet: 'title', title
        @p outlet: 'message', message
        @p outlet: 'buttonGroup', =>
          @button outlet: 'close', "Ok"

    initialize: (title, message, confirm = null) ->
      @close.on 'click', ->
        $('.alert').remove()

      if _.isFunction(confirm)
        @close.html "Cancel"
        @buttonGroup.prepend "<button id=\"confirm\">Ok</button>"

        @buttonGroup.children('#confirm').on 'click', ->
          confirm()
          $('.alert').remove()
