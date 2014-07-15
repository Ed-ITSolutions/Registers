DinnerListPDF = require '../views/pdfs/dinner-list-pdf'

{Config} = require '../database'

fs = require 'fs'
wkhtmltopdf = require 'wkhtmltopdf'

module.exports =
  run: ->
    path = Config.value('data-export-directory') + 'pdf/dinner-choices.pdf'

    pdf = new DinnerListPDF
    $('.pdf').html(pdf)
    pdf.applyData()

    wkhtmltopdf($('.pdf').html()).pipe(fs.createWriteStream(path))

    $('.pdf').html("")

    require('shell').openExternal(path)
