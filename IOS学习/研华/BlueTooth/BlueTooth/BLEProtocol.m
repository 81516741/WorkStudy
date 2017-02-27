//
//  BLEProtocol.m
//  YHTool
//
//  Created by yh on 16/7/27.
//  Copyright © 2016年 yanhua. All rights reserved.
//

#import "BLEProtocol.h"

#import "BLEManager.h"

#define HEAD_B  [@"<H>" dataUsingEncoding:NSUTF8StringEncoding]
#define END_B   [@"<E>" dataUsingEncoding:NSUTF8StringEncoding]

//--------------------（所有公用的）--------------------
static const int SIDLength = 1;
static const int LengthDataLength = 4;
static const int CheckSumDataLength = 1;

//--------------------查询版本号  和 设备ID 需要用到的--------------------
#define VERINFO     [@"VERINFO" dataUsingEncoding:NSUTF8StringEncoding]
#define CONNSERVER  [@"CONNSERVER" dataUsingEncoding:NSUTF8StringEncoding]
static const Byte SID_V_H = 0x3E;

static const int VERINFOLength = 7;             //查询版本，填充字符串 “VERINFO” 的长度
static const int VersionDataLength = 28;        //查询版本，蓝牙设备返回的功能数据的长度
static const int CONNDEVICELength = 10;         //查询设备ID，字符串 “CONNSERVER” 的长度
static const int DEVICEIDLength = 16;           //查询设备ID,蓝牙返回 设备id 的长度
static const int DeviceIDDataLength = 27;       //查询设备ID,蓝牙设备返回的功能数据的长度

//--------------------功能数据公用的--------------------
static const Byte SID_M_D_P = 0x2F;             //功能数据发给蓝牙设备的SID
static const Byte SID_M_D_D = 0x6F;            //蓝牙设备回复的SID
static const Byte CMD_ON = 0x0F;               //开启
static const Byte CMD_OFF = 0x00;              //关闭
static const Byte CMD_DEL = 0x08;              //删除

static const int CMDLength = 1;                 //开关状态的长度（开，关，删除）
static const int StatusDataLength = 1;          //状态数据长度（成功 失败）
static const int FunctionIDLength = 2;          //功能数据长度(区分此命令是做什么的，锁车，天窗)
static const int FunctionDataLength = SIDLength + FunctionIDLength + CMDLength + StatusDataLength;//功能数据长度

//--------------------数据匹配需要用到的--------------------
static const short ID_M_D   = 0x444D;                   //数据匹配功能ID
static const short ID_L_C   = 0x5457;                   //锁车提示功能ID
static const short ID_B_M   = 0x4D42;                   //后视镜控制功能ID
static const short ID_A_W   = 0x5253;                   //天窗控制功能ID
static const short ID_D_L   = 0x4444;                   //主驾驶门锁功能ID
static const short ID_R     = 0x5352;                   //复位功能ID

@interface BLEProtocol ()

@property (nonatomic,strong) NSDate * receiveDataTime;
@property (nonatomic,strong) NSMutableData * receiveData;

@end

@implementation BLEProtocol

#pragma mark - 解析数据的公共入口
- (void)parseDataSegment:(NSData*)data
{
    if (!data || data == NULL || data.length == 0) {
        YHLog(@"蓝牙数据为--NULL");
        return;
    }
    //判断2次接收到的数据是否超时
//    if (_receiveDataTime && [_receiveDataTime timeIntervalSinceNow] <= -1.0l) {
//        YHLog(@"接收到2段数据的时间间隔过大，则判定本次接收数据失败");
//        [self finishParse];
//        return;
//    }
    if (self.receiveData.length <= 0) {
        NSRange rangH = [data rangeOfData:HEAD_B options:0 range:NSMakeRange(0, data.length)];
        if (rangH.length > 0) {
            int from = (int)(rangH.location + rangH.length);
            [self.receiveData appendData:[data subdataWithRange:NSMakeRange(from, data.length - from)]];
            if (self.receiveData.length >=LengthDataLength) {
                self.receiveData = [self.receiveData subdataWithRange:NSMakeRange(LengthDataLength, self.receiveData.length - LengthDataLength)].mutableCopy;
            }else{
                return;
            }
            self.receiveDataTime = [NSDate date];
        }
        NSRange rangE = [data rangeOfData:END_B options:0 range:NSMakeRange(0, data.length)];
        if (rangE.length > 0) {
            NSData * rdata = [self.receiveData subdataWithRange:NSMakeRange(0, self.receiveData.length - rangE.length)];
            [self parseData:(Byte *)rdata.bytes srcData:rdata];
            [self finishParse];
        }
    } else {
        [self.receiveData appendData:data];
        self.receiveDataTime = [NSDate date];
        NSRange rang = [self.receiveData rangeOfData:END_B options:0 range:NSMakeRange(0, self.receiveData.length)];
        if (rang.length > 0) {
            NSData *rdata = [self.receiveData subdataWithRange:NSMakeRange(0, rang.location)];
            YHLog(@"蓝牙--结果%@",rdata);
            [self parseData:(Byte *)rdata.bytes srcData:rdata];
            [self finishParse];
            return;
        }
        if (self.receiveData.length > 1024) {
            YHLog(@"蓝牙--数据长度溢出 %@ %lu",self.receiveData,(unsigned long)self.receiveData.length);
            [self finishParse];
        }
    }
}
-(void)parseData:(Byte*)bytes srcData:(NSData *)data
{
    YHLog(@"开始解析的数据")
    
    Byte byte = 0x00;
    [data getBytes:&byte length:1];
    
    switch (byte) {
        case SID_V_H:
            YHLog(@"查版本或设备ID的SID");
            [self judgeParseVersionOrHandShake:data];
            break;
        case SID_M_D_D:
        {
            YHLog(@"功能SID");
            [self parseFunctionData:data];
            break;
        }
        default:
            break;
    }
}

