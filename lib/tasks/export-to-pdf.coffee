PDFDocument = require 'pdfkit'
fs = require 'fs'

{ClassList, Config, PupilList, Register} = require '../database'

module.exports =
  run: ->
    ClassList.all().forEach (klass) ->
      pdf = new PDFDocument
      pdf.pipe fs.createWriteStream(Config.value('data-export-directory') + 'pdf/' + ClassList.pdfFileName(klass))
      pdf.font('assets/fonts/Roboto-Thin-webfont.ttf')

      pdf.fontSize(25)
      pdf.text(klass + " Register Export")

      pdf.fontSize(12)

      date = new Date
      pdf.text(date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear())
      pdf.moveDown()

      if Register.beenDone(klass)
        register = Register.forNow(klass)
        Object.keys(register).forEach (key) ->
          pupil = PupilList.findByUPN(klass, key)
          pdf.text(pupil.firstName + " " + pupil.lastName)

          if register[key].present == 'on'
            pdf.text("/")
          else
            pdf.text("O")

      else
        pdf.text("This Register has not yet been submitted")

      pdf.end()

    path = Config.value('data-export-directory') + 'pdf/'

    alert(path)

    require('shell').openExternal(path)
