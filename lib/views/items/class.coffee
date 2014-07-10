{View} = require 'space-pen'
{ClassList} = require '../../database'

module.exports =
  class ClassView extends View
    @content: ->
      @li =>
        @p outlet: 'name'
        @a outlet: 'button'

    initialize: (klass) ->
      @name.html klass
      if ClassList.hasPupils(klass)
        @button.html "Take Register"
      else
        @button.html "Add Pupils"
