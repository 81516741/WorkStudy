//
//  ViewController.m
//  fds
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 LD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITabBarDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString * str1 = NSStringFromUIEdgeInsets(self.tableView.contentInset);
        NSString * str2 = NSStringFromCGPoint(self.tableView.contentOffset);
        NSString * str3 = NSStringFromCGRect(self.tableView.frame);
        NSLog(@"contentInset:%@\ncontentOffset:%@\nframe:%@",str1,str2,str3);
        
        
//        self.tableView.contentOffset = CGPointMake(0, -100);
        self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        

    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"哈哈哈%zd",indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSString * str1 = NSStringFromUIEdgeInsets(self.tableView.contentInset);
    NSString * str2 = NSStringFromCGPoint(self.tableView.contentOffset);
    NSString * str3 = NSStringFromCGRect(self.tableView.frame);
    NSLog(@"contentInset:%@\ncontentOffset:%@\nframe:%@",str1,str2,str3);
    
}
@end
