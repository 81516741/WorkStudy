//
//  Bridging.h
//  LD_hunhe_ios
//
//  Created by ld on 16/8/10.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h" //导入这个头文件以现实RCTBridgeModule协议
#import "RCTEventDispatcher.h"  //导入这个头文件以实现向RN侧发送事件
@interface Bridging : NSObject<RCTBridgeModule>

@end
