//
//  DigitalTool.m
//  加密技术
//
//  Created by ld on 17/2/16.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "DigitalTool.h"
#include <openssl/rsa.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation DigitalTool

+ (NSData *)convertDicToData:(NSDictionary *)dic error:(NSError **)error
{
    NSData * dicData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:error];
    return dicData;
}

+ (NSString *)convertDicToString:(NSDictionary *)dic error:(NSError **)error
{
    NSData * dicData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:error];
    NSString * dicStr = [[NSString alloc] initWithData:dicData encoding:NSUTF8StringEncoding];
    return dicStr;
}

+ (NSDictionary *)convertDataToDic:(NSData *)data error:(NSError **)error
{
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
    return dict;
}

+ (NSDictionary *)convertStringToDict:(NSString *)string error:(NSError **)error
{
    NSData * dicData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:dicData options:NSJSONReadingMutableContainers error:error];
    return dict;
}

+ (NSString *)convertDataToString:(NSData *)data
{
    NSString * string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
+ (NSData *)convertStringToData:(NSString *)string
{
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

+(void)srcData:(NSMutableData *)srcData appendData:(NSData*)other length:(int)len {
    [srcData appendData:other];
    int len_tmp = len - (int)[other length];
    if (len_tmp > 0) {
        [srcData resetBytesInRange:NSMakeRange([srcData length], len_tmp)];
    }
}

+ (NSData*)randomDataWithLength:(NSUInteger)length
{
    NSMutableData *mutableData = [NSMutableData dataWithCapacity: length];
    for (unsigned int i = 0; i < length; i++) {
        NSInteger randomBits = arc4random();
        [mutableData appendBytes: (void *) &randomBits length: 1];
    }
    return mutableData;
}

+ (BOOL)isEmptyData:(NSData*)data {
    if (data && [data length] > 0) {
        int len = (int)[data length];
        Byte *bytes = (Byte*)[data bytes];
        for (int i = 0; i < len; i++) {
            if (bytes[i] != 0) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

+ (NSString*)hexStringFromData:(NSData *)data {
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([data length] * 2)];
    const unsigned char *dataBuffer = [data bytes];
    for (int i = 0; i < [data length]; ++i) {
        [stringBuffer appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    return [stringBuffer copy];
}

@end

@implementation NSData (DigitalTool)

- (NSData *)RSAEncryptWithPublicKey:(NSString *)publicKey
{
    const char * defaultKey = [@"10001" UTF8String];
    return [self RSAEncryptByPublicKey:[publicKey UTF8String] defaultKey:defaultKey];
}

- (NSData *)RSADecryptWithPublicKey:(NSString *)publicKey privateKey:(NSString *)privateKey
{
    const char * defaultKey = [@"10001" UTF8String];
    return [self RSADecryptByPublicKey:[publicKey UTF8String] privateKey:[privateKey UTF8String] defaultKey:defaultKey];
}

- (NSData *)RSAEncryptByPublicKey:(const char *)publicKey defaultKey:(const char *)defaultKey
{
    RSA *rsa = RSA_new();
    BN_hex2bn(&rsa->n, publicKey);
    BN_hex2bn(&rsa->e, defaultKey);
    
    //RSA_PKCS1_PADDING 必须－11
    int flen = RSA_size(rsa) /*- 11*/;
    unsigned char *outdata = (unsigned char *)malloc(flen + 1);
    bzero(outdata, flen + 1);
    int len =  RSA_public_encrypt(flen, (unsigned char*)[self bytes], outdata, rsa,  RSA_NO_PADDING);
    RSA_free(rsa);
    NSData * data = [NSData data];
    if (len > 0) {
        data = [NSData dataWithBytes:outdata length:len];
    }
    free(outdata);
    return data;
}

- (NSData*)RSADecryptByPublicKey:(const char*)publicKey privateKey:(const char*)privateKey defaultKey:(const char*)defaultKey {
    
    RSA *rsa = RSA_new();
    BN_hex2bn(&rsa->n, publicKey);
    BN_hex2bn(&rsa->d, privateKey);
    BN_hex2bn(&rsa->e, defaultKey);
    
    int flen = RSA_size(rsa);
    unsigned char *outdata = (unsigned char *)malloc(flen + 1);
    bzero(outdata, flen + 1);
    int len =  RSA_private_decrypt(flen, (unsigned char*)[self bytes] , outdata, rsa,  RSA_NO_PADDING);
    RSA_free(rsa);
    NSData * data = [NSData data];
    if (len > 0) {
        data = [NSData dataWithBytes:outdata length:len];
    }
    free(outdata);
    return data;
}

- (NSData*)AES256EncryptWithKey:(id)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    if ([key isKindOfClass:[NSString class]]) {
        [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    }else if ([key isKindOfClass:[NSData class]]){
        [key getBytes:keyPtr length:sizeof(keyPtr)];
    }
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = 0;
    if ([self length] % kCCKeySizeAES128 == 0) {
        cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                              kCCOptionECBMode,
                              keyPtr, kCCBlockSizeAES128,
                              NULL,
                              [self bytes], dataLength,
                              buffer, bufferSize,
                              &numBytesEncrypted);
    } else {
        cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                              kCCOptionPKCS7Padding | kCCOptionECBMode,
                              keyPtr, kCCBlockSizeAES128,
                              NULL,
                              [self bytes], dataLength,
                              buffer, bufferSize,
                              &numBytesEncrypted);
    }
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

-(NSData *)AES256DecryptWithKey:(id)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    if ([key isKindOfClass:[NSString class]]) {
        [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    }else if ([key isKindOfClass:[NSData class]]){
        [key getBytes:keyPtr length:sizeof(keyPtr)];
    }
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

- (NSDictionary *)AESDecryptWithKey:(id)key
{
    NSData * data = [self AES256DecryptWithKey:key];
    NSDictionary * dic = [DigitalTool convertDataToDic:data error:nil];
    return dic;
}

@end

@implementation NSDictionary(DigitalTool)

-(NSData *)AESEncryptWithKey:(id)key
{
    NSData * dicData = [DigitalTool convertDicToData:self error:nil];
    NSData * data = [dicData AES256EncryptWithKey:key];
    return data;
}


@end
