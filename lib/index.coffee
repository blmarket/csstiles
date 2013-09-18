models = require './models'

toJS = (obj) -> return JSON.stringify(obj)
  .replace(/\u2028/g, '\\u2028').replace(/\u2029/g, '\\u2029')

tile_list = toJS(require '../tile_list.json')

simpleMiddleware = (func, param_list) ->
  return (req, res, next) ->
    params = (req.param(item) for item in param_list)
    params.push (err, result) ->
      return next(err) if err?
      return res.send(204) unless result?
      res.jsonp(result)
      return
    func.apply func, params

setRoutes = (app) ->
  app.get '/', (req, res) -> res.render 'index.jade', { tile_list: tile_list }
  app.post '/1/board', simpleMiddleware(models.saveMap, [ 'user', 'board' ])
  app.get '/1/board', simpleMiddleware(models.loadMap, [ 'user' ])
  return

module.exports.setRoutes = setRoutes
