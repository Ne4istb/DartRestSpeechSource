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

app.get('/devfest/speeches/:id', function (request, response) {

	var id = request.params.id;
	var speech = speeches.get(id);

	response.setHeader("ETag", "\"" + speech.version + "\"");
	response.setHeader("Access-Control-Allow-Origin", "*");

	response.status(200).send(speech);
});

app.listen(8080);
