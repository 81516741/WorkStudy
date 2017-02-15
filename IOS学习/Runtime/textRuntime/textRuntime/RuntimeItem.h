//
//  RuntimeItem.h
//  textRuntime
//
//  Created by kingpoint on 15/12/25.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeItem : NSObject

@property(nonatomic, strong) NSArray  * array;
@property(nonatomic, copy) NSString  * name;
@property(nonatomic, copy) NSString  * iphone;
@property(nonatomic, copy) NSString  * address;
@property(nonatomic, copy) NSString  * age;
-(void)haa;
-(void)getAll;
@end
