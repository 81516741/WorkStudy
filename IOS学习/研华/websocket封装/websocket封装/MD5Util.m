//
//  MD5Util.m
//  CProtocol
//
//  Created by ZWD on 13-4-24.
//  Copyright (c) 2013年 YanHua. All rights reserved.
//

#import "MD5Util.h"

@implementation NSString (MD5Util)

- (NSString*)stringFromMD5 {
    if(self == nil || [self length] == 0) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSData*)dataFromMD5 {
    if(self == nil || [self length] == 0) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    return [NSData dataWithBytes:outputBuffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString*)stringFromMD5_16 {
    if(self == nil || [self length] == 0) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 4; count < (CC_MD5_DIGEST_LENGTH - 4); count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSData*)dataFromMD5_16 {
    NSData* data = [self dataFromMD5];
    if (data) {
        return [data subdataWithRange:NSMakeRange(4, 8)];
    } else {
        return nil;
    }
}

@end

@implementation NSData (MD5Util)

- (NSString*)stringFromMD5 {
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5( self.bytes, self.length, outputBuffer );
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSData*)dataFromMD5 {
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5( self.bytes, self.length, outputBuffer );
    
    return [NSData dataWithBytes:outputBuffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString*)stringFromMD5_16 {
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5( self.bytes, self.length, outputBuffer );
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 4; count < (CC_MD5_DIGEST_LENGTH - 4); count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSData*)dataFromMD5_16 {
    NSData* data = [self dataFromMD5];
    if (data) {
        return [data subdataWithRange:NSMakeRange(4, 8)];
    } else {
        return nil;
    }
}

@end
