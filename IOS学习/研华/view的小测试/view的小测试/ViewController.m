//
//  ViewController.m
//  view的小测试
//
//  Created by yh on 16/6/6.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "MyViewVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    
    [self.navigationController pushViewController:[MyViewVC new] animated:YES];
}

@end
