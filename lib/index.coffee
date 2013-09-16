toJS = (obj) -> return JSON.stringify(obj)
  .replace(/\u2028/g, '\\u2028').replace(/\u2029/g, '\\u2029')

tile_list = toJS(require '../tile_list.json')

setRoutes = (app) ->
  app.get '/', (req, res) -> res.render 'index.jade', { tile_list: tile_list }

module.exports.setRoutes = setRoutes