//block回调
-(void)callBackBlock:(FunctionName)functionName  cmdEnum:(DeviceSwitchState)cmdEnum obj:(id)obj status:(Byte)status
{
    NSArray * handlers = [[BLEManager shareBLE].handlers objectForKey:@(functionName)];
    SuccessBlock success = handlers[0];
    FailureBlock failure = handlers[1];
    if (status == 1 && success) {
        success(cmdEnum,obj);
    }else if(failure){
        failure();
    }
}

//判断是该数据是查询 版本 还是查询 设备ID
-(void)judgeParseVersionOrHandShake:(NSData *)data
{
    NSData * VERINFOData = [data subdataWithRange:NSMakeRange(SIDLength, VERINFOLength)];
    NSString * VERINFOStr = [[NSString alloc]initWithData:VERINFOData encoding:NSUTF8StringEncoding];
    NSData * CONNDEVICEData = [data subdataWithRange:NSMakeRange(SIDLength, CONNDEVICELength)];
    NSString * CONNDEVICEStr = [[NSString alloc]initWithData:CONNDEVICEData encoding:NSUTF8StringEncoding];
    if ([VERINFOStr  isEqual: @"VERINFO"]) {
        YHLog(@"该数据为查询版本号");
        [self parseVersion:data];
    }else if([CONNDEVICEStr  isEqual: @"CONNDEVICE"]){
        YHLog(@"该数据为查询设备ID");
        [self parseHandShake:data];
    }

}
-(void)finishParse
{
    self.receiveData = [NSMutableData dataWithCapacity:0];
    self.receiveDataTime = nil;
}

#pragma mark - 解析数据
//解析功能数据
-(void)parseFunctionData:(NSData *)data
{
    //校验和
    BOOL dataAvailable = [BLEProtocol checkData:data position:FunctionDataLength];
    if(!dataAvailable){
        return;
    }
    //功能类型：开窗，锁门等
    short funTypeData ;
    [data getBytes:&funTypeData range:NSMakeRange(SIDLength, FunctionIDLength)];
    Byte cmd;     //设备状态  开   关
    Byte status;  //操作状态  成功 失败
    [data getBytes:&cmd range:NSMakeRange(SIDLength + FunctionIDLength, CMDLength)];
    [data getBytes:&status range:NSMakeRange(SIDLength + FunctionIDLength + CMDLength, StatusDataLength)];
    
    DeviceSwitchState cmdEnum = [BLEProtocol enumWithCMD:cmd];
    
    switch (funTypeData) {
        case ID_M_D:
        {
            YHLog(@"数据匹配");
            [self callBackBlock:FunctionNameMatchData cmdEnum:cmdEnum obj:nil status:status];
            break;
        }
        case ID_B_M:
        {
            YHLog(@"后视镜");
            [self callBackBlock:FunctionNameBackMirror cmdEnum:cmdEnum obj:nil status:status];
            break;
        }
        case ID_A_W:
        {
            YHLog(@"天窗");
            [self callBackBlock:FunctionNameAirWindow cmdEnum:cmdEnum obj:nil status:status];
            break;
        }
        case ID_D_L:
        {
            YHLog(@"门锁");
            [self callBackBlock:FunctionNameDoorLock cmdEnum:cmdEnum obj:nil status:status];
            break;
        }
        case ID_L_C:
        {
            YHLog(@"锁车");
            [self callBackBlock:FunctionNameLockCar cmdEnum:cmdEnum obj:nil status:status];
            break;
        }
        case ID_R:
        {
            YHLog(@"复位");
            [self callBackBlock:FunctionNameReset cmdEnum:cmdEnum obj:nil status:status];
            break;
        }
        default:
            break;
    }
}

