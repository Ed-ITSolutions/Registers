{View} = require 'space-pen'
{Config, Session} = require '../database'

ConfigItemView = require './items/config-item-view'
SessionItemView = require './items/session-item-view'

module.exports =
  class ConfigView extends View
    @content: ->
      @div class: 'config', =>
        @h1 "Configuration"
        @ul class: 'config-items', outlet: 'configItems'
        @h2 "Sessions"
        @ul class: 'session-items', outlet: 'sessionItems'

    applyData: ->
      Object.keys(Config.all()).sort().forEach (key) ->
        $('.config-items').append(new ConfigItemView(key))

      Object.keys(Session.all()).forEach (key) ->
        $('.session-items').append(new SessionItemView(key))

      $('.session-items').append(new SessionItemView("Add New Session"))
