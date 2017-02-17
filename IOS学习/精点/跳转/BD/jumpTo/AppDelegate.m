//
//  AppDelegate.m
//  jumpTo
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
    //获取执行performSegue的控制器
    UINavigationController * vc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * vc1 = (UIViewController *)vc.topViewController;
    
    //根据url的关键字，决定跳那个界面
    if([url.absoluteString containsString:@"login"]){
    //跳界面时传个参数，这个参数一般是跳过来的那个app的schemes，这个schemes是通过
        //url传过来的，通过截串的方式获取，这里我图简单就直接写个
        [vc1 performSegueWithIdentifier:@"login" sender:@"qe"];
        
    }else if([url.absoluteString containsString:@"send"]){
        [vc1 performSegueWithIdentifier:@"send" sender:@"qq"];

    }
 
    return YES;
}

@end
