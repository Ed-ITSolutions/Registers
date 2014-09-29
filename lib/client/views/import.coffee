fs = require 'fs'
xml2js = require 'xml2js'

{View} = require 'space-pen'

dialog = require('remote').require('dialog')

{Pupil} = require '../../database'

module.exports =
  class ImportView extends View
    @content: ->
      @div =>
        @h1 "Import Data"
        @p "Use the provided SIMS report to export your data from SIMS, then upload it here."
        @button click: "importData", "Import!"
        @div id: 'import-details'

    importData: (event, element) ->
      files = dialog.showOpenDialog({ properties: [ 'openFile' ] })

      fs.readFile files[0], (err, data) ->
        $('#import-details').html("<p>Importing...</p>")
        if err
          $('#import-details').append('<p>ERROR! ' + err + '</p>')
        else
          $('#import-details').append('<p><span id="current">0</span>/<span id="total">0</span></p>')
          $('#import-details').append('<div class="progress-bar large"><div class="bar bg-cyan" id="import-bar" style="width:0%;"></div></div>')

          parser = new xml2js.Parser()
          parser.parseString data, (err, result) ->
            $('#total').html(result['SuperStarReport']['Record'].length)
            total = result['SuperStarReport']['Record'].length

            result['SuperStarReport']['Record'].forEach (record) ->
              if Pupil.addFromSims(record)
                count = parseInt($('#current').html()) + 1

                $('#current').html(count)
                $('#import-bar').css('width', ((count/total)*100) + "%" )

                if total == count
                  $('#import-details').append("<p>Done!</p>")
