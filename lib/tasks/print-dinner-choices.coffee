DinnerListPDF = require '../views/pdfs/dinner-list-pdf'

{Config} = require '../database'

fs = require 'fs'
wkhtmltopdf = require '../bindings/wkhtmltopdf'

module.exports =
  run: ->
    path = Config.value('data-export-directory') + 'pdf/dinner-choices.pdf'

    pdf = new DinnerListPDF
    $('.pdf').html(pdf)
    pdf.applyData()

    wkhtmltopdf.render($('.pdf').html(), path)

    $('.pdf').html("")

    require('shell').openExternal(path)
