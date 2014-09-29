{View} = require 'space-pen'

{DinnerAssignments, DinnerMenu} = require '../../../database'

module.exports =
  class AssignmentsView extends View
    @content: ->
      @div =>
        @h1 'Dinner Menu Assignments'
        @div class: 'calendar', =>
          @table class: 'bordered', =>
            @tr class: 'calendar-header', =>
              @td class: 'text-center', =>
                @a class: 'btn-previous-year', href: '#', =>
                  @i class: 'icon-previous'
              @td class: 'text-center', =>
                @a class: 'btn-previous-month', href: '#', =>
                  @i class: 'icon-arrow-left-4'
              @td class: 'text-center', =>
                @a class: 'btn-select-month', href: '#', "Month"
              @td class: 'text-center', =>
                @a class: 'btn-next-month', href: '#', =>
                  @i class: 'icon-arrow-right-4'
              @td class: 'text-center', =>
                @a class: 'btn-next-year', href: '#', =>
                  @i class: 'icon-next'
            @tr class: 'calendar-subheader', =>
              @td class: 'text-center day-of-week', 'Monday'
              @td class: 'text-center day-of-week', 'Tuesday'
              @td class: 'text-center day-of-week', 'Wednesday'
              @td class: 'text-center day-of-week', 'Thursday'
              @td class: 'text-center day-of-week', 'Friday'
