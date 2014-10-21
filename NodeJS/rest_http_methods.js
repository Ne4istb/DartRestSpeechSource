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

app.get('/devfest/speeches/:id', function(request, response){
	var speech = speeches.get(request.params.id);
	response.end(speech);
});

app.delete('/devfest/speeches/:id', function(request, response){
	speeches.remove(request.params.id);
	response.end();
});

app.put('/devfest/speeches/:id', function(request, response){
	speeches.update(request.params.id, request.body);
	response.end();
});

app.post('/devfest/speeches', function(request, response){
	speeches.add(request.body);
	response.end();
});

app.listen(8080);
