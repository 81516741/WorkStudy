//
//  BLEManager.h
//  蓝牙demo
//
//  Created by yh on 16/8/18.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#ifdef DEBUG
#define LDLog(format, ...) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(format),  ##__VA_ARGS__] );
#else
#define YHLog(format, ...);
#endif

@interface BLEManager : NSObject
#pragma  mark - 属性
/*
 *是否开启了蓝牙
 */
@property (nonatomic,assign) BOOL   BLEAvailable;
/**
 *  设备是否连接
 */
@property(nonatomic ,assign) BOOL   deviceIsConnected;
/**
 *  所有外设
 */
@property (nonatomic,strong) NSMutableArray * peripheralList;
/**
 *  需要连接的蓝牙设备的设备名，这里设置了会自动连接该名的外设
 */
@property(nonatomic ,copy) NSString * peripheralName;

#pragma  mark - 方法
/**
 *  单例
 */
+(instancetype)shareBLE;
/**
 *  创建中心管理者
 */
-(void)start;
/**
 *  写数据
 */
-(void)writeData:(NSData *)data;
/**
 *  扫描外设
 */
-(void)scanForPeripherals;
/**
 *  连接指定外设
 */
-(void)connectPeripheral:(CBPeripheral *)peripheral;

@end
