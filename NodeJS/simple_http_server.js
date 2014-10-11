var http = require("http");

var server = http.createServer(function(request, response) {
	response.write("Hello from NodeJS!");
	response.end();
});

server.listen(8080);

