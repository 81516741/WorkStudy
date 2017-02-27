//
//  ViewController.m
//  蓝牙demo
//
//  Created by yh on 16/8/18.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "BLEManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[BLEManager shareBLE] start];
    
}
- (IBAction)searchPeripherals:(UIButton *)sender
{
    if (![BLEManager shareBLE].BLEAvailable) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请打开蓝牙" message:nil delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [self performSegueWithIdentifier:@"BLEPeripheralList" sender:nil];
}


@end
