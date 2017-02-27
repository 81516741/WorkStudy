//
//  ViewController.m
//  xibObject
//
//  Created by yh on 16/4/19.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet NSObject *object;
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray *objects;

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

@end
