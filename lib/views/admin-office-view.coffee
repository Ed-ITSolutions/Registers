{View} = require 'space-pen'
{Config, Database, PupilList, Register} = require '../database'
AlertView = require './partials/alert-view'

rimraf = require 'rimraf'

module.exports =
  class AdminOfficeView extends View
    @content: ->
      @div class: 'admin', =>
        @h1 "Admin Office"
        @h2 "Registers"
        @p class: 'message', outlet: 'message'
        @h3 "Absent Pupils"
        @ul outlet: 'absentChildrenList', id: 'absent-children-list'
        @h3 "Dinners"
        @p outlet: 'dinners'
        @h2 "Cleanup"
        @p "The following old registers are present in the database:"
        @ul id: 'cleanup-list', outlet: 'cleanupList'
        @p =>
          @button outlet: 'cleanUp', "Clean Up All"

    applyData: ->
      unless Register.notDoneYet().length == 0
        @message.html Register.notDoneYet().sort().join(", ") + " have not done thier registers yet."

      @absentChildren()
      @dinnerSheets()

      Register.forCleanUp().forEach (folder) ->
        $('#cleanup-list').append("<li>" + folder + "</li>")

      @cleanUp.on 'click', ->
        $('.main-body').prepend new AlertView("Are you sure?", "This will remove all registers other than todays. Please make sure than you have imported them into your MIS", ->
          Register.forCleanUp().forEach (folder) ->
            rimraf.sync(Database.path() + "register/" + folder, (e) ->
              alert("Deletion Error: " + e)
            )
        )

    absentChildren: ->
      absent = Register.absentChildren()

      Object.keys(absent).forEach (key) ->
        unless absent[key].length == 0
          $('#absent-children-list').append("<li id=\"list-" + key + "\"></li>")
          $('#list-' + key).append("<b>" + key + "</b><ul></ul>")
          absent[key].forEach (upn) ->
            pupil = PupilList.findByUPN(key, upn)
            $('#list-' + key + ' ul').append("<li>" + pupil.firstName + " " + pupil.lastName + "</li>")

    dinnerSheets: ->
      null
