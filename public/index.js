var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.sendFile(__dirname + '/views/visitor/index.html');
});

router.get('/leaving', function(req, res, next) {
  res.sendFile(__dirname + '/views/visitor/leaving.html');
});

router.get('/register', function(req, res, next) {
  res.sendFile(__dirname + '/views/visitor/register.html');
});

router.get('/paycheck/:carnum', function(req, res, next) {
  res.sendFile(__dirname + '/views/visitor/paycheck.html');
});

router.get('/outcar/:carnum', function(req, res, next) {
  res.sendFile(__dirname + '/views/visitor/outcar.html');
});

/* admin */
router.get('/admin', function(req, res, next) {
  res.sendFile(__dirname + '/views/admin/index.html');
});

router.get('/admin/parking', function(req, res, next) {
  res.sendFile(__dirname + '/views/admin/parking.html');
});

router.get('/admin/parkingspots', function(req, res, next) {
  res.sendFile(__dirname + '/views/admin/parkingspots.html');
});

router.get('/admin/payment', function(req, res, next) {
  res.sendFile(__dirname + '/views/admin/payment.html');
});

router.get('/admin/statistics', function(req, res, next) {
  res.sendFile(__dirname + '/views/admin/statistics.html');
});

router.get('/config', function(req, res, next) {
  res.sendFile(__dirname + '/config.js');
});


module.exports = router;
