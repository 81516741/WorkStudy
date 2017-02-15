//
//  LDView.m
//  发消息应用
//
//  Created by mac on 16/1/17.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "LDView.h"
#import <objc/message.h>

#define LDViewTouchDeliver(target,sel) ((void (*)(id,SEL,UIView *))objc_msgSend)((id)target,sel,self)

@interface LDView()
{
    id _target;
    SEL _sel;
}
@end


@implementation LDView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    self = [super initWithCoder:coder];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)addTarget:(id)target sel:(SEL)sel
{
    _target = target;
    _sel = sel;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if ([_target respondsToSelector:_sel]) {
        LDViewTouchDeliver(_target, _sel);
    }
    
}

@end
