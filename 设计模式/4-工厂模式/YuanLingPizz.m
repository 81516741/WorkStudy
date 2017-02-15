//
//  YuanLingPizz.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "YuanLingPizz.h"

@implementation YuanLingPizz
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.price = @"RMB 9.9";
        self.name = @"沅陵人的最爱-微微辣pizz";
    }
    return self;
}
-(void)prepare
{
    self.lajiao = self.cailiao.lajiao;
}
-(void)bake
{
    NSLog(@"bake 沅陵液化气烤 材料:%@",self.lajiao);
}
-(void)cute
{
    NSLog(@"cute 沅陵菜刀切");
}
@end
