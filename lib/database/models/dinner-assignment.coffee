{DinnerMenu, DinnerChoice, Model} = require '../../database'

module.exports =
  class DinnerMenuAssignment extends Model
    @tableName: 'dinnermenuassignment'

    @menuFor: (date) ->
      assignment = @manualSearchQuery("date = '" + @mysqlDate(date) + "'")[0]
      return DinnerMenu.find('idDinnerMenu', assignment.menuId)

    @fromToday: ->
      @manualSelectQuery("date >= '" + @mysqlDate(new Date) + "'")

    @forRegister: ->
      assignment = @manualSelectQuery("date = '" + @mysqlDate(new Date) + "'")[0]
      return DinnerChoice.where('menuId', assignment.menuId)
