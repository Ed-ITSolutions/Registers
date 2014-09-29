{View} = require 'space-pen'

{DinnerMenu} = require '../../../database'

module.exports =
  class NewDinnerMenuView extends View
    @content: ->
      @div class: 'metro window-overlay', id: 'modalContainer', =>
        @div class: 'window flat shadow', =>
          @div class: 'caption', =>
            @button class: 'btn-close', click: 'closeWindow'
            @div class: 'title', 'New Dinner Menu'
          @div class: 'content', =>
            @form =>
              @label 'Name'
              @div class: 'input-control text', =>
                @input type: 'text', id: 'newName'
              @div class: 'form-actions', =>
                @button class: 'primary', click: 'create', 'Create'
                @button click: 'closeWindow', 'Cancel'

    closeWindow: (event, element) ->
      $('#modalContainer').remove()
      return false

    create: (event, element) ->
      DinnerMenu.insert({
        name: $('#newName').val()
      })
      closeWindow(event, element)
      return false
