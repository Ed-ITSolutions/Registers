PDFDocument = require 'pdfkit'
fs = require 'fs'

{ClassList, Config, PupilList, Register} = require '../database'

module.exports =
  run: ->
    pdf = new PDFDocument
    pdf.pipe fs.createWriteStream(Config.value('data-export-directory') + 'pdf/dinner-choices.pdf')
    pdf.font('assets/fonts/Roboto-Thin-webfont.ttf')

    pdf.fontSize(25)
    pdf.text("Dinner Choices")

    pdf.fontSize(12)

    date = new Date
    pdf.text(date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear())
    pdf.moveDown()

    ClassList.all().forEach (klass) ->
      if Register.beenDone(klass, Config.value("dinner-session"))
        register = Register.forDate(klass, new Date, Config.value("dinner-session"))
        pdf.fontSize(20)
        pdf.text(klass)

        pdf.fontSize(12)
        Object.keys(register).forEach (key) ->
          if register[key]['dinner']
            pupil = PupilList.findByUPN(klass, key)
            fullName = pupil.firstName + " " + pupil.lastName
            pdf.text fullName, 72
            pdf.moveUp(1)
            pdf.text register[key]['dinner'], 200


    pdf.end()

    path = Config.value('data-export-directory') + 'pdf/dinner-choices.pdf'

    require('shell').openExternal(path)
