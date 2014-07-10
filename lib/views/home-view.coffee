{View} = require 'space-pen'
{Config, Register} = require '../database'
RegisterView = require './register-view'

module.exports =
  class HomeView extends View
    @content: ->
      @div class: 'home', =>
        @object data: "assets/svgs/logo.svg", type: "image/svg+xml", =>
          @h1 "Register"
        @div class: 'info', =>
          @h2 outlet: 'schoolName'
          @p outlet: 'timeInfo'
          @p outlet: 'classInfo'

    applyData: ->
      @schoolName.html Config.value("school-name")

      date = new Date
      @timeInfo.html(date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear() + " " + Register.currentSession())

      if localStorage.getItem('class') != null
        @addClassInfo()
      else
        @classInfo.html "You have not yet selected a class"

    addClassInfo: ->
      klass = localStorage.getItem('class')

      if Register.beenDone(klass)
        @classInfo.html "The " + klass + " Register has already been done"
      else
        @classInfo.html "You still need to submit the register for this session, <a href=\"#\">Do it Now</a>"

        @classInfo.children('a').on 'click', ->
          regview = new RegisterView
          $('.main-body').html(regview)
          regview.applyData(localStorage.getItem('class'))
          $('.nav .active').removeClass('active')
          $('.register-link').addClass('active')
