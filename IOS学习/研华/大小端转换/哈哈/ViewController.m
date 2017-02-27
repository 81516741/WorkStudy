//
//  ViewController.m
//  哈哈
//
//  Created by yh on 16/6/13.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "NSData+ByteOrderCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Byte p[] = {0x24,0x00,0x00,0x00};
    NSData *data1 = [NSData dataWithBytes:&p length:sizeof(p)];
    NSInteger e = 0;
    [data1 getBytes:&e length:sizeof(int)];
    int f = [data1 getIntWithLocation:0];
    
    
    NSData * data = [NSData dataOrderWithValue:[NSNumber numberWithInt:10]byteOrder:DataByteOrderBigEndian];
    int a ;
    [data getBytes:&a length:4];
    int c = [data getIntWithLocation:0];
    int b = CFByteOrderGetCurrent();
    NSLog(@"%@",data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
