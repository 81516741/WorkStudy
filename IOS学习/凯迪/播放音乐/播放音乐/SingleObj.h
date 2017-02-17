//
//  SingleObj.h
//  播放音乐
//
//  Created by yh on 16/4/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleObj : NSObject
+ (instancetype)shared;
-(void)play;
@end
