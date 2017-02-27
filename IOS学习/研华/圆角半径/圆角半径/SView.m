//
//  SView.m
//  圆角半径
//
//  Created by yh on 16/5/4.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "SView.h"

@implementation SView

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
@end
