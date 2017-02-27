//
//  ViewController.m
//  BlueTooth
//
//  Created by yh on 16/8/4.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "BLEManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[BLEManager shareBLE] start];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [BLEManager shareBLE].peripheralName = @"YH28000A00E1005ACD000001AA";
    [[BLEManager shareBLE]scanForPeripheralsSuccess:^{
        
    } failure:^{
        
    }];
    NSLog(@"%@",[BLEManager shareBLE]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
