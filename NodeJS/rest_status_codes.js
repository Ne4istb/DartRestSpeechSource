var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json({ type: 'application/json' }));

var speeches = {
	get : function(id){
		return id;
	},
	update: function(id, data){
		console.log('data', id , data);
	},
	remove: function(id){
		console.log('delete', id);
	},
	add: function(data){
		console.log('data', data);
	}
};

app.get('/devfest/speech', function(request, response){

	var speech = speeches.get();

	response.status(200).end(speech);
});

app.post('/devfest/speech', function(request, response){

	speeches.add(request.body);

	response.status(201).end();
});

app.listen(8080);
