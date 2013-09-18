http = require 'http'
express = require 'express'
path = require 'path'

lib = require './lib'

app = express()

port = process.env.PORT || 3000

app.use express.bodyParser()
app.use (req, res, next) -> res.locals.pretty = true; next()
app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))

lib.setRoutes app

http.createServer(app).listen port, ->
  console.log("Listening on " + port)
