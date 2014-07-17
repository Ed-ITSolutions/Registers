{View} = require 'space-pen'

PrintDinnerChoices = require '../../tasks/print-dinner-choices'

module.exports =
  class DinnerChoiceView extends View
    @content: ->
      @div class: 'dinner-choice', =>
        @h2 "Dinner Choices"
        @p =>
          @button outlet: 'dinners', "Print Dinner Choice List"
        @div class:'pdf'

    initialize: ->
      @dinners.on 'click', ->
        PrintDinnerChoices.run()
