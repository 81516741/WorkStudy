//
//  ViewController.m
//  64位数据长度
//
//  Created by ld on 17/2/14.
//  Copyright © 2017年 ld. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int intA = 1;
    unsigned unsignedA = 1;
    long longA = 1;
    long long longlongA = 1;
    float floatA = 0.1;
    double doubleA = 0.1;
    NSLog(@"int = %ld",sizeof(intA));
    NSLog(@"unsigned = %ld",sizeof(unsignedA));
    NSLog(@"long = %ld",sizeof(longA));
    NSLog(@"long long = %ld",sizeof(longlongA));
    NSLog(@"float = %ld",sizeof(floatA));
    NSLog(@"double = %ld",sizeof(doubleA));

}

@end
