var express = require('express')
  , app     = express();

app.use(express.bodyParser());

app.post('/', function (request, response) {
  console.log(request.body);
  response.send(200);
});

var port = 3000;

app.listen(port, function() {
  console.log("Listening on port " + port);
});
