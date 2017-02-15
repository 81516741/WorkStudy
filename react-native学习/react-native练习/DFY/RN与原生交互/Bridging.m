//
//  Bridging.m
//  LD_hunhe_ios
//
//  Created by ld on 16/8/10.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "Bridging.h"

@implementation Bridging

- (instancetype) init
{
  return self;
}

@synthesize bridge = _bridge;
/*
 除了现实RCTBridegModule协议外,类还需要包含RCT_EXPORT_MODELE()宏。
 这个宏可以添加一个参数用来指定在js中访问这个模块的名字通常不指定名字，
 默认使用Objective-C类的名字
 */

RCT_EXPORT_MODULE();

//使用RCT_EXPORT_METHOD()宏声明需要提供给RN组件调用的方法
RCT_EXPORT_METHOD(sendMessage:(NSString *)msg )
{
  //检测收到的消息是否为json格式
  NSData *data=[msg dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error;
  NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
  NSLog(@"原生收到RN的数据:%@",dic);
  if (error!=nil) {
    NSLog(@"解析错误：%@",error);
  }else{
    //没有错误的情况 通知rn侧 发送消息给rn侧
    [_bridge.eventDispatcher sendAppEventWithName:@"NativeMsg" body:@{@"message":@"我来自原生ios"}];
  }
}

@end
