{View} = require 'space-pen'

{Class, Pupil} = require '../../../database'

module.exports =
  class PupilListView extends View
    @content: (classId) ->
      @div =>
        @h1 "Pupil List for " + Class.find('idClass', classId).name
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th "First Name"
              @th "Last Name"
              @th "UPN"
          @tbody id: 'pupil-tbody', 'data-class': classId, =>
            for pupil in Pupil.where('classId', classId)
              @tr =>
                @td Pupil.unescape pupil.firstName
                @td Pupil.unescape pupil.lastName
                @td pupil.UPN
