{View} = require 'space-pen'

fs = require 'fs'

module.exports =
  class AboutView extends View
    @content: ->
      @div class: 'about', =>
        @h1 "About Registers"
        @h2 "Links"
        @ul outlet: 'links', =>
          @li =>
            @a href: "https://github.com/Ed-ITSolutions/Registers/issues", class: 'link', "Bug Tracker"
          @li =>
            @a href: "http://www.ed-itsolutions.com", class: 'link', "Ed-IT Solutions"
          @li =>
            @a href: "https://github.com/Ed-ITSolutions/Registers", class: 'link', "Source Code"
          @li =>
            @a href: "https://github.com/Ed-ITSolutions/Registers/wiki", class: 'link', "Wiki"
        @h2 "Versions"
        @table =>
          @tr =>
            @th "Product"
            @th "Version"
          @tr =>
            @td "Atom Shell"
            @td process.versions['atom-shell']
          @tr =>
            @td "Node.JS"
            @td process.versions['node']
          @tr =>
            @td "Registers"
            @td @registersVersion()
          @tr =>
            @td "V8"
            @td process.versions['v8']
        @h2 "License"
        @p =>
          @raw @license()

    applyData: ->
      $('.link').on 'click', ->
        require('shell').openExternal($(this).attr('href'))
        false

    @license: ->
      @nl2br fs.readFileSync("LICENSE.markdown")

    @nl2br: (str) ->
      (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1<br />$2').replace(/"/g, "\"")

    @registersVersion: ->
      JSON.parse(fs.readFileSync("package.json"))["version"]
