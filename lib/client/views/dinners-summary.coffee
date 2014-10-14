{View} = require 'space-pen'

wkhtmltopdf = require '../../bindings/wkhtmltopdf'

{Config, Class, DinnerChoice, Pupil, RegisterEntry, Session} = require '../../database'

module.exports =
  class DinnersSummaryView extends View
    @content: ->
      @div class: 'topdf', =>
        @h1 'Dinners Summary'
        @h2 Config.setting('name')
        @button class: 'image-button primary', click: 'print', =>
          @span "Print"
          @i class: 'icon-file-pdf bg-cobalt'
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th 'Pupil'
              @th 'Choice'
          @tbody =>
            for entry in RegisterEntry.havingDinner(new Date)
              pupil = Pupil.find('idPupils', entry.pupilId)
              @tr =>
                @td pupil.firstName + ' ' + pupil.lastName
                @td DinnerChoice.find('idDinnerChoice', entry.choiceId).name

    print: (event, element) ->
      $('.topdf').addClass('pdf')

      path = "C:\\pdf\\choices.pdf"

      wkhtmltopdf.render($('.pdf').html(), path)

      $('.topdf').removeClass('pdf')
