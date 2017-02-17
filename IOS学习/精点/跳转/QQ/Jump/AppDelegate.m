//
//  AppDelegate.m
//  Jump
//
//  Created by kingpoint on 15/12/24.
//  Copyright © 2015年 kingpoint. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0){
    NSLog(@"url---%@, dic---%@",url,options);
    return YES;
}

@end
