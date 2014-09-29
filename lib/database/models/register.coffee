{Class, Model, Pupil} = require '../../database'

module.exports =
  class Register extends Model
    @tableName: "register"

    @findOrCreate: (classId, sessionId) ->
      date = @mysqlDate(new Date)
      results = @manualSelectQuery('classId = ' + classId + ' AND sessionId = ' + sessionId + ' AND date = "' + date + '"')
      if results.length == 0
        @insert({
          classId: classId,
          sessionId: sessionId,
          date: date
        })
        return @manualSelectQuery('classId = ' + classId + ' AND sessionId = ' + sessionId + ' AND date = "' + date + '"')[0]
      else
        return results[0]

    @displayDate: (mysqlDate) ->
      date = new Date(Date.parse(mysqlDate))
      date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear()
