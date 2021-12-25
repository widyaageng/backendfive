var express = require('express');
require('dotenv').config()
var app = express();
var cors = require('cors');
const bodyParser = require('body-parser');
const routerapi = express.Router();

// ---------------- custom middlewares ----------------
//app logger
function appLogger(req, res, next) {
  console.log(`${req.method} ${req.path} - ${req.ip}`);
  next();
}
// ---------------- end of custom middlewares ----------------

// -------------------- utility methods --------------------
// -------------------- end of utility methods --------------------



// -------------------- apply middlewares --------------------
app.use(cors());
app.use('/public', express.static(process.cwd() + '/public'));
app.use(path = '/', middleWareFunction = appLogger);
app.use(path = '/', middleWareFunction = bodyParser.urlencoded({ extended: true }));
app.use(path = '/', middlewareFunction = bodyParser.json());
app.use(path = '/api', routerapi);
// -------------------- end of apply middlewares --------------------

app.get('/', function (req, res) {
    res.sendFile(process.cwd() + '/views/index.html');
});




// ---------------- listener -------------------
const port = process.env.PORT || 3000;
app.listen(port, function () {
  console.log('Your app is listening on port ' + port)
});
