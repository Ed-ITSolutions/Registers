{View} = require 'space-pen'

{Class, Pupil, Register, RegisterEntry, Session} = require '../../database'

module.exports =
  class RegisterView extends View
    @content: (register) ->
      @div =>
        @h1 Class.find('idClass', register.classId).name
        @h2 Register.displayDate(register.date) + ' ' + Session.find('idSessions', register.sessionId).name
        @table class: 'table hovered', =>
          @thead =>
            @th "Name"
            @th "Present?"
            @th "Dinner Choice"
          @tbody id: 'registerBody', =>
            for pupil in Pupil.where('classId', register.classId)
              @tr =>
                @td pupil.firstName + ' ' + pupil.lastName
                @td =>
                  @div class: 'input-control switch', =>
                    @label =>
                      @span class: 'choice', "No"
                      @input type: 'checkbox', 'data-pupil': pupil.idPupils, 'data-field': 'present', 'data-register': register.idRegister
                      @span class: 'check'
                      @span class: 'choice', "Yes"
                @td 'dinners here'
        @button class: 'large info', click: 'recordRegister', "Record Register"

    recordRegister: (event, element) ->
      $('#registerBody input').each (el) ->
        entry = RegisterEntry.for($(this).attr('data-register'), $(this).attr('data-pupil'))
        RegisterEntry.update({
          present: $(this).prop 'checked'
        }, 'idRegisterEntry', entry.idRegisterEntry)

    loadData: ->
      $('#registerBody input').each (el) ->
        registerentry = RegisterEntry.manualSelectQuery('registerId = ' + $(this).attr('data-register') + ' AND pupilId = ' + $(this).attr('data-pupil') + ' LIMIT 1')
        if registerentry[0]
          $(this).prop 'checked', registerentry[0].present
