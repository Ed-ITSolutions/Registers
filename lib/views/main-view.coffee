{View} = require 'space-pen'

module.exports =
  class MainView extends View
    @content: ->
      @div class: 'register', =>
        @div class: 'sidebar', =>
          @object data: "assets/svgs/logo.svg", type: "image/svg+xml", =>
            @h1 "Register"
          @ul class: 'nav', =>
            @li class: 'active', =>
              @a href: 'home-view', "Menu"
            @li class: 'register-link', =>
              @a href: 'register-gateway-view', "Take Register"
            @li =>
              @a href: 'admin-office-view', "Admin Office"
            @li =>
              @a href: 'config-view', "Configuration"
            @li =>
              @a href: 'data-ie-view', "Import/Export Data"
        @div class: 'main-body', outlet: 'body'

    initialize: ->
      $(document).ready ->
        $('.nav a').on 'click', ->
          view = require "./" + $(this).attr('href')
          instanceView = new view
          $('.main-body').html(instanceView)
          instanceView.applyData()
          $(this).parent('li').parent('ul').children('li.active').removeClass('active')
          $(this).parent('li').addClass('active')

          return false


    setBodyView: (view) ->
      @body.html(view)
