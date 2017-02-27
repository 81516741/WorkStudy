//
//  VC1.m
//  tableViewController浅浅的研究
//
//  Created by yh on 16/5/13.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "VC1.h"


@implementation VC1

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewSelf.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
}
-(void)viewDidAppear:(BOOL)animated
{

    self.view.backgroundColor = [UIColor redColor];
//        self.tableViewSelf.backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        self.tableViewSelf.backgroundView.backgroundColor = [UIColor yellowColor];
    //
    self.tableViewSelf.backgroundColor = [UIColor greenColor];
    
    NSLog(@"1----%@,\n2-----%@,\n3------%@",self.view,self.tableViewSelf.backgroundView,self.tableViewSelf);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    view.backgroundColor = [UIColor redColor];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"sfds";
    return cell;
}

@end
