{View} = require 'space-pen'

{DinnerChoice} = require '../../../database'

module.exports =
  class NewDinnerChoiceView extends View
    @content: (menuId) ->
      @div class: 'metro window-overlay', id: 'modalContainer', =>
        @div class: 'window flat shadow', =>
          @div class: 'caption', =>
            @button class: 'btn-close', click: 'closeWindow'
            @div class: 'title', 'New Dinner Choice'
          @div class: 'content', =>
            @form =>
              @label 'Name'
              @div class: 'input-control text', =>
                @input type: 'text', id: 'newName'
                @input type: 'hidden', id: 'menuId', value: menuId
              @div class: 'form-actions', =>
                @button class: 'primary', click: 'create', 'Create'
                @button click: 'closeWindow', 'Cancel'

    closeWindow: (event, element) ->
      $('#modalContainer').remove()
      return false

    create: (event, element) ->
      DinnerChoice.insert({
        name: $('#newName').val(),
        menuId: $('#menuId').val()
      })
      @closeWindow(event, element)
      return false
