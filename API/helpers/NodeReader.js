var io = require('cheerio');

var reader =  {

    readPart: function(body, index) {

        var $ = io.load(body);

        var part = { };
        var title = '';
        var items = [];

        $('#divMiddleList > div:nth-child(' + index + ')').each(function (index, object) {

            title = $(object).find('span.brand').text();
        });

        $('#divMiddleList > div:nth-child(' + (++index)  + ') > div.song_item').each(function (index, object) {

            var image = $(object).find('div.song_item_img > a > img').attr('src') || $(object).find('div.song_item_img > img').attr('src');
            var title = $(object).find('div.song_item_title > a').text();
            var link = $(object).find('div.song_item_title > a').attr('href');
            var artiste = $(object).find('div.song_item_artist > a').text();
            var tag = $(object).find('div.song_item_tag > a').text();
            var song = $(object).find('div.song_item_playa > div.playa').attr('rel') || '';

            var item = {
                'link': 'http://www.livingelectro.com/' + link,
                'image': 'http://www.livingelectro.com/' + image,
                'title': title,
                'artiste': artiste,
                'tag': tag,
                'song': song
            };

            items.push(item);
        });

        part[title] = items;

        return part;
    },

    readDownloadLink: function (body, completion) {

        var $ = io.load(body);

        $('div.song_download_link').each(function (index, object) {

            var song = $(object).find('a').attr('href');

            completion(song);
        });
    }
};

module.exports = reader;
