{View} = require 'space-pen'

{DinnerChoice} = require '../../../database'

NewDinnerChoiceView = require '../new/dinner-choice'

module.exports =
  class DinnerMenuChoiceList extends View
    @content: (menu) ->
      @div =>
        @h1 menu.name
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th 'Choice'
          @tbody =>
            for choice in DinnerChoice.where('menuId', menu.idDinnerMenu)
              @tr =>
                @td choice.name
        @button click: 'addNew', 'data-menu': menu.idDinnerMenu, 'Add New'

    addNew: (event, element) ->
      $('body').append(new NewDinnerChoiceView(element.attr('data-menu')))