-(void)parseVersion:(NSData *)data
{
    //验证数据有效性
    BOOL dataAvailable = [BLEProtocol checkData:data position:VersionDataLength];
    if (!dataAvailable) {
        return;
    }
    //CT 序列号
    int position = SIDLength + VERINFOLength;
    int CT = 0;
    [data getBytes:&CT range:NSMakeRange(position, sizeof(int))];
    position += sizeof(int);
    //MHV 硬件PCB号
    int MHV = 0;
    [data getBytes:&MHV range:NSMakeRange(position, sizeof(int))];
    position += sizeof(int);
    NSData * MHVData = [NSData dataWithBytes:&MHV length:sizeof(int)];
    NSString * MHVstr = [BLEProtocol hexStringValueOfData:MHVData];
    //MSV 云控版本
    int MSV = 0;
    [data getBytes:&MSV range:NSMakeRange(position, sizeof(int))];
    position += sizeof(int);
    NSData * MSVData = [NSData dataWithBytes:&MSV length:sizeof(int)];
    NSString * MSVstr = [BLEProtocol hexStringValueOfData:MSVData];

    //FHV FPGA硬件
    int FHV = 0;
    [data getBytes:&FHV range:NSMakeRange(position, sizeof(int))];
    position += sizeof(int);
    NSData * FHVData = [NSData dataWithBytes:&FHV length:sizeof(int)];
    NSString * FHVstr = [BLEProtocol hexStringValueOfData:FHVData];
    //FSV FPGA软件
    int FSV = 0;
    [data getBytes:&FSV range:NSMakeRange(position, sizeof(int))];
    //position += sizeof(int);
    NSData * FSVData = [NSData dataWithBytes:&FSV length:sizeof(int)];
    NSString * FSVstr = [BLEProtocol hexStringValueOfData:FSVData];
    
    YHLog(@"CT:%d-MHVstr:%@-MSVstr:%@-FHVstr:%@-FSVstr:%@",CT,MHVstr,MSVstr,FHVstr,FSVstr);
    [self callBackBlock:FunctionNameVersion cmdEnum:DeviceSwitchStateNone obj:FHVstr status:OperationStateSuccess];
}

-(void)parseHandShake:(NSData *)data
{
    //验证数据有效性
    BOOL dataAvailable = [BLEProtocol checkData:data position:DeviceIDDataLength];
    if (!dataAvailable) {
        return;
    }
    //DEVICE_ID 设备ID
    int position = SIDLength + CONNDEVICELength;
    NSData * device_id = [data subdataWithRange:NSMakeRange(position, DEVICEIDLength)];
    YHLog(@"设备的ID:%@",device_id);
    [self callBackBlock:FunctionNameDeviceID cmdEnum:DeviceSwitchStateNone obj:device_id status:OperationStateSuccess];
}

+(BOOL)checkData:(NSData *)data position:(int)position
{
    //校验数据是否正确 +1 是加上 校验和sum 的长度
    if (data.length != position + CheckSumDataLength) {
        YHLog(@"数据长度不对");
        return false;
    }
    //SUM 校验和
    Byte sum = 0;
    [data getBytes:&sum range:NSMakeRange(position, sizeof(Byte))];
    NSData * calSumData = [data subdataWithRange:NSMakeRange(0, position)];
    Byte mySum = [BLEProtocol calCheckSum:(Byte *)calSumData.bytes Offset:0 Length:(int)calSumData.length];
    YHLog(@"返回的校验和和算出的校验和:%d--%d",sum,mySum);
    if (sum != mySum) {
        YHLog(@"校验和失败，数据不对");
        return false;
    }
    return true;
}

#pragma mark - 打包数据
+(NSData *)packCheckVersionData
{
    NSMutableData * data = [NSMutableData dataWithData:[NSData dataWithBytes:&SID_V_H length:sizeof(SID_V_H)]];
    [data appendData:VERINFO];
    
    return  [BLEProtocol commonPackData:data];
}

