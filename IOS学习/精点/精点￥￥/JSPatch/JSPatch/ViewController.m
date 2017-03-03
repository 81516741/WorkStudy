//
//  ViewController.m
//  JSPatch
//
//  Created by ld on 16/12/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic,strong) JSContext * context;
@end

@implementation ViewController

static void touch(){printf("nimei--------");}

- (void)viewDidLoad {
    [super viewDidLoad];
    _context = [[JSContext alloc] init];
    _context[@"hello"] = ^(NSString * str) {
        NSLog(@"%@", str);
    };
    [_context evaluateScript:@"hello('😍😍😍😍😍😍😍😍')"];
    
    
    
    
    _context[@"defineClass"] = ^(NSString *classDeclaration, JSValue *instanceMethods, JSValue *classMethods) {
        NSDictionary * methodDict = [instanceMethods toDictionary];
        for (NSString *jsMethodName in methodDict.allKeys){
            
        }
    };
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [_context evaluateScript:script];
    
//    class_replaceMethod([self class], @selector(touchesBegan:withEvent:), touch, "d");

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[NSClassFromString(@"TableViewController") new] animated:true];
}
- (IBAction)click:(id)sender {
}

@end
