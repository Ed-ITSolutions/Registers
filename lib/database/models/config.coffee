{Model} = require '../../database'

module.exports =
  class Config extends Model
    @tableName: 'config'

    @setting: (name) ->
      @unescape @find('setting', name).value
