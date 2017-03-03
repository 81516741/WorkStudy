//
//  LDURLProrocolVC.m
//  html与原生交互
//
//  Created by ld on 16/10/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDURLProrocolVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface LDURLProrocolVC ()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView * webView;
@property (nonatomic,strong) JSContext * context;
@end

@implementation LDURLProrocolVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView * webView  = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    [self loadNetSource];
    
    self.context[@"dfa"] = ^{
        NSLog(@"%@",self);
    };
    
}

-(void)loadNetSource
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://sina.cn/"]]];
}

-(JSContext *)context
{
    if (_context == nil) {
        _context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    }
    return _context;
}

-(void)dealloc
{
    NSLog(@"dealloc -----");
}
@end
