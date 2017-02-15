var eventproxy = require('eventproxy');
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
    var my_comments = [];
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

    // 得到一个 eventproxy 的实例
    var ep = new eventproxy();
    var ep1 =new eventproxy();
    // 命令 ep 重复监听 topicUrls.length 次（在这里也就是 40 次） `topic_html` 事件再行动
    ep.after('topic_html', topicUrls.length, function (topics) {
      // topics 是个数组，包含了 40 次 ep.emit('topic_html', pair) 中的那 40 个 pair

      // 开始行动
      var ii = 0;
      topics = topics.map(function (topicPair) {
        // 接下来都是 jquery 的用法了
        var topicUrl = topicPair[0];
        var topicHtml = topicPair[1];
        var $ = cheerio.load(topicHtml);
        var autorHrefF = $('.author_content .user_avatar').eq(0).attr('href');
        var authorHrefO = url.resolve(cnodeUrl, '' + autorHrefF);
        return ({
          title: $('.topic_full_title').text().trim(),
          href: topicUrl,
          comment1: $('.reply_content').eq(0).text().trim()

        });
      });

      console.log('final:');
      console.log(topics);

    });

    topicUrls.forEach(function (topicUrl) {
      superagent.get(topicUrl)
        .end(function (err, res) {
          console.log('fetch ' + topicUrl + ' successful');
          ep.emit('topic_html', [topicUrl, res.text]);
        });
    });
//  下面的代码是我自己写的  用来获取评论第一条的   毕竟是自己第一次写的 可以啦 至少找到了是不
        // for (i = 0; i < 1; i++) {
        //   var topicUrl = topicUrls[i];
        //     superagent.get(topicUrl)
        //     .end(function(err,res){
        //       if (err) {
        //         return console.error(err);
        //       }
        //       var $ = cheerio.load(res.text);
        //
        //       $('#content .cell.reply_area.reply_item .markdown-text p').each(function(idx,element){
        //         var $element = $(element);
        //         if (idx == 0) {
        //           var content = $element.text();
        //         console.log(content);
        //         my_comments.push(content);
        //         }
        //       });
        //     });
        // };


  });
