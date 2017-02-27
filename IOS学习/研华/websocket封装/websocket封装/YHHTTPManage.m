//
//  YHHTTPManage.m
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "YHHTTPManage.h"
#import "AFHTTPSessionManager.h"
#import "SRWebSocket.h"

#define intString(num) [NSString stringWithFormat:@"%d",num]

@interface YHHTTPManage()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)NSMutableArray * tasks;
@property (nonatomic,strong)NSMutableDictionary * blocks;

@end

@implementation YHHTTPManage

static void saveTaskTag(NSURLSessionDataTask *task,int32_t taskTag,NSMutableArray * tasks){
    task.taskDescription = intString(taskTag);
    [tasks addObject:task];
}

#pragma mark - 懒加载
-(NSMutableArray *)tasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
        return _tasks;
    }
    return _tasks;
}

-(NSMutableDictionary *)blocks
{
    if (_blocks == nil) {
        _blocks = [NSMutableDictionary dictionary];
        return _blocks;
    }
    return _blocks;
}

#pragma mark - 单例的初始方法
static YHHTTPManage * _instance;
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark - Socket网络层

-(void)webSocketMessage:(YHHTTPModel *)message success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure
{
    [self webSocketOpen];
    message.success = success;
    message.failure = failure;
    [self.blocks setValue:message forKey:intString(message.taskTag)];
    [message pack];
    if (self.webSocket.readyState != SR_CONNECTING) {
        [self.webSocket send:message.parameters];
    }
}

- (void)webSocketOpen
{
    if (self.webSocket) {
        SRReadyState readyState = self.webSocket.readyState;
        NSLog(@"readyState:%ld",(long)readyState);
        if (readyState == SR_CONNECTING) {
            return;
        }
        else if (readyState == SR_OPEN){
            //停止定时器
            [self.timer invalidate];
            self.timer = nil;
            return;
        }
    }
    [self webSocketClose];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://121.42.145.205:8081/wsentry"]]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (void)webSocketClose {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}
//websocket发送消息
- (void)sendMessage:(YHHTTPModel *)message{
    [message pack];
    if (self.webSocket.readyState != SR_CONNECTING) {
        [self.webSocket send:message.parameters];
    }
}
//websocket收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    YHHTTPModel * response = [YHHTTPModel new];
    NSArray *arrData = [response unpack:message];
    //状态
    char status;
    [[arrData firstObject] getBytes:&status length:sizeof(status)];
    response.status = status;
    if(arrData.count > 1){
        NSString *strJson = [[NSString alloc] initWithData:[arrData lastObject] encoding:NSUTF8StringEncoding];
        NSLog(@"response JSON : %@",strJson);
        id responseData = [NSJSONSerialization JSONObjectWithData:[arrData lastObject]  options:0 error:nil];
        response.data = responseData;
    }
}
//websocket打开成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Websocket Connected");
    YHHTTPModel *getMsg = [YHHTTPModel new];
    getMsg.tag = 0x5759;
    self.websocketFailedOrNOT = NO;
    //关闭定时器
    [self.timer invalidate];
    self.timer = nil;
}

//websocket打开失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"webSocket didFailWithError:%@",error);
    // 与服务器断开连接，就发通知给 首页，使得按钮一按，就提示 与服务器断开连接，不进入登录页
    self.websocketFailedOrNOT = YES;
    // 重连 用定时器，每隔5秒连一次
    [self.timer invalidate];
    self.timer = nil;
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(openAgain) userInfo:nil repeats:YES];
}

- (void)openAgain
{
    //关闭定时器
    NSLog(@":( Websocket Failed With Error ");
    [self.timer invalidate];
    self.timer = nil;
    [self webSocketOpen];
}
//websocket关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"WebSocket closed");
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    NSLog(@"Websocket received pong");
}

#pragma mark - http网络层
-(void)sendMessage:(YHHTTPModel *)message success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure
{
    switch (message.httpType) {
            
        case YHHTTPTypeGet:
            [self getMessage:message success:success failure:failure];
            break;
            
        case YHHTTPTypePost:
            [self postMessage:message success:success failure:failure];
            break;
            
        case YHHTTPTypeBLE:
            
            break;
        case YHHTTPTypeWebSocket:
            [self webSocketMessage:message success:success failure:failure];
            break;
            
        default:
            [self webSocketMessage:message success:success failure:failure];
            break;
    }

}


-(void)getMessage:(YHHTTPModel *)message success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure
{
    saveTaskTag([[AFHTTPSessionManager manager] GET:message.url parameters:message.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        message.data = responseObject;
        success(message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        message.errorOfAFN = error;
        failure(message);
    }], message.taskTag, self.tasks);
    
}

-(void)postMessage:(YHHTTPModel *)message success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure
{
    saveTaskTag([[AFHTTPSessionManager manager] POST:message.url parameters:message.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        message.data = responseObject;
        success(message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        message.errorOfAFN = error;
        failure(message);
    }], message.taskTag, self.tasks);
}


-(void)cancelTaskByTaskTag:(int32_t)taskTag
{
    NSMutableArray * needRemoveTasks = [NSMutableArray array];
    for (NSURLSessionDataTask * task in self.tasks) {
        if ([task.taskDescription isEqualToString:intString(taskTag)]) {
            [needRemoveTasks addObject:task];
            [task cancel];
        }
    }
    [self.tasks removeObjectsInArray:needRemoveTasks];
}

@end
