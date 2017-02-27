//
//  NSString+sizeOfText.h
//  9.qq对话框
//
//  Created by mac on 15/9/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**获取字符串的size*/
-(CGSize) sizeOftextWith:(CGSize) size andFont:(CGFloat) font;

/**获取字符串的size*/
-(CGSize) sizeOftextWith:(CGSize) size andUIFont:(UIFont *) uiFont;

/**获取link连接字符串的文字部分*/
@property(nonatomic ,copy) NSString * linkValue;

/**
 *  计算当前文件\文件夹的内容大小 单位B
 */
@property(nonatomic ,assign) NSInteger fileSize;
/**
 *  获取documentPath
 */
@property(nonatomic ,copy) NSString * documentPath;
/**
 *  获取cachesPath
 */
@property(nonatomic ,copy) NSString * cachesPath;
/**
 *  获取tempPath
 */
@property(nonatomic ,copy) NSString * tempPath;
@end
