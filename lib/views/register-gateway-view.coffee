{View} = require 'space-pen'
RegisterView = require './register-view'
{ClassList} = require '../database'

module.exports =
  class RegisterGatewayView extends View
    @content: ->
      @div class: 'gateway', =>
        @h1 "Select a Class"
        @p =>
          @span "Remeber this Selection:"
          @input type: 'checkbox', outlet: 'check', id: 'remember'
        @ul class: 'class-list'

    initialize: ->
      @check.on 'change', ->
        $(this).attr("data-value", $(this).val())

    applyData: ->
      if localStorage.getItem('class') != null
        regview = new RegisterView
        $('.main-body').html(regview)
        regview.applyData(localStorage.getItem('class'))
      else
        ClassList.all().forEach (klass) ->
          if ClassList.hasPupils(klass)
            $('.class-list').append("<li><a href=\"#\">" + klass + "</a></li>")

        $('.class-list a').on 'click', ->
          if $('#remember').attr("data-value") == "on"
            localStorage.setItem('class', $(this).html())

          regview = new RegisterView
          $('.main-body').html(regview)
          regview.applyData($(this).html())

          return false
