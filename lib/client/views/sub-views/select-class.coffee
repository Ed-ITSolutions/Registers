{View} = require 'space-pen'

{Class} = require '../../../database'

module.exports =
  class SelectClassView extends View
    @content: ->
      @div class: 'metro window-overlay', id: 'modalContainer', =>
        @div class: 'window flat shadow', =>
          @div class: 'caption', =>
            @button class: 'btn-close', click: 'closeWindow'
            @div class: 'title', 'Select a Class'
          @div class: 'content', =>
            @ul =>
              for klass in Class.all()
                @li =>
                  @a href: klass.idClass, click: 'setClass', klass.name

    closeWindow: (event, element) ->
      $('#modalContainer').remove()
      return false

    setClass: (event, element) ->
      localStorage.setItem 'class', element.attr('href')
      @closeWindow(event, element)
      return false
