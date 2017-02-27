//
//  YHHTTPManage.h
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHHTTPModel.h"
@class AFHTTPSessionManager;
@interface YHHTTPManage : NSObject

+(instancetype)shared;
-(void)sendMessage:(YHHTTPModel *)messagemessage success:(void(^)(YHHTTPModel * model)) success failure:(void(^)(YHHTTPModel * model)) failure;
-(void)cancelTaskByTaskTag:(int32_t)taskTag;

- (void)webSocketClose;
- (void)webSocketOpen;
@property (nonatomic, assign) BOOL websocketFailedOrNOT;


@end
