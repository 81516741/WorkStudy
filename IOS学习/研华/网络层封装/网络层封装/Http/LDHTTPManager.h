//
//  LDHTTPManager.h
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDHTTPModel.h"
@class AFHTTPSessionManager;
@interface LDHTTPManager : NSObject

+(AFHTTPSessionManager *)sendMessage:(id<LDHTTPModelProtocol>)message success:(void(^)(LDHTTPModel * model)) success failure:(void(^)(LDHTTPModel * model)) failure;

+(BOOL)cancelTaskByTaskDescription:(NSString *)taskDescription;

@end
