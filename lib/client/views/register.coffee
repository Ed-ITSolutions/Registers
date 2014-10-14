{View} = require 'space-pen'

{Class, Config, DinnerMenuAssignment, Pupil, Register, RegisterEntry, Session} = require '../../database'

module.exports =
  class RegisterView extends View
    @content: (register) ->
      @div =>
        @h1 Class.find('idClass', register.classId).name
        @h2 Register.displayDate(register.date) + ' ' + Session.find('idSessions', register.sessionId).name
        @table class: 'table hovered', =>
          @thead =>
            @tr =>
              @th "Name"
              @th "Present?"
              if '' + register.sessionId == Config.setting('dinnerSession')
                @th "Dinner Choice"
          @tbody id: 'registerBody', =>
            for pupil in Pupil.where('classId', register.classId)
              @tr =>
                @td Pupil.unescape(pupil.firstName) + ' ' + Pupil.unescape(pupil.lastName)
                @td =>
                  @div class: 'input-control switch', =>
                    @label =>
                      @span class: 'choice', "No"
                      @input type: 'checkbox', 'data-pupil': pupil.idPupils, 'data-register': register.idRegister
                      @span class: 'check'
                      @span class: 'choice', "Yes"
                if '' + register.sessionId == Config.setting('dinnerSession')
                  @td =>
                    @select 'data-pupil': pupil.idPupils, 'data-register': register.idRegister, =>
                      @option value: 0, 'None/Packed Lunch'
                      for choice in DinnerMenuAssignment.forRegister()
                        @option value: choice.idDinnerChoice, choice.name
        @button class: 'large info', click: 'recordRegister', "Record Register"

    recordRegister: (event, element) ->
      $('#registerBody input').each (el) ->
        entry = RegisterEntry.for($(this).attr('data-register'), $(this).attr('data-pupil'))
        RegisterEntry.update({
          present: $(this).prop 'checked'
        }, 'idRegisterEntry', entry.idRegisterEntry)

      $('#registerBody select').each (el) ->
        entry = RegisterEntry.for($(this).attr('data-register'), $(this).attr('data-pupil'))
        RegisterEntry.update({
          choiceId: $(this).val()
        }, 'idRegisterEntry', entry.idRegisterEntry)

    loadData: ->
      $('#registerBody input').each (el) ->
        registerentry = RegisterEntry.manualSelectQuery('registerId = ' + $(this).attr('data-register') + ' AND pupilId = ' + $(this).attr('data-pupil') + ' LIMIT 1')
        if registerentry[0]
          $(this).prop 'checked', registerentry[0].present
      $('#registerBody select').each (el) ->
        registerentry = RegisterEntry.manualSelectQuery('registerId = ' + $(this).attr('data-register') + ' AND pupilId = ' + $(this).attr('data-pupil') + ' LIMIT 1')
        if registerentry[0]
          $(this).val registerentry[0].choiceId

      @bindKeyboardEvents()

    bindKeyboardEvents: ->
      current = 0
      $(document).on 'keydown', null, 'y', ->
        $('#registerBody tr:nth-child(' + current + ')').removeClass('current')
        current += 1
        $(window).scrollTop(46 * current)
        $('#registerBody tr:nth-child(' + current + ')').addClass('current')

        input = $('#registerBody tr:nth-child(' + current + ')').children('td').children('div').children('label').children('input')
        input.prop 'checked', true

      $(document).on 'keydown', null, 'n', ->
        $('#registerBody tr:nth-child(' + current + ')').removeClass('current')
        current += 1
        $(window).scrollTop(46 * current)
        $('#registerBody tr:nth-child(' + current + ')').addClass('current')

        input = $('#registerBody tr:nth-child(' + current + ')').children('td').children('div').children('label').children('input')
        input.prop 'checked', false
      if($('thead tr').children().length == 3)
        $('#mainBody').append('<div class="metro notify-container" id="notifyContainer"></div>')
        $('#notifyContainer').append('<div class="notify shadow"><div class="content" id="choicesList"><b>Dinner Choices</b><br /><br /></div></div>')
        $('#choicesList').append('[0] None/Packed Lunch<br />')
        $(document).on 'keydown', null, '0', ->
          select = $('#registerBody tr:nth-child(' + current + ')').children('td').children('select')
          select.val(0)

      num = 0
      for choice in DinnerMenuAssignment.forRegister()
        num += 1
        @bindChoice(choice, num)

    bindChoice: (dc, i) ->
      $('#choicesList').append('[' + i + '] ' + dc.name + '<br />')
      $(document).on 'keydown', null, '' + i, ->
        select = $('#registerBody tr.current').children('td').children('select')
        select.val(dc.idDinnerChoice)
