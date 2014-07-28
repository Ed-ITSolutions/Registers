fs = require 'fs'
CSON = require 'cson-safe'

Cache =
  files: {}
  objects: {}

  returnFile: (fileName) ->
    @files[fileName]

  returnObject: (objectName) ->
    @objects[objectName]

  receiveData: (path, data) ->
    @files[path] = data

  cacheFolder: (folder) ->
    fs.readdir(folder, (e, results) ->
      results.forEach (result) ->
        Cache.cacheEntry(folder, result)
    )

  cacheFile: (path) ->
    parts = path.split('.')
    extension =parts.pop()

    if extension == "cson"
      fs.readFile(path, (e, data) ->
        Cache.receiveData path, data
        obj = parts.pop().split("/").pop()
        Cache.objects[obj] = CSON.parse data
      )

  cacheEntry: (folder, entry) ->
    path = folder + "/" + entry

    fs.stat(path, (e, stats) ->
      if stats.isDirectory()
        Cache.cacheFolder(path)
      else if stats.isFile()
        Cache.cacheFile(path)
        Cache.watch(path)
    )

  watch: (path) ->
    fs.watch(path, (current, previous) ->
      Cache.cacheFile(path)
    )

module.exports = Cache
