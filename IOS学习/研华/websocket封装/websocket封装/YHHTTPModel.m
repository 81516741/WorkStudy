//
//  YHHTTPModel.m
//  网络层封装
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "YHHTTPModel.h"
short const kPkgHead  = 0xFAFB;
short const kPkgTail     = 0xBFAF;

Byte const  kPkgRole   = 0x01;
short const kPkgFlage  = 0x0000;
int32_t const kPkgSrcID     = 0xFFFFFFFF;
int32_t const kPkgDstID     = 0x00000000;

NSInteger const kPkgHeadLength  = sizeof(kPkgHead);
NSInteger const kPkgLength          = 4;
NSInteger const kPkgCmdLength   = 4;
NSInteger const KPkgRoleLength   = sizeof(kPkgRole);
NSInteger const KPkgFlageLength  = sizeof(kPkgFlage);
NSInteger const kPkgSrcIDLength  = sizeof(kPkgSrcID);
NSInteger const kPkgDstIDLength  = sizeof(kPkgDstID);
NSInteger const KPkgFieldLength   = 2;
NSInteger const kPkgTailLength     =  sizeof(kPkgTail);

@implementation YHHTTPModel

//初始化，数值位0的时候初始化默认值
- (void)initStreamMessage{
    self.srcID = self.srcID ? self.srcID : kPkgSrcID;
    self.dstID = self.dstID ? self.dstID : kPkgDstID;
    self.flage = self.flage ? self.flage : kPkgFlage;
}
- (void)pack{
    
    [self initStreamMessage];
    
    NSMutableData *mtData = [self converDataWith16Value:kPkgHead].mutableCopy;
    __block int length = kPkgCmdLength+KPkgRoleLength+KPkgFlageLength+kPkgSrcIDLength+kPkgDstIDLength+KPkgFieldLength;
    
    //消息块个数
    __block short messageConnt = 0;
    [self.parameters enumerateObjectsUsingBlock:^(id data, NSUInteger idx, BOOL *stop) {
        
        NSData *converData = [self converDataWithParameter:data];
        
        //转换不为空的时候
        if (converData != nil) {
            length += KPkgFieldLength;
            length += converData.length;
            ++messageConnt;
        }
        
    }];
    
    //包长度
    
    [mtData appendData:[self converDataWith32Value:length]];
    
    //命令
    [mtData appendData:[self converDataWith32Value:self.tag]];
    
    //角色
    [mtData appendBytes:&kPkgRole length:KPkgRoleLength];
    
    //报文内容定义
    [mtData appendData:[self converDataWith16Value:self.flage]];
    
    //源ID
    [mtData appendData:[self converDataWith32Value:self.srcID]];
    
    //目标ID
    [mtData appendData:[self converDataWith32Value:self.dstID]];
    
    //消息块个数
    [mtData appendData:[self converDataWith16Value:messageConnt]];
    
    
    [self.parameters enumerateObjectsUsingBlock:^(id data, NSUInteger idx, BOOL *stop) {
        
        //把字符、number转成data
        NSData *converData =[self converDataWithParameter:data];
        if (converData != nil) {
            [mtData appendData:[self converDataWith16Value:(short)converData.length]];
            [mtData appendData:converData];
        }
    }];
    
    [mtData appendData:[self converDataWith16Value:kPkgTail]];
    self.parameters = mtData;
    
}

- (NSArray *)unpack:(NSData*)data{
    
    
    int sLen = kPkgHeadLength, dLen = kPkgLength;
    
    //包长
    int pkgLength;
    [data getBytes:&pkgLength range:NSMakeRange(sLen, dLen)];
    
    //命令
    sLen += dLen;
    dLen = kPkgCmdLength;
    int cmd;
    [data getBytes:&cmd range:NSMakeRange(sLen, dLen)];
    //32位大小端转换
    cmd = CFSwapInt32BigToHost(cmd);
    self.tag = cmd;
    
    //消息块个数
    sLen += dLen+KPkgRoleLength+KPkgFlageLength+kPkgSrcIDLength+kPkgDstIDLength;
    dLen = KPkgFieldLength;
    short field_cnt;
    [data getBytes:&field_cnt range:NSMakeRange(sLen, dLen)];
    //16位大小端转换
    field_cnt = CFSwapInt16BigToHost(field_cnt);
    
    sLen += dLen;
    
    if (field_cnt <= 0) {
        return nil;
    }
    
    NSMutableArray *mtArry = [[NSMutableArray alloc] initWithCapacity:field_cnt];
    
    while (field_cnt>0) {
        short field_len;
        dLen = KPkgFieldLength;
        [data getBytes:&field_len range:NSMakeRange(sLen, dLen)];
        //大小端转换
        field_len = CFSwapInt16BigToHost(field_len);
        sLen += dLen;
        if (field_len + sLen > data.length) {
            return nil;
        }
        [mtArry addObject:[data subdataWithRange:NSMakeRange(sLen, field_len)]];
        sLen += field_len;
        
        --field_cnt;
    }
    
    return mtArry;
}

#pragma mark - help

- (NSData *)converDataWithParameter:(id)data{
    
    if([data isKindOfClass:[NSString class]]){
        data = [(NSString *)data dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([data isKindOfClass:[NSNumber class]]){
        data = [self converDataWithNumber:data];
    }else if([data isKindOfClass:[NSNull class]]){
        data = nil;
    }
    return data;
}

- (NSData *)converDataWithNumber:(NSNumber *)number{
    
    NSData *data = nil;
    if (strcmp([number objCType], @encode(short)) == 0){
        data = [self converDataWith16Value:[number shortValue]];
    }else if (strcmp([number objCType], @encode(int)) == 0){
        data = [self converDataWith32Value:[number intValue]];
    }else if (strcmp([number objCType], @encode(long)) == 0){
        data = [self converDataWith64Value:[number longValue]];
    }
    
    NSAssert(data != nil, @"需扩展添加类型");
    
    return data;
}

//32位大小端转换
- (NSData *)converDataWith32Value:(int)value{
    value = CFSwapInt32BigToHost(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

//16位大小端转换
- (NSData *)converDataWith16Value:(short)value{
    value = CFSwapInt16BigToHost(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

//64位大小端转换
- (NSData *)converDataWith64Value:(long)value{
    value = CFSwapInt64BigToHost(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}


@end
