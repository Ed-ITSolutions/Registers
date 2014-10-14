{View} = require 'space-pen'
homeView = require './home'

module.exports =
  class MainView extends View
    @content: ->
      @div class: 'metro', =>
        @nav class: 'navigation-bar fixed-top', =>
          @nav class: 'navigation-bar-content', =>
            @a class: 'element', href: 'home', click: 'openView', =>
              @i class: 'icon-list on-left'
              @span "Registers"
            @span class: 'element-divider'
            @ul class: 'element-menu', =>
              @li =>
                @a class: 'dropdown-toggle', href: '#', click: 'toggleDropdown', "File"
                @ul class: 'dropdown-menu', =>
                  @li =>
                    @a href: 'config', click: 'openView', "Config"
                  @li =>
                    @a href: 'import', click: 'openView', "Import"
                  @li =>
                    @a href: '#', click: 'toggleDevTools', "Toggle Dev Tools"
              @li =>
                @a class: 'dropdown-toggle', href: '#', click: 'toggleDropdown', "Pupils"
                @ul class: 'dropdown-menu', =>
                  @li =>
                    @a href: 'lists/class', click: 'openView', "Class List"
              @li =>
                @a class: 'dropdown-toggle', href: '#', click: 'toggleDropdown', 'Dinners'
                @ul class: 'dropdown-menu', =>
                  @li =>
                    @a href: 'lists/menus', click: 'openView', 'Menus'
                  @li =>
                    @a href: 'lists/assignments', click: 'openView', 'Menu Assignments'
              @li =>
                @a href: 'registers', click: 'openView', "Take a Register"
        @div id: 'mainBody', outlet: 'mainBody', =>
          @subview "home", new homeView

    toggleDropdown: (event, element) ->
      if(element.parent('li').children('.dropdown-menu').css('display') == "block")
        element.parent('li').children('.dropdown-menu').css('display', 'none')
      else
        element.parent('li').children('.dropdown-menu').css('display', 'block')

    closeDropdown: (element) ->
      element.parent('li').parent('.dropdown-menu').css('display', 'none')

    toggleDevTools: (event, element) ->
      require('ipc').send('open-dev-tools')
      @closeDropdown(element)

    openView: (event, element) ->
      view = require('./' + element.attr('href'))
      @mainBody.html(new view)
      @closeDropdown(element)
      return false
