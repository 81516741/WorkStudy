//
//  ViewController.m
//  octextlianxi
//
//  Created by ld on 16/4/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)printSome:(NSInteger)temp
{
    printf("%ld",(long)temp);
    return temp;
}

@end
