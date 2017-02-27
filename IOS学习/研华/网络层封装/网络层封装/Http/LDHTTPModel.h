//
//  LDHTTPModel.h
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LDHTTPTypePost = 0,
    LDHTTPTypeGet,
    LDHTTPTypeBLE,
    LDHTTPTypeWebSocket
}LDHTTPType;

@protocol LDHTTPModelProtocol <NSObject>
/**
 * 请求类型
 */
@property(nonatomic ,assign) LDHTTPType httpType;
/**
 * 请求参数
 */
@property(nonatomic ,strong) id parameters;
/**
 * 响应数据
 */
@property(nonatomic ,strong) id data;
/**
 * 用于取消请求的标记
 */
@property(nonatomic ,copy) NSString * taskDescription;
@end

@interface LDHTTPModel : NSObject<LDHTTPModelProtocol>

@property(nonatomic ,assign) LDHTTPType httpType;
@property(nonatomic ,strong) id parameters;
@property(nonatomic ,strong) id data;
@property(nonatomic ,copy) NSString * taskDescription;

@end
