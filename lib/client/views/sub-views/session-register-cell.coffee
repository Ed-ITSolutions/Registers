{View} = require 'space-pen'

{Register} = require '../../../database'

RegisterView = require '../register'

module.exports =
  class SessionCellView extends View
    @content: (klass, session) ->
        @a 'data-class': klass.idClass, 'data-session': session.idSessions, click: 'openRegister', =>
          @span klass.name + session.name

    openRegister: (event, element) ->
      register = Register.findOrCreate($(this).attr('data-class'), $(this).attr('data-session'))
      view = new RegisterView(register)
      $('#mainBody').html(view)
      view.loadData()

      return false
