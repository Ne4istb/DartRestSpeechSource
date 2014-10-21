var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json({ type: 'application/json' }));

var speeches = {
	get: function (id) {
		return {id: id, version: 5};
	},
	update: function (id, data) {
		console.log('data', id, data);
	},
	remove: function (id) {
		console.log('delete', id);
	},
	add: function (data) {
		console.log('data', data);
	}
};

app.get('/devfest/speeches/:id', function (request, response, next) {

	var id = request.params.id;
	var speech = speeches.get(id);

	if (speech)
		response.status(200).send(speech);
	else	{

		var notFound = new Error('Speech is not found');
		notFound.status = 404;

		return next(notFound);
	}
});

app.use(function(error, request, response, next) {

	if(error.status !== 404) return next();

	response.redirect('/error/not_found.html');
});

app.listen(8080);
