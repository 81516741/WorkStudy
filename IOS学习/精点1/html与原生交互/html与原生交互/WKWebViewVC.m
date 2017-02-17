//
//  WKWebViewVC.m
//  html与原生交互
//
//  Created by ld on 16/10/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
#warning ios8中读取不了外部的js，内部js可以,用config注入js代码也没用
@interface WKWebViewVC ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,weak)  WKWebView * webView;
@property (nonatomic,strong) WKWebViewConfiguration *  config;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatWebView];
    [self loadLocalHtml];

}

-(void)creatWebView
{
    //配置js与oc交互的对象
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    [config.userContentController addScriptMessageHandler:self name:@"lingda"];
    
    //为html加入一段js
    NSString * scriptPath = [[NSBundle mainBundle]pathForResource:@"js" ofType:@"js" inDirectory:@"html"];
    WKUserScript * script = [[WKUserScript alloc]initWithSource:scriptPath injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:true];
    [config.userContentController addUserScript:script];
    
    
    WKWebView * webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds configuration:config];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
}

-(void)loadNetSource
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

-(void)loadLocalHtml
{
    //获取文件夹路径
    NSString * path = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html" inDirectory:@"html"];
    
    if(path){
        NSString * htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:path]];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '300%'" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
    

    //直接调用原生  通过context可以给webview里面的 id = add_method 添加方法
    //这里js 也发出了一个通知 messageHandlers可以收到
    [self.webView evaluateJavaScript:@"\
     document.getElementById('add_method')\
     .onclick = function(){\
            alert('这种方式是替换不了的');\
     document.getElementById('add_method').style\
     .backgroundColor = 'red';\
     \
     var message = {\
     'method' : 'hello',\
     'param1' : 'liuyanwei',\
     };\
    window.webkit.messageHandlers.lingda.postMessage(message);\
     };\
     "
                   completionHandler:nil];

}
//拦截 aler  Confirm  prompt
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"有个弹框被拦截了");
    completionHandler();
}

//是否加载某个url
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL * url = navigationAction.sourceFrame.request.URL;
    //这个决定是否加载
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

//接受 js端 发出的通知
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@",message.body);
}

@end
