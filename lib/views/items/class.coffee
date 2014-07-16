{View} = require 'space-pen'
{ClassList, PupilList} = require '../../database'

module.exports =
  class ClassView extends View
    @content: (klass) ->
      @tr =>
        @td klass
        @td outlet: 'pupils'
        @td outlet: 'status'

    initialize: (klass) ->
      if ClassList.hasPupils(klass)
        @pupils.html PupilList.forClass(klass).length
        @status.html "Ok"
      else
        @pupils.html "-"
        @status.html "Needs Pupils"
