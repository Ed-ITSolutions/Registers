{Model} = require '../../database'

module.exports =
  class Config extends Model
    @tableName: 'config'

    @setting: (name) ->
      @find('setting', name).value
