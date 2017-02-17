//
//  JSPersonProtocol.h
//  JavaAndNative
//
//  Created by yh on 16/8/11.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSPersonProtocol <JSExport>

@property (nonatomic, copy) NSDictionary *data;
- (NSString *)whatYouName;

@end
