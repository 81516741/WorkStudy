//
//  BLEManager.h
//  YHTool
//
//  Created by yh on 16/7/27.
//  Copyright © 2016年 yanhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEProtocol.h"

@interface BLEManager : NSObject
/**
 *  需要连接的蓝牙设备的设备名
 */
@property(nonatomic ,copy) NSString * peripheralName;

/*
 *是否开启了蓝牙
 */
@property (nonatomic,assign) BOOL  BLEAvailable;

/*
 *启动
 */
-(void)start;
/*
 *扫描外设
 */
-(void)scanForPeripheralsSuccess:(void(^)())success failure:(void(^)())failure;
/*
 *停止扫描外设
 */
-(void)stopScanForPeripherals;
/**
 *  取消目标外设的连接
 */
-(void)cancelConnectPeripheral;
/**
 *  连接目标外设
 */
-(void)connectPeripheral;

/*
 *写数据
 *成功和失败的block不可以为空，否则回调不了
 */
-(void)writeData:(NSData *)data functionName:(FunctionName)functionName success:(void(^)(DeviceSwitchState state,id obj))success failure:(void(^)())failure;

/*
 *单例
 */
+(instancetype)shareBLE;
@property (nonatomic,strong) NSMutableDictionary * handlers;

@end
