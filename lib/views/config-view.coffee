{View} = require 'space-pen'
{Config} = require '../database'

ConfigItemView = require './items/config-item-view'

module.exports =
  class ConfigView extends View
    @content: ->
      @div class: 'config', =>
        @h1 "Configuration"
        @ul class: 'config-items', outlet: 'configItems'

    applyData: ->
      Object.keys(Config.all()).sort().forEach (key) ->
        $('.config-items').append(new ConfigItemView(key))
