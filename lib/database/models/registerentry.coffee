{Model} = require '../../database'

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
