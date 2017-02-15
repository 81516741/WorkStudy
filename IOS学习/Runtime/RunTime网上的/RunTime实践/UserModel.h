//
//  UserModel.h
//  RunTime实践
//
//  Created by dbjyz on 15/11/10.
//  Copyright © 2015年 dbjyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/**
 *  用户名字
 */
@property(strong ,nonatomic)NSString * userNameStr;

/**
 *  用户电话
 */
@property(strong, nonatomic)NSString * userPhoneStr;
@end
