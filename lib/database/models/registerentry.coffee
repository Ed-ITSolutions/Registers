{Config, Model, Register} = require '../../database'

module.exports =
  class RegisterEntry extends Model
    @tableName: "registerentry"

    @for: (registerId, pupilId) ->
      results = @manualSelectQuery('registerId = ' + registerId + ' AND pupilId = ' + pupilId + ' LIMIT 1')
      if results.length == 0
        @insert({
          registerId: registerId,
          pupilId: pupilId
        })
        return @manualSelectQuery('registerId = ' + registerId + ' AND pupilId = ' + pupilId + ' LIMIT 1')[0]
      else
        return results[0]

    @havingDinner: (date) ->
      registers = Register.manualSelectQuery('date = "' + @mysqlDate(date) + '" AND sessionId = ' + Config.setting('dinnerSession'))
      ents = []
      for register in registers
        entries = @manualSelectQuery('registerId = ' + register.idRegister + ' AND NOT choiceId = 0 AND present = 1')
        ents = ents.concat(entries)

      return ents
