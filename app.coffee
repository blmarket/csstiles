http = require 'http'
express = require('express')
path = require('path')
app = express()

port = process.env.PORT || 3000

app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))

http.createServer(app).listen port, ->
  console.log("Listening on " + port)
