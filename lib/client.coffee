remote = require 'remote'
window.$ = window.jQuery = require "../assets/js/jquery-2.1.1.min.js"
require "../assets/js/jquery.hotkeys.js"

#LESS
less = remote.require 'less'
parser = new(less.Parser)({
  paths: [__dirname + '/../less/'],
  filename: 'style.less'
});

parser.parse '@import "main.less";', (e, tree) ->
  $('#stylesheet').html tree.toCSS({
    compress: true
  });

# Views
MainView = require './views/main-view'

HomeView = require './views/home-view'

# Apply Main View
$(document).ready ->
  main = new MainView
  $('body').html(main)

  view = new HomeView
  main.setBodyView(view)
  view.applyData()

# Events
require('ipc').on 'menu', (message) ->
  view = require './views/' + message
  instance = new view
  $('.main-body').html(instance)
  instance.applyData()

  $('.sidebar li.active').removeClass('active')

require('ipc').on 'receive-from-cache', (response) ->
  console.dir response
