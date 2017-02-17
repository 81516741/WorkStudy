//
//  TableViewController.m
//  JSPatch
//
//  Created by ld on 16/12/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDelegate>
@property (nonatomic,strong) NSArray * dataSource;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dfa");
}
- (NSArray *)dataSource
{
    return @[@"呵呵呵", @"哈哈哈"];
}
- (void)customMethod
{
    NSLog(@"callCustom method");
}
-(UIViewController *)navi
{
    return self.navigationController;
}
@end
