//
//  VC.m
//  tableViewController浅浅的研究
//
//  Created by yh on 16/5/13.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "VC.h"

@implementation VC

-(void)viewDidLoad
{
//    self.view.backgroundColor = [UIColor redColor];
//    self.tableView.backgroundView.backgroundColor = [UIColor yellowColor];
//    NSLog(@"1----%@,\n2-----%@,\n%@",self.view.backgroundColor,self.tableView.backgroundView,self.tableView);
//    self.tableView.backgroundColor = [UIColor greenColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundView.backgroundColor = [UIColor yellowColor];
//
    self.tableView.backgroundColor = [UIColor greenColor];
    
    NSLog(@"1----%@,\n2-----%@,\n3------%@",self.view,self.tableView.backgroundView,self.tableView);
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
    
    cell.textLabel.text = @"sfds";
    
    cell.backgroundColor = [UIColor redColor];
    cell.contentView.backgroundColor = [UIColor purpleColor];
    return cell;
}

@end
