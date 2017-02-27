//
//  ViewController.m
//  导航栏渐变
//
//  Created by yh on 16/5/12.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"arrow_back_blue"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0,15,20);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    if ( offSetY < 0.0) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:0.5 green:0.42 blue:0.8 alpha:(64 + offSetY) / 64]] forBarMetrics:UIBarMetricsDefault];
        //    这样就是透明的了
        [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:0.5 green:0.42 blue:0.8 alpha:(64 + offSetY) / 64]]];
         NSLog(@"-------------");
    }
    NSLog(@"%f",scrollView.contentOffset.y);
}
-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"fdas";
    return cell;
}
@end
