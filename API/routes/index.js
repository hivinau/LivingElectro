var express = require('express');
var router = express.Router();
var request = require('request');
var reader = require('./../helpers/NodeReader');

var parts = [];

request('http://www.livingelectro.com', function(err, res, body) {

    var featuredTracks = reader.readPart(body, 1);
    var featuredMashupsAndBootlegs = reader.readPart(body, 3);
    var part3 = reader.readPart(body, 5);
    var part4 = reader.readPart(body, 7);

    parts.push(featuredTracks);
    parts.push(featuredMashupsAndBootlegs);
    parts.push(part3);
    parts.push(part4);
});

router.get('/', function(req, res, next) {

    res.send(parts);
});

module.exports = router;
