//
//  LDURLProtocol.m
//  html与原生交互
//
//  Created by ld on 16/10/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDURLProtocol.h"
@interface LDURLProtocol()<NSURLConnectionDelegate>

@property (nonatomic,strong) NSURLConnection * connection;

@end
@implementation LDURLProtocol

//2.2.1、是否进入自定义的NSURLProtocol加载器

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    NSLog(@"canInitWithRequest url-->%@",request.URL.absoluteString);
    
    //看看是否已经处理过了，防止无限循环
    if ([NSURLProtocol propertyForKey:@"dd" inRequest:request]) {
        return NO;
    }
    
    NSString *urlString = request.URL.absoluteString;
    if([urlString isEqualToString:@"https://sina.cn/"]){
        return YES;
    }
    
    return NO;
}

//2.2.2、重新设置NSURLRequest的信息
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}


//2.2.3、这个方法主要是用来判断两个request是否相同，如果相同的话可以使用缓存数据，通常调用父类的实现即可

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

//2.2.4、被拦截的请求开始执行的地方
- (void)startLoading{
    NSMutableURLRequest * request = [self.request mutableCopy];
    
    // 标记当前传入的Request已经被拦截处理过，
    //防止在最开始又继续拦截处理
    [NSURLProtocol setProperty:@(YES) forKey:@"dd" inRequest:request];
    
    self.connection = [NSURLConnection connectionWithRequest:[self changeSinaToSohu:request] delegate:self];
    
}
//把所用url中包括sina的url重定向到sohu
- (NSMutableURLRequest *)changeSinaToSohu:(NSMutableURLRequest *)request{
    NSString *urlString = request.URL.absoluteString;
    if ([urlString isEqualToString:@"https://sina.cn/"]) {
        urlString = @"https://sina.cn/";
        request.URL = [NSURL URLWithString:urlString];
    }
    return request;
}
//2.2.5、结束加载URL请求
- (void)stopLoading{
   
}
//2.3、NSURLProtocolClient中的几个方法
//请求重定向
- (void)URLProtocol:(NSURLProtocol *)protocol wasRedirectedToRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    
}

// 响应缓存是否合法
- (void)URLProtocol:(NSURLProtocol *)protocol cachedResponseIsValid:(NSCachedURLResponse *)cachedResponse
{
    
}

//刚接收到Response信息
- (void)URLProtocol:(NSURLProtocol *)protocol didReceiveResponse:(NSURLResponse *)response cacheStoragePolicy:(NSURLCacheStoragePolicy)policy
{
    
}

//数据加载成功
- (void)URLProtocol:(NSURLProtocol *)protocol didLoadData:(NSData *)data
{
    
}

//数据完成加载
- (void)URLProtocolDidFinishLoading:(NSURLProtocol *)protocol
{
    
}

//数据加载失败
- (void)URLProtocol:(NSURLProtocol *)protocol didFailWithError:(NSError *)error
{
    
}

//为指定的请求启动验证
- (void)URLProtocol:(NSURLProtocol *)protocol didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

//为指定的请求取消验证
- (void)URLProtocol:(NSURLProtocol *)protocol didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}


//3.6、因为新建了一个NSURLConnection *connection，所以要实现他的代理方法，如下

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}


@end
