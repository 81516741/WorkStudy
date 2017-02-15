//
//  OriginComponent.h
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//
/*
 * 这里第一次练习是用装饰者模式，后来学了工厂，所以这里也用了工厂模式
 * 这个例子感觉自己写了太多东西进去，可能以后再来看要稍微琢磨下
 * 还是很牛掰的
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SizeOf){
    SizeOfSmall,
    SizeOfMiddle,
    SizeOfBig
};

@interface OriginComponent : NSObject
@property (assign ,nonatomic) SizeOf size;
+(OriginComponent *)instanceWithSize:(SizeOf)size;
@property (nonatomic,strong) OriginComponent * originObject;
@property (assign ,nonatomic) BOOL isDecorate;
-(NSString *)getdescriptionString;
-(NSMutableArray *)getdescriptionArr;
-(CGFloat)cost;
-(CGFloat)addPrice;
-(NSString *)getSelfName;
@end
