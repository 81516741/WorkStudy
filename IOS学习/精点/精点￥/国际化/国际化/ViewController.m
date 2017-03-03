//
//  ViewController.m
//  国际化
//
//  Created by Kingpoint on 16/1/14.
//  Copyright © 2016年 kingpoint. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * lable = [[UILabel alloc]initWithFrame:self.view.bounds];
    lable.textAlignment = NSTextAlignmentCenter;
    
    
    lable.text = NSLocalizedString(@"text1", nil);
    
    
    
    [self.view addSubview:lable];
}



@end
