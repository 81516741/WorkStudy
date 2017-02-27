//
//  ViewController.m
//  信号量
//
//  Created by yh on 16/8/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) dispatch_semaphore_t mySemaphore;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"开始");
    dispatch_queue_t myQueue = dispatch_queue_create("My_BLE_QUEUE", DISPATCH_QUEUE_SERIAL);
    self.mySemaphore = dispatch_semaphore_create(1);
    dispatch_async(myQueue, ^{
        while (1) {
            dispatch_semaphore_wait(self.mySemaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2000.0 * NSEC_PER_MSEC)));
            NSLog(@"打印一次");
        }
    });
    NSLog(@"viewDidLoad结束");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_semaphore_signal(self.mySemaphore);
}
@end
