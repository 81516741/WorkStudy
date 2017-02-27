//
//  MD5Util.h
//  CProtocol
//
//  Created by ZWD on 13-4-24.
//  Copyright (c) 2013年 YanHua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5Util)

- (NSString*)stringFromMD5;
- (NSData*)dataFromMD5;

- (NSString*)stringFromMD5_16;
- (NSData*)dataFromMD5_16;

@end

@interface NSData (MD5Util)

- (NSString*)stringFromMD5;
- (NSData*)dataFromMD5;

- (NSString*)stringFromMD5_16;
- (NSData*)dataFromMD5_16;

@end
