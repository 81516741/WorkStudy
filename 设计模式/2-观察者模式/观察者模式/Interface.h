//
//  Interface.h
//  观察者模式
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObserverInterface <NSObject>
@optional
-(void)update:(id)object;
@end
