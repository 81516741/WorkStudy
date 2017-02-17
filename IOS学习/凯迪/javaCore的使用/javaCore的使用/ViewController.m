//
//  ViewController.m
//  JavaAndNative
//
//  Created by yh on 16/8/11.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"
@interface ViewController ()
@property (nonatomic,strong) JSContext * jsContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString  * str  = ({
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", @"fadsf", @"fadsfa"];
        [urlString stringByAppendingString:@"这就是我的style"];
    });
    NSLog(@"%@",str);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self useJSExprot];
}

- (void)useJSExprot {
    Person *p = [[Person alloc]init];
    self.jsContext[@"person"] = p;
    JSValue *value = [self.jsContext evaluateScript:@"person.whatYouName()"];
    NSLog(@"%@",[value toString]);
}


//捕获异常
-(void)fun5
{
    JSContext *context = [[JSContext alloc] init];
    context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };
    
    [context evaluateScript:@"var ider = {name:'zeng',age:18} ; ider1.name1 = 21"];
}

//函数
-(void)fun6
{
    [self.jsContext evaluateScript:@"var hello = function(){ return 'hello' }"];
    //调用
    JSValue *value1 = [self.jsContext evaluateScript:@"hello()"];
    NSLog(@"%@",value1);
    //注册一个匿名函数
    JSValue *jsFunction = [self.jsContext evaluateScript:@" (function(){ return 'hello objc' })"];
    //调用
    JSValue *value2 = [jsFunction callWithArguments:nil];
    NSLog(@"%@",value2);
}
-(void)fun4
{
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"function add(a, b) { return a + b; }"];
    JSValue *add = context[@"add"];
    NSLog(@"Func:  %@", add);
    
    JSValue *sum = [add callWithArguments:@[@(7), @(21)]];
    NSLog(@"Sum:  %d",[sum toInt32]);
}

-(void)fun3
{
    self.jsContext[@"log"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        
        NSObject *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
    };
    
    [self.jsContext evaluateScript:@"log('ider', [7, 21], { hello:'world', js:100 });"];
}

//取出数组
-(void)fun2{
    [self.jsContext evaluateScript:@"var arr = ['nihao','woshizenglingda']"];
    JSValue * jsArr = self.jsContext[@"arr"];
    NSLog(@"%@",jsArr);
    jsArr[1] = @"我真的是";
    jsArr[4] = @"会越界吗 ";
    NSLog(@"%@",jsArr);
    
}

-(void)func1{
    //定义一个js并执行函数
    JSValue *exeFunction1 = [self.jsContext evaluateScript:@"function hi(){ return 'hi' }; hi()"];
    //执行一个闭包js
    JSValue *exeFunction2 = [self.jsContext evaluateScript:@"(function(){ return ('dada') })()"];
    
    NSLog(@"%@%@",exeFunction1,exeFunction2);
}

-(JSContext *)jsContext
{
    if (_jsContext == nil) {
        _jsContext = [[JSContext alloc]init];
    }
    return _jsContext;
}

@end
