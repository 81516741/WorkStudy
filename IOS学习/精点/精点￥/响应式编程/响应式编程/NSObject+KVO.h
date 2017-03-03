//
//  NSObject+KVO.h
//  响应式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

- (void)ld_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end
