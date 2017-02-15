//
//  Observer.m
//  观察者模式
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Observer.h"

@implementation Observer

-(void)update:(id)object
{
    NSLog(@"我收到通知了->%@",object);
}

@end
