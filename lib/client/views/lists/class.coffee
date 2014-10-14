{View} = require 'space-pen'

{Class, Pupil} = require '../../../database'

PupilListView = require './pupils.coffee'

module.exports =
  class ClassList extends View
    @content: ->
      @div =>
        @h1 "Class List"
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th "Name"
              @th "Number of Pupils"
          @tbody id: 'class-tbody'

    afterAttach: (onDom) ->
      Class.all().forEach (klass) ->
        pupils = Pupil.where("classId", klass.idClass)
        $('#class-tbody').append("<tr><td><a href=\"" + klass.idClass + "\">" + klass.name + "</a></td><td>" + pupils.length + "</td></tr>")


      $('#class-tbody a').on 'click', ->
        $('#mainBody').html(new PupilListView($(this).attr('href')))
        return false
