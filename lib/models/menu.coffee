CSON = require 'season'
fs = require 'fs'

{Database} = require '../database'

module.exports =
  data: ->
    if fs.existsSync Database.path() + '/menu.cson'
      return CSON.readFileSync(Database.path() + '/menu.cson')
    else
      return {}

  setChoice: (key, choice) ->
    data = @data()
    unless data[key]
      data[key] = []
    data[key][0] = choice
    CSON.writeFileSync(Database.path() + '/menu.cson', data)

  setDate: (key, date) ->
    data = @data()
    unless data[key]
      data[key] = []
    data[key][1] = date
    CSON.writeFileSync(Database.path() + '/menu.cson', data)

  setDefault: (key, def) ->
    data = @data()
    unless data[key]
      data[key] = []
    data[key][2] = def
    CSON.writeFileSync(Database.path() + '/menu.cson', data)

  hasItems: (date) ->
    @itemsFor(date).length != 0

  itemsFor: (date) ->
    dateString = date.getFullYear() + "-" + ('0' + (date.getMonth()+1)).slice(-2) + "-" + date.getDate()
    items = []
    data = @data()
    Object.keys(data).forEach (key) ->
      item = data[key]
      if item[1] == dateString
        items.push item
      else if item[2]
        items.push item

    return items

  delete: (key) ->
    data = @data()
    delete data[key]
    CSON.writeFileSync(Database.path() + '/menu.cson', data)
