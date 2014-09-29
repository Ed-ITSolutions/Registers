ipc = require 'ipc'

module.exports=
  class Model
    @all: ->
      ipc.sendSync('run-query', 'SELECT * FROM registers.' + @tableName + ';')

    @where: (column, value) ->
      ipc.sendSync('run-query', 'SELECT * FROM registers.' + @tableName + ' WHERE ' + column + ' = "' + value + '";')

    @find: (column, value) ->
      ipc.sendSync('run-query', 'SELECT * FROM registers.' + @tableName + ' WHERE ' + column + ' = "' + value + '" LIMIT 1;')[0]

    @insert: (fields) ->
      keyList = Object.keys(fields).join(", ")
      valueListArr = []
      Object.keys(fields).forEach (key) ->
        valueListArr.push "'" + fields[key] + "'"

      valueList = valueListArr.join(", ")

      query = 'INSERT INTO registers.' + @tableName + ' (' + keyList + ') VALUES (' + valueList + ');'

      ipc.sendSync('run-query', query)

    @update: (fields, idcol, id) ->
      setList = []
      Object.keys(fields).forEach (key) ->
        if fields[key] == true
          value = 1
        else if fields[key] == false
          value = 0
        else
          value = @escape(fields[key])

        setList.push '`' + key + '` = \'' + value + '\''

      query = "UPDATE registers." + @tableName + " SET " + setList.join(", ") + " WHERE `" + idcol + "`='" + id + "';"

      ipc.sendSync('run-query', query)

    @escape: (str) ->
      str.replace(/'/g, "\\\'")

    @manualSelectQuery: (str) ->
      ipc.sendSync('run-query', 'SELECT * FROM registers.' + @tableName + ' WHERE ' + str)

    @mysqlDate: (date) ->
      date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()
