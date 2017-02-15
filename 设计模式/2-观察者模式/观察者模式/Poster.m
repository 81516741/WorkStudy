//
//  Poster.m
//  观察者模式
//
//  Created by ld on 16/11/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Poster.h"
@interface Poster()
@property (nonatomic,strong) NSMutableArray * observers;
@end
@implementation Poster

-(void)registerObserver:(id<ObserverInterface>)observer
{
    if (![self.observers containsObject:observer]) {
        [self.observers addObject:observer];
    }
}

-(void)removeObserver:(id<ObserverInterface>)observer
{
    if ([self.observers containsObject:observer]) {
        [self.observers removeObject:observer];
    }
}

-(void)update:(id)object
{
    for (id<ObserverInterface> observer in self.observers) {
        if ([observer respondsToSelector:@selector(update:)]) {
            [observer update:object];
        }
    }
}

-(NSMutableArray *)observers
{
    if (_observers == nil) {
        _observers = @[].mutableCopy;
    }
    return _observers;
}

@end
