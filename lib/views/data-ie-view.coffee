{View} = require 'space-pen'

module.exports =
  class DataIEView extends View
    @content: ->
      @div class: 'data-ie', =>
        @h1 "Import/Export Data"
        @h2 "Export"
        @ul class: 'export-list', =>
          @li =>
            @p =>
              @a href: 'export-to-pdf', "Export Current Session Registers to PDF"
            @p "Export the resgisters for the curent session to a PDF, ready for printing."
        @h2 "Import"
        @ul class: 'import-list', =>
          @li =>
            @p =>
              @a href: 'import-from-sims', "Import Pupils & Classes from SIMS"
            @p "Import Pupils & Classes from SIMS using the report provided."

    applyData: ->
      $('.export-list a').on 'click', ->
        task = require "../tasks/" + $(this).attr('href')
        task.run()

        return false

      $('.import-list a').on 'click', ->
        task = require "../tasks/" + $(this).attr('href')
        task.run()

        return false
