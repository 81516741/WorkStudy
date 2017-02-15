var async = require('async');
var superagent = require('superagent');
var cheerio = require('cheerio');
// url 模块是 Node.js 标准库里面的
// http://nodejs.org/api/url.html
var url = require('url');

var cnodeUrl = 'https://cnodejs.org/';

superagent.get(cnodeUrl)
.end(function (err, res) {
    if (err) {
        return console.error(err);
    }
    var topicUrls = [];
    var titles = [];
    var $ = cheerio.load(res.text);
    // 获取首页所有的链接
    $('#topic_list .topic_title').each(function (idx, element) {
        var $element = $(element);
        // $element.attr('href') 本来的样子是 /topic/542acd7d5d28233425538b04
        // 我们用 url.resolve 来自动推断出完整 url，变成
        // https://cnodejs.org/topic/542acd7d5d28233425538b04 的形式
        // 具体请看 http://nodejs.org/api/url.html#url_url_resolve_from_to 的示例
        var href = url.resolve(cnodeUrl, $element.attr('href'));
        topicUrls.push(href);
        titles.push($element.attr('title'));
    });

    console.log(topicUrls);
    console.log(titles);

    // 得到 topicUrls 之后
    async.mapLimit(topicUrls, 5, function (url, callback) {

        superagent.get(url)
        .end(function (err, res) {
            console.log('fetch ' + url + ' successful');
            var $ = cheerio.load(res.text);
            callback(null, {
            title: $('.topic_full_title').text().trim(),
            href: url,
            comment1: $('.reply_content').eq(0).text().trim()
            });
        });

    }, function (err, result) {
        console.log('final:');
        console.log(result);
    });

});
