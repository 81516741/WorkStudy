//
//  ViewController.m
//  runloop常驻线程
//
//  Created by yh on 16/4/14.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import "LDThread.h"

@interface ViewController ()
@property (nonatomic ,strong)LDThread * thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[LDThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    [self.thread start];
}

- (void)run {
    NSLog(@"run on thread %@,%@",[NSThread currentThread],self.thread);
    //创建runloop并保住他的命
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
}

-(void)touch
{
    NSLog(@"touch on thread %@,%@",[NSThread currentThread],self.thread);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(touch) onThread:self.thread withObject:nil waitUntilDone:NO];
}

@end
