var fs = require('fs');

var data = fs.readFileSync('tileinfo-floor.js', 'utf-8');

var func = new Function(data);

console.log(func);

func();
