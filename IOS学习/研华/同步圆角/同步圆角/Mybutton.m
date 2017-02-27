//
//  Mybutton.m
//  同步圆角
//
//  Created by yh on 16/6/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Mybutton.h"

@implementation Mybutton

-(void)setCor:(CGFloat)cor
{
    _cor = cor;
    self.layer.cornerRadius = cor;
    self.layer.masksToBounds = YES;
}

@end
