var express = require('express');
require('dotenv').config()

var cors = require('cors');
const bodyParser = require('body-parser');
const multer = require('multer');

var app = express();
const routerapi = express.Router();

// ---------------- custom middlewares ----------------
//app logger
function appLogger(req, res, next) {
  console.log(`${req.method} ${req.path} - ${req.ip}`);
  next();
}
// ---------------- end of custom middlewares ----------------
const storageHandler = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, `${process.cwd()}/temp/img`);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
    cb(
      null,
      file.fieldname === undefined ? 'default': file.fieldname + '-' + uniqueSuffix + '.png'
      );
  }
});

const upload = multer({
  storage: storageHandler
});

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

// -------------------- routes --------------------
app.get('/', function (req, res, next) {
  res.sendFile(process.cwd() + '/views/index.html');
});


routerapi.post('/fileanalyse', upload.single('upfile'), function (req, res, next) {
  // console.log({
  //   size: req.file.size,
  //   name: req.file.originalname,
  //   type: req.file.mimetype
  // });
  let fileMetadata = {
    name: req.file.originalname,
    type: req.file.mimetype,
    size: req.file.size
  }
  res.json(fileMetadata);
  next();
});


// ---------------- listener -------------------
const port = process.env.PORT || 3000;
app.listen(port, function () {
  console.log('Your app is listening on port ' + port)
});
