//
//  NSArray+Description.h
//  9.qq对话框
//
//  Created by mac on 15/9/13.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
/**
 *  加载bundle里面的plist文件
 */
+(instancetype)arrayWithBundleName:(NSString *)bundleName;
@end
