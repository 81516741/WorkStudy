//
//  NSData+ByteOrderCategory.h
//  CCDP
//
//  Created by zxy on 16/4/20.
//  Copyright © 2016年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DataByteOrderBigEndian    = 0,
    DataByteOrderLittleEndian = 1,
} DataByteOrder;

@interface NSData (ByteOrderCategory)

/**
 *  默认大端 DataByteOrderBigEndian 字节序
 */
@property (nonatomic, assign) DataByteOrder ldOrder;

/**
 *  将NSNumber、NSArray对象按照 DataByteOrder 字节序转成NSData
 *
 *  @param value 可以是NSNumber、NSArray。
 *       NSArray支持NSNumber、NSData、NSString
 *       NSString默认NSUTF8StringEncoding转化成NSData
 *
 *  @return 返回 DataByteOrder 字节序
 */
+ (NSData *)dataOrderWithValue:(NSNumber *)value;

+ (NSData *)dataOrderWithValue:(NSNumber *)value
                     byteOrder:(DataByteOrder)order;

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue;

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding;

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding
                      byteOrder:(DataByteOrder)order;

- (char)getCharWithLocation:(NSInteger)loc;

- (short)getShortWithLocation:(NSInteger)loc;

- (int)getIntWithLocation:(NSInteger)loc;

- (long)getLongWithLocation:(NSInteger)loc;

@end
