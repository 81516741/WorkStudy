//
//  BLEManager.m
//  蓝牙demo
//
//  Created by yh on 16/8/18.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "BLEManager.h"


//用于监听硬件回调的特征
#define S_UUID [CBUUID UUIDWithString:@"6e400001-b5a3-f393-e0a9-e50e24dcca9e"]//服务的UUID
#define N_UUID [CBUUID UUIDWithString:@"6e400003-b5a3-f393-e0a9-e50e24dcca9e"]//订阅通知特征的UUID
#define W_UUID [CBUUID UUIDWithString:@"6e400002-b5a3-f393-e0a9-e50e24dcca9e"]//写数据特征的UUID

@interface BLEManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>
//信号量相关的，用于控制写完一次数据后才可以写下一次数据
@property (nonatomic,strong) dispatch_queue_t dataSendQueue;
@property (nonatomic,strong) dispatch_semaphore_t semaphore;

@property (nonatomic,assign) int writeLimit;//设备的最大值写入量

@property (nonatomic,strong) CBCentralManager * CBManager;//蓝牙中心管理者

@property (nonatomic,strong) CBPeripheral * peripheralTarget;//目标外设

@property (nonatomic,strong) CBCharacteristic * w_characteristic;//往这个特征写数据
@property (nonatomic,strong) CBCharacteristic * n_characteristic;//订阅的特征，好像没用到

@end

@implementation BLEManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.writeLimit = 20;
        _dataSendQueue = dispatch_queue_create("DataSendQueue", DISPATCH_QUEUE_SERIAL);
        _semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

+(instancetype)shareBLE
{
    static BLEManager * _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [BLEManager new];
    });
    return _manager;
}

#pragma mark - --------------------  写数据  --------------------
-(void)writeData:(NSData *)data
{
    dispatch_async(_dataSendQueue, ^{
        @try{
            LDLog(@"需要写入的数据:%@",data);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"startW" object:nil];
            if (!_peripheralTarget || _peripheralTarget.state == CBPeripheralStateDisconnected){
                LDLog(@"蓝牙已断开连接");
                return;
            }
            
            int sLen = 0;
            while (sLen < data.length) {
                //信号量，用来控制在当前串行队列中，只有上一条数据写完，或者写数据的时间超过200毫秒才会写下一条数据
                dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 200 * NSEC_PER_MSEC));
                LDLog(@"写入每帧数据%d",sLen);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WOne" object:nil];
                if (sLen + _writeLimit <= data.length) {
                    NSData *value = [data subdataWithRange:NSMakeRange(sLen, _writeLimit)];
                    [_peripheralTarget writeValue:value forCharacteristic:_w_characteristic type:CBCharacteristicWriteWithResponse];
                } else {
                    int lLen = (int)data.length - sLen;
                    NSData *value = [data subdataWithRange:NSMakeRange(sLen, lLen)];
                    [_peripheralTarget writeValue:value forCharacteristic:_w_characteristic type:CBCharacteristicWriteWithResponse];
                }
                
                sLen += _writeLimit;
            }
        }@catch(NSException *exception){}
        LDLog(@"数据写完");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WOver" object:nil];
    });
}

#pragma mark - 协议方法
//1-->蓝牙状态回调
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            self.BLEAvailable = YES;
            LDLog(@"😍😍😍开启蓝牙成功");
            break;
        default:
            self.BLEAvailable = NO;
            LDLog(@"😡😡😡开启蓝牙失败");
            break;
    }
    
}

//2-->搜索到外设后的回调
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    LDLog(@"搜索到的外设:%@",peripheral.name);
    //保存所有外设
    if (![self.peripheralList containsObject:peripheral]) {
        [self.peripheralList addObject:peripheral];
        
    }
    //3-->连接指定外设
    if ([peripheral.name  isEqual: self.peripheralName]) {
        self.peripheralTarget = peripheral;
        peripheral.delegate = self;
        [self connectPeripheral];
        LDLog(@"🚀连接外设->%@",peripheral.name);
    }
}
//连接结果
//连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    LDLog(@"😱连接失败%@",error);
    self.deviceIsConnected = NO;
}

//连接成功
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    LDLog(@"👏连接外设成功");
    self.deviceIsConnected = YES;
    if (peripheral == self.peripheralTarget) {
        //4-->搜索指定外设中的服务
        [peripheral discoverServices:@[S_UUID]];
    }
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    LDLog(@"设备断开连接:%@",peripheral.name);
    self.deviceIsConnected = NO;
}
//5-->发现指定外设中的服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    LDLog(@"发现%@中的服务",peripheral.name);
    [peripheral discoverCharacteristics:@[N_UUID,W_UUID] forService:peripheral.services.lastObject];
}
//6-->发现指定外设服务中的特征
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    LDLog(@"发现%@中的特征",peripheral.name);
    CBCharacteristic *characteristic;
    for (characteristic in [service characteristics]) {
        //必须先订阅特征 N_UUID 的通知 ,然后写数据才会有回调
        if (N_UUID && [characteristic.UUID isEqual:N_UUID]) {
            self.n_characteristic = characteristic;
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        } else if (W_UUID && [characteristic.UUID isEqual:W_UUID]) {
            self.w_characteristic = characteristic;
        }
    }
    
}

//7.1-->蓝牙设备返回的数据回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    LDLog(@"❤️接收到数据%@",characteristic.value);
}
//7.2-->订阅通知的回调
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    LDLog(@"😘订阅通知:%@",characteristic.UUID);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BLECANW" object:nil];
}
//这个是监听数据写入成功或者失败的回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
    if (error) {
        LDLog(@"每帧数据写入失败");
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WOneNOOK" object:nil];
    }else{
        LDLog(@"每帧数据写入成功");
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"WOneOK" object:nil];
    }
    dispatch_semaphore_signal(_semaphore);
}

-(void)stopScanForPeripherals
{
    [self.CBManager stopScan];
}

-(void)connectPeripheral
{
    if (self.peripheralTarget && self.peripheralTarget.state != CBPeripheralStateConnected) {
        [self.CBManager connectPeripheral:self.peripheralTarget options:nil];
    }
}

-(void)cancelConnectPeripheral
{
    if (self.peripheralTarget.state == CBPeripheralStateConnected) {
        [self.CBManager cancelPeripheralConnection:self.peripheralTarget];
    }
}


#pragma mark - 外部可用方法
-(void)start
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //用来弹出提示框的
        //NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@(YES)};
        self.CBManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
        
    });
}

-(void)scanForPeripherals
{
    LDLog(@"扫描外设");
    [self stopScanForPeripherals];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(self.BLEAvailable){
            [self.CBManager scanForPeripheralsWithServices:nil options:nil];
        }
    });
}

-(void)connectPeripheral:(CBPeripheral *)peripheral
{
    self.peripheralTarget = peripheral;
    peripheral.delegate = self;
    [self connectPeripheral];
}

#pragma mark - 懒加载
-(NSMutableArray *)peripheralList
{
    if (_peripheralList == nil) {
        _peripheralList = @[].mutableCopy;
    }
    return _peripheralList;
}
@end
