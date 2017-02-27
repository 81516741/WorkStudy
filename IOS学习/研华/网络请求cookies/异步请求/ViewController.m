//
//  ViewController.m
//  异步请求
//
//  Created by yh on 16/8/18.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setCookies];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    NSLog(@"%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies]);
}

#pragma mark - cookies
//设置cookies
-(void)setCookies
{
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"zenglingda" forKey:NSHTTPCookieName];// token名
    [cookieProperties setObject:@"zld_CookieValue" forKey:NSHTTPCookieValue];// token值
    [cookieProperties setObject:@"zld_cookiesDomain" forKey:NSHTTPCookieDomain];// 域
    [cookieProperties setObject:@"zld_cookiesURL" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/none" forKey:NSHTTPCookiePath];// 路径
    [cookieProperties setObject:@"8888" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}

//清空cookies
-(void)clearCookies
{
    NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray * cookies = [cookieStorage cookies];
    for (NSHTTPCookie * cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    NSLog(@"%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
}

#pragma mark - 同步请求
-(void)requestBySync
{
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/users/coolnameismy"]];
    NSURLResponse *resp; NSError *err;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    NSLog(@"====请求开始====");
    
    //检查错误
    if (err) {
        NSLog(@"%@",err);
        NSLog(@"==resq====%@",resp);
        return;
    }
    
    //检验状态码
    if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
        if (((NSHTTPURLResponse *)resp).statusCode != 200) {
            return;
        }
    }
    
    //解析json
    NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err ]);
    
    NSLog(@"====请求结束====");
}

#pragma mark -异步队列请求
-(void)requestByAsyncQueue
{
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/users/coolnameismy"]];
    NSURLResponse *resp;
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    //发送异步请求
    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //检查错误
        if (connectionError) {
            NSLog(@"%@",connectionError);
            NSLog(@"==resq====%@",resp);
            return;
        }
        
        //检验状态码
        if ([resp isKindOfClass:[NSHTTPURLResponse class]]) {
            if (((NSHTTPURLResponse *)resp).statusCode != 200) {
                return;
            }
        }
        //解析json
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ]);
        
        NSLog(@"====请求结束====");
    }];
    
    NSLog(@"====请求开始1====");
}

#pragma mark - 异步请求
- (void)nornalHttpRequest
{
    NSString *urlString = @"http://www.51job.com/?from=baidupz";
    //stringByAddingPercentEncodingWithAllowedCharacters URLQueryAllowedCharacterSet主要用于url查询字符串编码
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    //发出request
    [connection start];
}

//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"=================didFailWithError=================");
    NSLog(@"error:%@",error);
}

//重定向
- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response
{
    NSLog(@"=================request redirectResponse=================");
    NSLog(@"request:%@",request);
    return request;
}

//接收响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"=================didReceiveResponse=================");
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    NSLog(@"response:%@",resp);
}

//接收响应
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"=================didReceiveData=================");
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"data:%@",dic);
}


//完成请求
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"=================connectionDidFinishLoading=================");
}



//https请求-github获取用户信息
- (void)githubUserInfo{
    //string 转 url编码
    NSString *urlString = @"https://api.github.com/users/coolnameismy";
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}

//https认证
-(BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    NSLog(@"=================connectionShouldUseCredentialStorage=================");
    return true;
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"=================willSendRequestForAuthenticationChallenge=================");
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        NSLog(@"是服务器信任的证书:%@",challenge.protectionSpace.authenticationMethod);
        //通过认证
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
}
@end
