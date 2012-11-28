var express = require('express');
var path = require('path');
var app = express();

var port = process.env.PORT || 3000;

app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

app.listen(port);
console.log("Listening on " + port);
