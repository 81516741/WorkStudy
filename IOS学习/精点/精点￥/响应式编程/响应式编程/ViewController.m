//
//  ViewController.m
//  响应式编程
//
//  Created by mac on 16/2/20.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"
@interface ViewController ()
@property(nonatomic, strong) Person  * p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.p = [Person new];
    [_p ld_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"person.age = %d",_p.age);
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.p.age++;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
