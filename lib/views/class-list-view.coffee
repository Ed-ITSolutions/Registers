{View} = require 'space-pen'
{ClassList} = require '../database'
ClassView = require './items/class'

module.exports =
  class ClassListView extends View
    @content: ->
      @div class: "class-list", =>
        @h1 "Class List"
        @ul class: 'entries', outlet: 'entries'

    initialize: ->
      @applyData()

    applyData: ->
      ClassList.all().forEach (klass) ->
        $('.entries').append(new ClassView(klass))
