//
//  NSString+sizeOfText.m
//  9.qq对话框
//
//  Created by mac on 15/9/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
@dynamic linkValue,fileSize,documentPath,cachesPath,tempPath;
-(CGSize)sizeOftextWith :(CGSize)size andFont:(CGFloat)font{
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

-(CGSize) sizeOftextWith:(CGSize) size andUIFont:(UIFont *) uiFont{
    
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:uiFont} context:nil].size;
}

-(NSString *)linkValue{
    
    NSRange startRG = [self rangeOfString:@">"];
    NSRange endRG = [self rangeOfString:@"</"];
    NSRange valueRG = NSMakeRange(startRG.location + 1, endRG.location-startRG.location -1);
    
    return [NSString stringWithFormat:@" 来自%@",[self substringWithRange:valueRG]];
    

}

- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

-(NSString *)documentPath
{
    return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:self.lastPathComponent];
}
-(NSString *)cachesPath
{
    return  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:self.lastPathComponent];
}
-(NSString *)tempPath
{
    return  [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

@end
