//
//  ViewController.m
//  RuntimeDemo
//
//  Created by huangyibiao on 15/12/25.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import "HYBTestModel.h"
#import "HDFArchiveModel.h"
#import "HYBCat.h"
#import "HYBMsgSend.h"
#import "HYBMethodExchange.h"
#import "HYBPropertyLearn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

//  [HYBTestModel test];
//  [HDFArchiveModel test];
//  [HYBCat test];
//  [HYBMsgSend test];
//  [HYBMethodExchange test];
  [HYBPropertyLearn test];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
