{View} = require 'space-pen'
{Database, Register} = require '../database'

AlertView = require './partials/alert-view'

rimraf = require 'rimraf'

module.exports =
  class CleanUpView extends View
    @content: ->
      @div class: 'cleanup', =>
        @h1 "Clean Up"
        @p "The following old registers are present in the database:"
        @ul id: 'cleanup-list', outlet: 'cleanupList'
        @p =>
          @button outlet: 'cleanUp', "Clean Up All"

    applyData: ->
      Register.forCleanUp().forEach (folder) ->
        $('#cleanup-list').append("<li>" + folder + "</li>")

      @cleanUp.on 'click', ->
        $('.main-body').prepend new AlertView("Are you sure?", "This will remove all registers other than todays. Please make sure than you have imported them into your MIS", ->
          Register.forCleanUp().forEach (folder) ->
            rimraf.sync(Database.path() + "register/" + folder, (e) ->
              alert("Deletion Error: " + e)
            )
          $('.main-body').prepend new AlertView("Done!", "Old Registers Removed")
        )