+(NSData *)packHandShakeData
{
     NSMutableData * data = [NSMutableData dataWithData:[NSData dataWithBytes:&SID_V_H length:sizeof(SID_V_H)]];
    [data appendData:CONNSERVER];
    return  [BLEProtocol commonPackData:data];
}

+(NSData *)packFunctionDataWithCMD:(DeviceSwitchState)switchState functionID:(FunctionName)functionName
{
    short   FuncionID = [BLEProtocol functionIDWithEnum:functionName];
    Byte CMD = [BLEProtocol CMDWithEnum:switchState];
    NSMutableData * data = [NSMutableData dataWithData:[NSData dataWithBytes:&SID_M_D_P length:sizeof(SID_M_D_P)]];
    [data appendData:[NSData dataWithBytes:&FuncionID length:FunctionIDLength]];
    [data appendData:[NSData dataWithBytes:&CMD length:CMDLength]];
    return  [BLEProtocol commonPackData:data];
}

+(NSData *)commonPackData:(NSMutableData *)data
{
    Byte checkSum = [BLEProtocol calCheckSum:(Byte*)[data bytes] Offset:0 Length:(int)data.length];
    [data appendBytes:&checkSum length:sizeof(checkSum)];
    return [BLEProtocol appendBLEHeadAndEndWithData:data];
}

+(NSData *)appendBLEHeadAndEndWithData:(NSData *)srcData
{
    NSMutableData * data = [NSMutableData dataWithData:HEAD_B];
    NSData * lengthData ;
    [data appendData:lengthData];
    [data appendData:srcData];
    [data appendData:END_B];
    return  data;
}

#pragma mark - 工具方法

+(Byte)CMDWithEnum:(DeviceSwitchState)state
{
    Byte  CMD = 0;
    switch (state) {
        case DeviceSwitchStateOn:
            CMD = CMD_ON;
            break;
        case DeviceSwitchStateOFF:
            CMD = CMD_OFF;
            break;
        case DeviceSwitchStateDelete:
            CMD = CMD_DEL;
            break;
        default:
            break;
    }
    return CMD;
}

+(DeviceSwitchState)enumWithCMD:(Byte)cmd
{
    switch (cmd) {
        case CMD_ON:
            return DeviceSwitchStateOn;
            break;
        case CMD_OFF:
            return DeviceSwitchStateOFF;
            break;
        case CMD_DEL:
            return DeviceSwitchStateDelete;
            break;
        default:
            return 0;
            break;
    }
}

+(short)functionIDWithEnum:(FunctionName)name;
{
    short   FuncionID = 0;
    switch (name) {
        case FunctionNameReset:
            FuncionID = ID_R;
            break;
        case FunctionNameLockCar:
            FuncionID = ID_L_C;
            break;
        case FunctionNameDoorLock:
            FuncionID = ID_D_L;
            break;
        case FunctionNameAirWindow:
            FuncionID = ID_A_W;
            break;
        case FunctionNameMatchData:
            FuncionID = ID_M_D;
            break;
        case FunctionNameBackMirror:
            FuncionID = ID_B_M;
            break;
        default:
            break;
    }
    return FuncionID;

}

+(FunctionName)enumWithFunctionID:(short)functionID
{
    switch (functionID) {
        case ID_R:
            return FunctionNameReset;
            break;
        case ID_L_C:
            return FunctionNameLockCar;
            break;
        case ID_D_L:
            return FunctionNameDoorLock;
            break;
        case ID_A_W:
            return FunctionNameAirWindow;
            break;
        case ID_M_D:
            return FunctionNameMatchData;
            break;
        case ID_B_M:
            return FunctionNameBackMirror;
            break;
        default:
            break;
    }
    return FunctionNameReset;

}

+ (Byte)calCheckSum:(const Byte*)data Offset:(const int)offset Length:(const int)len
{
    Byte checksum = 0x00;
    if (data && data != NULL && len > 0) {
        int v = 0,j = offset;
        for (; j < (offset + len); j++) {
            v += data[j];
        }
        checksum = (Byte)(v % 256);
    }
    return checksum;
}

+ (NSString*)hexStringValueOfData:(NSData *)data
{
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([data length] * 2)];
    const unsigned char *dataBuffer = [data bytes];
    for (int i = 0; i < [data length]; ++i) {
        [stringBuffer appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    return [stringBuffer copy];
}

#pragma mark - 懒加载
-(NSMutableData *)receiveData
{
    if (_receiveData == nil) {
        _receiveData = [NSMutableData dataWithCapacity:0];
    }
    return _receiveData;
}


@end
