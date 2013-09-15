http = require 'http'
express = require('express')
path = require('path')
app = express()

port = process.env.PORT || 3000

app.use (req, res, next) -> res.locals.pretty = true; next()
app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))

app.get '/', (req, res) -> res.render 'index.jade'

http.createServer(app).listen port, ->
  console.log("Listening on " + port)
