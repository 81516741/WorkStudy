//
//  NSObject+dealloc.h
//  weak属性runtime实现
//
//  Created by ld on 17/2/17.
//  Copyright © 2017年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (dealloc)

-(void)dealloc:(dispatch_block_t)block;

@end


@interface LDObject : NSObject

-(instancetype)initWithBlock:(dispatch_block_t)block;
@property (nonatomic,copy) dispatch_block_t deallocBlock;

@end
