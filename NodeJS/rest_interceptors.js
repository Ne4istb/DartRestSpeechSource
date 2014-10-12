var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.use(bodyParser.json({ type: 'application/json' }));
request.session = {username: ""};

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

app.use(function(request, response, next) {
	console.log('catch');
	if (request.session && request.session.username == "bhj")
		next();
	else
		response.status(401).end();
});

app.get('/devfest/speech/:id', function (request, response, next) {

	var id = request.params.id;
	var speech = speeches.get(id);

	response.status(200).send(speech);
});

app.listen(8080);

//
//@app.Interceptor(r'/devfest/.*', chainIdx: 0)
//loginFilter() {
//	if (app.request.session["username"] == null)
//		app.chain.next();
//	else
//		app.chain.interrupt(statusCode: HttpStatus.UNAUTHORIZED);
//	//or app.redirect("/login.html");
//}
//
//@app.Interceptor(r'/devfest/.*', chainIdx: 1)
//dbConnInterceptor() {
//	var connection = new DbConn();
//	app.request.attributes["dbConn"] = connection;
//	app.chain.next(() => connection.close());
//}