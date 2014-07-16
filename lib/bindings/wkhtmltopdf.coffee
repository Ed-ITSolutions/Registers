fs = require 'fs'
spawn = require('child_process').spawn

module.exports =
  class WKHTMLTOPDF
    @render: (html, path) ->
      file = fs.createWriteStream(path)

      child = spawn @shell(), @args(), { windowsVerbatimArguments: true }

      child.stdin.end html

      child.stdout.pipe(file)



    @shell: ->
      if process.platform == 'darwin'
        return "/bin/sh"

      if process.platform == 'win32'
        return "cmd"

      throw "No function to find your wkhtmltopdf binary"

    @binary: ->
      if process.platform == 'darwin'
        return "wkhtmltopdf"

      if process.platform == 'win32'
        return "\"C:\\Program Files\\wkhtmltopdf\\bin\\wkhtmltopdf.exe\""

      throw "No function to find your wkhtmltopdf binary"

    @args: ->
      args = [@binary(), "--quiet", "-", "-"]

      if process.platform == 'darwin'
        return ['-c', args.join(' ') + ' | cat']

      if process.platform == 'win32'
        args.unshift("/C")
        return args
