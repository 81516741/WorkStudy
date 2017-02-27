//
//  BLEManager.m
//  YHTool
//
//  Created by yh on 16/7/27.
//  Copyright © 2016年 yanhua. All rights reserved.
//

#import "BLEManager.h"
@interface BLEManager()<CBCentralManagerDelegate,CBPeripheralDelegate>

//扫描外设后，订阅对应外设通知成功与否的回调
@property (nonatomic,copy) void(^success)();
@property (nonatomic,copy) void(^failure)();

@property (nonatomic, strong) dispatch_source_t timer;//定时器

@property (nonatomic,assign) BOOL  userCancelConnect;//用户主动断开连接

@property (nonatomic,assign) int writeLimit;//设备的最大值写入量

@property (nonatomic,strong) CBCentralManager * CBManager;//蓝牙中心管理者

@property (nonatomic,strong) CBPeripheral * peripheralTarget;//目标外设

@property (nonatomic,strong) NSMutableArray * peripheralList;//所有外设

@property (nonatomic,strong) CBCharacteristic * w_characteristic;//往这个特征写数据
@property (nonatomic,strong) CBCharacteristic * n_characteristic;//订阅的特征，好像没用到

@property (nonatomic,strong) BLEProtocol * protocol;//蓝牙协议对象

//用于监听硬件回调的特征
#define S_UUID [CBUUID UUIDWithString:@"6e400001-b5a3-f393-e0a9-e50e24dcca9e"]//服务的UUID
#define N_UUID [CBUUID UUIDWithString:@"6e400003-b5a3-f393-e0a9-e50e24dcca9e"]//订阅通知特征的UUID
#define W_UUID [CBUUID UUIDWithString:@"6e400002-b5a3-f393-e0a9-e50e24dcca9e"]//写数据特征的UUID

@end

@implementation BLEManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.writeLimit = 20;
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
-(void)writeData:(NSData *)data functionName:(FunctionName)functionName success:(void (^)(DeviceSwitchState,id))success failure:(void (^)())failure
{
    if (success && failure) {
       [self.handlers setObject:@[success,failure] forKey:@(functionName)];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @try{
            YHLog(@"需要写入的数据:%@",data);
            int sLen = 0;
            while (_peripheralTarget) {
                if (sLen + _writeLimit <= data.length) {
                    NSData *value = [data subdataWithRange:NSMakeRange(sLen, _writeLimit)];
                    [_peripheralTarget writeValue:value forCharacteristic:_w_characteristic type:CBCharacteristicWriteWithoutResponse];
                } else {
                    int lLen = (int)data.length - sLen;
                    NSData *value = [data subdataWithRange:NSMakeRange(sLen, lLen)];
                    [_peripheralTarget writeValue:value forCharacteristic:_w_characteristic type:CBCharacteristicWriteWithoutResponse];
                }
                sLen += _writeLimit;
                if (sLen >= data.length) {
                    break;
                }
            }
        }@catch(NSException *exception){}
        YHLog(@"数据写完");
    });
}


#pragma mark - 协议方法
//1-->蓝牙状态回调
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            self.BLEAvailable = YES;
            YHLog(@"😍😍😍开启蓝牙成功");
            break;
        default:
            [self stopGCDTimter];
            self.BLEAvailable = NO;
            YHLog(@"😡😡😡开启蓝牙失败");
            break;
    }
    
}

//2-->搜索到外设后的回调
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    YHLog(@"搜索到的外设:%@",peripheral.name);
    //保存所有外设
    if (![self.peripheralList containsObject:peripheral]) {
        [self.peripheralList addObject:peripheral];
    }
//3-->连接指定外设
    if ([peripheral.name  isEqual: self.peripheralName]) {
        self.peripheralTarget = peripheral;
        peripheral.delegate = self;
        [self connectPeripheral];
    }
}
//连接结果
  //连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    YHLog(@"😱连接失败%@",error);
    [self connectPeripheral];
}

  //连接成功
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    YHLog(@"👏连接外设成功");
    if (peripheral == self.peripheralTarget) {
//4-->搜索指定外设中的服务
        [peripheral discoverServices:@[S_UUID]];
    }
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    YHLog(@"设备断开连接:%@",peripheral.name);
    if (!self.userCancelConnect) {
        [self connectPeripheral];
    }
    self.userCancelConnect = false;
}
//5-->发现指定外设中的服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    YHLog(@"发现%@中的服务",peripheral.name);
    [peripheral discoverCharacteristics:@[N_UUID,W_UUID] forService:peripheral.services.lastObject];
}
//6-->发现指定外设服务中的特征
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    YHLog(@"发现%@中的特征",peripheral.name);
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
    YHLog(@"❤️接收到数据%@",characteristic.value);
    [self.protocol parseDataSegment:characteristic.value];
}
//7.2-->订阅通知的回调
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    YHLog(@"😘订阅通知:%@",characteristic.UUID);
    if (self.success) {
        return;
        self.success();
        self.failure = nil;
        [self stopScanForPeripherals];
    }
}


#pragma mark - 私有方法
-(void)start
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //用来弹出提示框的
        //NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@(YES)};
        self.CBManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
        
    });
}

-(void)scanForPeripheralsSuccess:(void (^)())success failure:(void (^)())failure
{
    [self.CBManager scanForPeripheralsWithServices:nil options:nil];
    self.success = success;
    self.failure = failure;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.failure) {
            self.failure();
            self.success = nil;
            [self stopScanForPeripherals];
        }
    });
}

-(void)stopScanForPeripherals
{
    [self.CBManager stopScan];
}

-(void)connectPeripheral
{
    if (self.peripheralTarget) {
        YHLog(@"🚀连接外设->%@",self.peripheralTarget.name);
        [self.CBManager connectPeripheral:self.peripheralTarget options:nil];
    }
}
-(void)cancelConnectPeripheral
{
    self.userCancelConnect = true;
    if (self.peripheralTarget) {
        [self.CBManager cancelPeripheralConnection:self.peripheralTarget];
    }
}

- (void)startGCDTimter
{
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t interval = (uint64_t)(5.0 * NSEC_PER_SEC);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC));
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        YHLog(@"定时器");
        //需要执行的代码
    });
    
    // 启动定时器
    dispatch_resume(self.timer);
}

-(void)stopGCDTimter
{
    // 取消定时器
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
}

#pragma mark - 懒加载
-(BLEProtocol *)protocol
{
    if (_protocol == nil) {
        _protocol = [BLEProtocol new];
    }
    return _protocol;
}


-(NSMutableDictionary *)handlers
{
    if (_handlers == nil) {
        _handlers = @{}.mutableCopy;
    }
    return _handlers;
}

-(NSMutableArray *)peripheralList
{
    if (_peripheralList == nil) {
        _peripheralList = @[].mutableCopy;
    }
    return _peripheralList;
}
@end
