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

app.get('/devfest/speech/:id', function(request, response){

	var id = request.params.id;
	var speech = speeches.get(id);

	response.end(speech);
});

app.delete('/devfest/speech/:id', function(request, response){

	var id = request.params.id;
	speeches.remove(id);

	response.end();
});

app.put('/devfest/speech/:id', function(request, response){

	var id = request.params.id;
	var speech = request.body;
	speeches.update(id, speech);

	response.end();
});

app.post('/devfest/speech', function(request, response){

	var speech = request.body;
	speeches.add(speech);

	response.end();
});

app.listen(8080);
