//
//  LDPakage.h
//  泛型练习
//
//  Created by yh on 16/4/12.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDPakage<ObjectType> : NSObject

-(void)addObject:(ObjectType)obj;
-(ObjectType)objectAtIndex:(int)index;

@end
