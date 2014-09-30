{View} = require 'space-pen'

{DinnerMenuAssignment, DinnerMenu} = require '../../../database'

module.exports =
  class NewDinnerAssignmentView extends View
    @content: ->
      @div class: 'metro window-overlay', id: 'modalContainer', =>
        @div class: 'window flat shadow', =>
          @div class: 'caption', =>
            @button class: 'btn-close', click: 'closeWindow'
            @div class: 'title', 'New Dinner Menu'
          @div class: 'content', =>
            @form =>
              @label 'Date'
              @div class: 'input-control text', =>
                @input type: 'date', id: 'newDate'
              @label 'Menu'
              @div class: 'input-control select', =>
                @select id: 'newMenu', =>
                  for menu in DinnerMenu.all()
                    @option value: menu.idDinnerMenu, menu.name
              @div class: 'form-actions', =>
                @button class: 'primary', click: 'create', 'Create'
                @button click: 'closeWindow', 'Cancel'

    closeWindow: (event, element) ->
      $('#modalContainer').remove()
      return false

    create: (event, element) ->
      DinnerMenuAssignment.insert({
        menuId: $('#newMenu').val(),
        date: $('#newDate').val()
      })
      @closeWindow(event, element)
      return false
