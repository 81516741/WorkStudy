//
//  ViewController.m
//  测试方法添加
//
//  Created by ld on 17/1/19.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSMethodSignature *)jp_methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature =[self jp_methodSignatureForSelector:aSelector];
    NSLog(@"新的");
    return signature;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    SEL originalSelector = @selector(methodSignatureForSelector:);
    SEL swizzledSelector = @selector(jp_methodSignatureForSelector:);
    Method originalMethod = class_getInstanceMethod([ViewController class], originalSelector);
    Method swizzledMethod = class_getInstanceMethod([ViewController class], swizzledSelector);
    BOOL didAddMethod = class_addMethod([ViewController class], originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod([ViewController class], swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    [self methodSignatureForSelector:@selector(viewDidLoad)];
}

@end
