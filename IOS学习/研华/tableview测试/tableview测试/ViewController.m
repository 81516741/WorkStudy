//
//  ViewController.m
//  tableview测试
//
//  Created by yh on 16/5/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 100);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [UITableViewCell new];
    cell.textLabel.text = @"f";
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

@end
