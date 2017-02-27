//
//  BLEProtocol.h
//  YHTool
//
//  Created by yh on 16/7/27.
//  Copyright © 2016年 yanhua. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define YHLog(format, ...) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(format),  ##__VA_ARGS__] );
#else
#define YHLog(format, ...);
#endif


typedef enum {
    DeviceSwitchStateOFF = 0,//开
    DeviceSwitchStateOn = 1,//关
    DeviceSwitchStateDelete = 2,//删除
    DeviceSwitchStateNone = 3,//无
}DeviceSwitchState;

typedef enum {
    OperationStateFailure = 0,//失败
    OperationStateSuccess = 1,//成功
    OperationStateNone = 2,//无
    
}OperationState;

typedef enum {
    FunctionNameMatchData       = 0,              //数据匹配功能ID
    FunctionNameLockCar         = 1,              //锁车提示功能ID
    FunctionNameBackMirror      = 2,              //后视镜控制功能ID
    FunctionNameAirWindow       = 3,              //天窗控制功能ID
    FunctionNameDoorLock        = 4,              //主驾驶门锁功能ID
    FunctionNameReset           = 5,              //复位功能ID
    
    FunctionNameVersion         = 6,              //查询版本号
    FunctionNameDeviceID        = 7,              //查询设备ID
}FunctionName;

typedef void(^SuccessBlock)(DeviceSwitchState,id);
typedef void(^FailureBlock)();

@interface BLEProtocol : NSObject

#pragma mark - 解析数据
/**
 *  解析数据片段，去掉数据的头，尾，长度
 */
-(void)parseDataSegment:(NSData*)data;

#pragma mark - 打包数据
/**
 *  打包查询版本数据
 */
+(NSData *)packCheckVersionData;
/**
 *  打包握手数据
 */
+(NSData *)packHandShakeData;
/**
 *  打包功能数据
 */
+(NSData *)packFunctionDataWithCMD:(DeviceSwitchState)switchState functionID:(FunctionName)functionName;
/**
 *  最后写入蓝牙时需要统一拼接的数据（头，尾，长度）
 */
+(NSData *)appendBLEHeadAndEndWithData:(NSData *)srcData;

#pragma mark - 工具类方法
+ (Byte)calCheckSum:(const Byte*)data Offset:(const int)offset Length:(const int)len;
+ (NSString*)hexStringValueOfData:(NSData *)data;

@end
