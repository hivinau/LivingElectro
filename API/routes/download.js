var express = require('express');
var router = express.Router();
var request = require('request');
var reader = require('./../helpers/NodeReader');

router.get('/:url(media/[0-9]{4}/[0-9a-zA-Z_-]+/$)', function(req, response, next) {

    if(req.params.hasOwnProperty('url')) {

        var url = req.params['url'];

        request('http://www.livingelectro.com/' + url, function(err, res, body) {

            reader.readDownloadLink(body, function (song) {

                response.send({ 'song': song });
            })
        });
    }
});

module.exports = router;
