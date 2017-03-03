//
//  ViewController.m
//  html与原生交互
//
//  Created by ld on 16/10/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebViewVC.h"
#import "LDURLProrocolVC.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView * webView;

@property (nonatomic,strong) JSContext * context;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html" inDirectory:@"html"];
    NSLog(@"%@",path);
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    //这两种方式都可以加载，而且可以读取外部js
    NSString * htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:path]];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[request.URL scheme] isEqualToString:@"bridge"]) {
        NSLog(@"有数据了，配置本地的html");
    }
    
    if ([[request.URL scheme] isEqualToString:@"bridge1"]) {
        NSLog(@"有人点击了btn");
    }
    
    if ([[request.URL scheme] isEqualToString:@"jianjie"]) {
        NSLog(@"间接调用原生");
    }
    
    if ([[request.URL scheme] isEqualToString:@"yuansheng"]) {
        NSLog(@"原生直接掉js的方法，然后js又从这里回来");
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //替换html原来的方法
    self.context[@"ocMethod"] = ^{
        NSLog(@"方法被原生替换");
    };
    self.context[@"unMethod"] = ^{
        NSLog(@"方法被原生替换,且该方法不存在");
    };
    
    //这样的方法是替换不了的
    self.context[@"ocMethod1"] = ^{
        NSLog(@"这个是无法替换的");
    };
    
    //间接调用原生
    [self.context evaluateScript:@"\
     document.getElementById('add_method0').onclick = \
        function(){\
            bridgeCall('jianjie://myhtml');\
        };\
     "];
    
    //直接调用原生  通过context可以给webview里面的 id = add_method 添加方法
    __weak typeof(self) selfWeak = self;
    self.context[@"dynamicChange"] = ^{
        NSLog(@"通过id直接条用原生成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfWeak.navigationController pushViewController:[WKWebViewVC new] animated:true];
        });
    };
    [self.context evaluateScript:@"document.getElementById('add_method').onclick = dynamicChange;"];
    
    //原生直接调用html 的 bridgeCall
    //通过加载本地文件  也可以加载网络资源  很灵活
    NSString * path = [[NSBundle mainBundle] pathForResource:@"my_js" ofType:@"js" inDirectory:@"html"];
    NSString * jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.context evaluateScript:jsStr];

}


-(JSContext *)context
{
    if (_context == nil) {
        _context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}
- (IBAction)jump:(id)sender
{
    [self.navigationController pushViewController:[LDURLProrocolVC new] animated:true];
}

@end
