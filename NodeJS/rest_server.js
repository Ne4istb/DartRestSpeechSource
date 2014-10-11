var express = require('express');
var app = express();

app.get('/hello/:name', function(req, res){
	res.send('Hello, ' + req.param('name') + '!');
});

app.listen(8080);
