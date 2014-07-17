{View} = require 'space-pen'

PrintDinnerYesNo = require '../../tasks/print-dinner-yes-no'

module.exports =
  class DinnerChoiceView extends View
    @content: ->
      @div class: 'dinner-yes-no', =>
        @h2 "Dinner Choices"
        @p =>
          @button outlet: 'dinners', "Print Dinner Choice List"
        @div class:'pdf'

    initialize: ->
      @dinners.on 'click', ->
        PrintDinnerYesNo.run()
