var express = require('express');
require('dotenv').config()
const {format} = require('util')
var cors = require('cors');
const bodyParser = require('body-parser');
const multer = require('multer');
const { Storage } = require('@google-cloud/storage');

// Instantiate a storage client
const storage = new Storage();

var app = express();
const routerapi = express.Router();

// ---------------- custom middlewares ----------------
//app logger
function appLogger(req, res, next) {
  console.log(`${req.method} ${req.path} - ${req.ip}`);
  next();
}
// ---------------- end of custom middlewares ----------------

const bucket = storage.bucket(process.env.GCLOUD_STORAGE_BUCKET);

// -------------------- utility methods --------------------
const upload = multer({
  storage: multer.memoryStorage(),
  limits: {
    fileSize: 1 * 1024 * 1024, // no larger than 1mb
  }
});
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
  console.log(req.body);
  let fileMetadata = {
    name: req.file.originalname,
    type: req.file.mimetype,
    size: req.file.size
  }

  // Create a new blob in the bucket and upload the file data.
  const blob = bucket.file(Date.now() + '_' + req.file.originalname);
  const blobStream = blob.createWriteStream({
    resumable: false,
  });

  blobStream.on('error', err => {
    next(err);
  });

  blobStream.on('finish', () => {
    // The public URL can be used to directly access the file via HTTP.
    const publicUrl = format(
      `https://storage.googleapis.com/${bucket.name}/${blob.name}`
    );
  });

  blobStream.end(req.file.buffer);
  res.json(fileMetadata);
  next();
});


// ---------------- listener -------------------
const port = process.env.PORT || 3000;
app.listen(port, function () {
  console.log('Your app is listening on port ' + port)
});
