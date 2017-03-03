//
//  ViewController.m
//  搜索框练习
//
//  Created by ld on 16/10/10.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "ResultVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic,strong) UISearchController * searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ResultVC * resultVC = [[ResultVC alloc]init];
    UISearchController * searchVC = [[UISearchController alloc]initWithSearchResultsController:resultVC];
    self.searchController = searchVC;
    //是否隐藏导航条
    searchVC.hidesNavigationBarDuringPresentation = false;
    searchVC.delegate = self;
    searchVC.searchResultsUpdater = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = searchVC.searchBar;
    self.definesPresentationContext = YES;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    ResultVC * vc = (ResultVC *)searchController.searchResultsController;
    vc.datas = @[@"nihao",@"shide",@"这就是结果"];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"nihao";
    return cell;
}
@end
