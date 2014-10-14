{View} = require 'space-pen'

{DinnerChoice, DinnerMenu} = require '../../../database'

NewDinnerMenuView = require '../new/dinner-menu'
DinnerChoicesView = require './choices'

module.exports =
  class MenuListView extends View
    @content: ->
      @div =>
        @h1 'Dinner Menus'
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th 'Name'
              @th 'Choices'
          @tbody =>
            for menu in DinnerMenu.all()
              @tr =>
                @td =>
                  @a href: '#', click: 'openMenu', 'data-menu': menu.idDinnerMenu, menu.name
                @td DinnerChoice.where('menuId', menu.idDinnerMenu).length
        @button click: 'addNew', 'Add New'

    addNew: (event, element) ->
      $('body').append(new NewDinnerMenuView)

    openMenu: (event, element) ->
      menu = DinnerMenu.find('idDinnerMenu', element.attr('data-menu'))
      $('#mainBody').html(new DinnerChoicesView(menu))
      return false
