{View} = require 'space-pen'
{Config, Database, PupilList, Register} = require '../database'
DinnerChoiceView = require './partials/dinner-choice-view'
DinnerYesNoView = require './partials/dinner-yes-no-view'

module.exports =
  class DinnersView extends View
    @content: ->
      @div class: 'dinners', =>
        @h1 "Dinners"
        @p class: 'message', outlet: 'message'
        @div outlet: 'body'

    applyData: ->
      unless Register.notDoneYet(Config.value("dinner-session")).length == 0
        @message.html Register.notDoneYet(Config.value("dinner-session")).sort().join(", ") + " have not done thier dinner registers yet."

      if Config.value("dinner-style") == "choice"
        @body.html(new DinnerChoiceView)
      else
        @body.html(new DinnerYesNoView)
