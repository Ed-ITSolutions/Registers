window.$ = window.jQuery = require '../../assets/js/jquery-2.1.1.min.js'
require '../../assets/js/jquery.hotkeys.js'

MainView = require './views/main'

$(document).on 'ready', ->
  mainView = new MainView
  $('body').html(mainView)
