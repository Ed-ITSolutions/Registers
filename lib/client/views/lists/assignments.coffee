{View} = require 'space-pen'

{DinnerMenuAssignment, DinnerMenu} = require '../../../database'

NewDinnerAssignmentView = require '../new/dinner-assignment'

module.exports =
  class AssignmentsView extends View
    @content: ->
      @div =>
        @h1 'Dinner Menu Assignments'
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th 'Menu'
              @th 'Date'
          @tbody =>
            for assignment in DinnerMenuAssignment.fromToday()
              @tr =>
                @td DinnerMenu.find('idDinnerMenu', assignment.menuId).name
                @td DinnerMenuAssignment.displayDate assignment.date
        @button click: 'addNew', 'Add New'

    addNew: (event, element) ->
      $('body').append(new NewDinnerAssignmentView)
