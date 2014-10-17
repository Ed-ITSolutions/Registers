{View} = require 'space-pen'

{Register} = require '../../../database'

AttendanceRangePDF = require '../pdfs/attendance-range'

wkhtmltopdf = require '../../../bindings/wkhtmltopdf'

module.exports =
  class AttendanceRangeView extends View
    @content: ->
      @div class: 'metro window-overlay', id: 'modalContainer', =>
        @div class: 'window flat shadow', =>
          @div class: 'caption', =>
            @button class: 'btn-close', click: 'closeWindow'
            @div class: 'title', 'Select Range'
          @div class: 'content', =>
            @form =>
              @label 'From'
              @div class: 'input-control text', =>
                @input type: 'date', id: 'fromDate'
              @label 'To'
              @div class: 'input-control text', =>
                @input type: 'date', id: 'toDate'
              @div class: 'form-actions', =>
                @button class: 'primary', click: 'print', 'Print'
                @button click: 'closeWindow', 'Cancel'

    closeWindow: (event, element) ->
      $('#modalContainer').remove()
      return false

    print: (event, element) ->
      registers = Register.inRange($('#fromDate').val(), $('#toDate').val())
      dates = []
      for register in registers
        if dates.indexOf(register.date) == -1
          dates.push register.date

      $('#mainBody').append(new AttendanceRangePDF(dates))

      path = "C:\\pdf\\attendance.pdf"

      wkhtmltopdf.render($('.pdf').html(), path)

      $('.pdf').remove()

      @closeWindow(event, element)
      return false
