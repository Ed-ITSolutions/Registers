{Model, Pupil, Register, RegisterEntry} = require '../../database'

module.exports =
  class Session extends Model
    @tableName: "sessions"


    @current: ->
      date = new Date
      currentHours = ("0" + date.getHours()).slice(-2)
      currentMinutes = ("0" + date.getMinutes()).slice(-2)

      @manualSelectQuery('startTime <= "' + currentHours + ':' + currentMinutes + '" ORDER BY startTime DESC LIMIT 1')[0]

    @pupilsInSession: (sessionId, date) ->
      registers = Register.manualSelectQuery('sessionId = ' + sessionId + ' AND date = \'' + @mysqlDate(date) + '\'')
      pupils = {present: 0, absent: 0, total: 0}

      registers.forEach (register) ->
        entries = RegisterEntry.where('registerId', register.idRegister)
        pupils['total'] = pupils['total'] + entries.length
        entries.forEach (entry) ->
          if entry.present
            pupils['present'] = pupils['present'] + 1
          else
            pupils['absent'] = pupils['absent'] + 1

      pupils['all'] = Pupil.all().length
      pupils['missing'] = pupils['all'] - pupils['total']

      return pupils

    @absentPupilsInSession: (sessionId, date) ->
      registers = Register.manualSelectQuery('sessionId = ' + sessionId + ' AND date = \'' + @mysqlDate(date) + '\'')

      pupils = []

      registers.forEach (register) ->
        entries = RegisterEntry.where('registerId', register.idRegister)
        entries.forEach (entry) ->
          unless entry.present
            pupils.push Pupil.find('idPupils', entry.pupilId)

      return pupils
