//
//  LDHTTPManager.m
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "LDHTTPManager.h"
#import "AFHTTPSessionManager.h"
@implementation LDHTTPManager

static AFHTTPSessionManager * _manager;
+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
    });
}

+(AFHTTPSessionManager *)sendMessage:(id<LDHTTPModelProtocol>)message success:(void (^)(LDHTTPModel *))success failure:(void (^)(LDHTTPModel *))failure
{
    switch (message.httpType) {
        case LDHTTPTypePost:
        
            break;
        case LDHTTPTypeGet:
            
            break;
        case LDHTTPTypeBLE:
            
            break;
        case LDHTTPTypeWebSocket:
            
            break;
            
        default:
            break;
    }
    
    return _manager;
}



+(BOOL)cancelTaskByTaskDescription:(NSString *)taskDescription
{
    for (NSURLSessionDataTask * task in _manager.tasks) {
        if ([task.taskDescription isEqualToString:taskDescription]) {
            [task cancel];
        }
    }
    return YES;
}

@end
