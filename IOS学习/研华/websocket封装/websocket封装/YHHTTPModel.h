//
//  YHHTTPModel.h
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHHTTPModel;
typedef enum {
    YHHTTPTypePost = 0,
    YHHTTPTypeGet,
    YHHTTPTypeBLE,
    YHHTTPTypeWebSocket
}YHHTTPType;

typedef  void(^ _Nonnull Block)( YHHTTPModel * _Nonnull );
@interface YHHTTPModel : NSObject

/**
 * 请求类型
 */
@property(nonatomic ,assign ) YHHTTPType httpType;
/**
 * 请求参数
 */
@property(nonatomic ,strong ,nonnull) id parameters;
/**
 * 用于请求的url
 */
@property(nonatomic ,copy ,nonnull) NSString * url;
/**
 * 用于取消请求的标记
 */
@property(nonatomic ,assign) int32_t taskTag;
/**
 * 响应数据
 */
@property(nonatomic ,strong ,nullable) id data;
/**
 * 响应数据类型
 */
@property(nonatomic ,strong ,nullable) Class dataClass;
/**
 * AFN返回的error
 */
@property(nonatomic ,strong ,nullable) NSError * errorOfAFN;
/**
 * 自己服务器返回的error
 */
@property(nonatomic ,strong ,nullable) NSString * errorOfMy;

#pragma mark - 下面的是Socket用的
/**
 * 成功回调的block
 */
@property(nonatomic ,copy ,nonnull) Block success;
/**
 * 失败回调的block
 */
@property(nonatomic ,copy) Block failure;

//数据打包和解包
-(void)pack;
- (NSArray * _Nullable)unpack:(NSData *_Nonnull) data;

@property(nonatomic,assign)int32_t srcID;
@property(nonatomic,assign)int32_t dstID;
@property(nonatomic,assign)int32_t flage;
@property(nonatomic,assign)int32_t tag;
@property(nonatomic,assign)int32_t status;
@end

