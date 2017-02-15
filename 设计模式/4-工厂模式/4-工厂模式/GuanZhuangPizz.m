//
//  GuanZhuangPizz.m
//  4-工厂模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "GuanZhuangPizz.h"

@implementation GuanZhuangPizz
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.price = @"RMB 99.9";
        self.name = @"官庄人的最爱-超级辣pizz";
    }
    return self;
}
-(void)prepare
{
    self.lajiao = self.cailiao.lajiao;
    self.dasuan = self.cailiao.dasuan;
}

-(void)bake
{
    NSLog(@"bake 官庄炭火烧 材料:%@ %@",self.lajiao,self.dasuan);
}
-(void)cute
{
    NSLog(@"cute 官庄斧头砍");
}
@end
