util = require 'util'

inspect = (obj) -> util.inspect obj, { colors: true, depth: null }
debug = (err, res) -> console.log err? && err || inspect(res)

mongoose = require 'mongoose'
mongoose.connect 'mongodb://ci.recopick.com/hello'
mongoose.connection.on 'error', (err) -> throw err
Mixed = mongoose.Schema.Types.Mixed

mapSchema = mongoose.Schema {
  owner: String
  board: Mixed
}
mapSchema.index { owner: 1 }

Map = mongoose.model 'Map', mapSchema

getOrCreate = (owner, callback) ->
  Map.findOne { owner: owner }, (err, res) ->
    return callback(err) if err?
    res = new Map { owner: owner, board: [[['']]] } unless res?
    callback(null, res)
    return
  return

test__getOrCreate = ->
  getOrCreate 'me', (err, res) ->
    console.log res
    console.log inspect(res.board)
    res.board = [[['2']]]
    res.save()
    console.log 'done'

loadMap = (user, cb) -> getOrCreate user, cb
saveMap = (user, board, cb) ->
  console.log user
  console.log board
  getOrCreate user, (err, res) ->
    return cb(err) if err?
    res.board = board
    res.save()
    cb null, null
    return
  return

module.exports.loadMap = loadMap
module.exports.saveMap = saveMap
