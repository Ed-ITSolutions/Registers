window.$ = window.jQuery = require '../../assets/js/jquery-2.1.1.min.js'
require '../../assets/js/jquery.hotkeys.js'

process.chdir(__dirname)
process.chdir('../../lib/client')

MainView = require process.cwd() + '\\views\\main'

$(document).on 'ready', ->
  mainView = new MainView
  $('body').html(mainView)
