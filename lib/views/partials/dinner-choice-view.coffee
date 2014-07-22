{View} = require 'space-pen'
MenuItem = require '../items/menu-item'

{Menu} = require '../../database'

PrintDinnerChoices = require '../../tasks/print-dinner-choices'

module.exports =
  class DinnerChoiceView extends View
    @content: ->
      @div class: 'dinner-choice', =>
        @h2 "Dinner Choices"
        @p =>
          @button outlet: 'dinners', "Print Dinner Choice List"
        @div class:'pdf'
        @h2 "Dinner Menu"
        @table outlet: 'dinnerMenu', class: 'dinner-menu', =>
          @tr =>
            @th "Option"
            @th "Date"
            @th "Default?"
            @th ""

    initialize: ->
      @dinners.on 'click', ->
        PrintDinnerChoices.run()

    applyData: ->
      Object.keys(Menu.data()).forEach (key) ->
        $('.dinner-menu').append(new MenuItem(key))

      $('.dinner-menu').append(new MenuItem())
