//
//  Poster.h
//  观察者模式
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interface.h"


@interface Poster : NSObject<ObserverInterface>
-(void)registerObserver:(id<ObserverInterface>)observer;
-(void)removeObserver:(id<ObserverInterface>)observer;
@end
