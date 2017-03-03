//
//  ViewController.m
//  searBar的使用
//
//  Created by kingpoint on 16/1/4.
//  Copyright © 2016年 kingpoint. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"
#import "DemoModel.h"
#import "NewSearchBar.h"

NSString *const kCellIdentifier = @"CellID";
NSString *const kTableCellNibName = @"DemoCell";

@interface ViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
@property(nonatomic, strong) NSArray  * models;
@property (nonatomic, strong) NSMutableArray *searchArray;
@end

@implementation ViewController

-(NSArray *)models
{
    NSArray *testModels = @[
                            [DemoModel  modelWithName:@"Lanmaq" friendId:@"15668689942" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"1.jpeg"], 0.3)],
                            [DemoModel  modelWithName:@"May" friendId:@"2452345236" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"2.jpg"], 0.3)],
                            [DemoModel  modelWithName:@"Qiao" friendId:@"45642433" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"3.jpg"], 0.3)],
                            [DemoModel  modelWithName:@"Yu" friendId:@"6356347345" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"4.jpg"], 0.3)],
                            [DemoModel  modelWithName:@"Feng" friendId:@"4764536456" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"5.jpg"], 0.3)],
                            [DemoModel  modelWithName:@"Chen" friendId:@"734563465" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"6.jpg"], 0.3)],
                            [DemoModel  modelWithName:@"Ru" friendId:@"534535345" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"7.jpg"], 0.3)],
                            [DemoModel  modelWithName:@"Good" friendId:@"34534573457" imageData:UIImageJPEGRepresentation([UIImage imageNamed:@"8.jpg"], 0.3)] ];
    return testModels;
}
-(void)viewDidLoad{
    self.searchArray = [NSMutableArray arrayWithCapacity:0];
    self.tableView.rowHeight = 60.0;
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}
#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[NewSearchBar new] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        return self.searchArray.count;
       
    }
    return self.models.count;
}
- (void)configureCell:(DemoCell *)cell forModel:(DemoModel *)model
{
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DemoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    DemoModel *model;
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        model = [self.searchArray objectAtIndex:indexPath.row];
    }
    else{
        model = [self.models objectAtIndex:indexPath.row];
    }
    cell.friendNameLabel.text = model.friendName;
    cell.friendIdLabel.text = model.friendId;
    return cell;
}
//needs overwrite
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - UISearchDisplayDelegate (which you use ,which you choose!!)
// when we start/end showing the search UI
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0){
    
}
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0){
    
}
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0){
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0){
    
}

// called when the table is created destroyed, shown or hidden. configure as necessary.
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0){
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0){
    
}

// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0){
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0){
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0){
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0){
    
}

// return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString NS_DEPRECATED_IOS(3_0,8_0){
    [self filterContentForSearchText:searchString];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption NS_DEPRECATED_IOS(3_0,8_0){
    return YES;
}

- (void) filterContentForSearchText:(NSString*)searchString{
    
    
    //  for (NSString *searchString in searchItems) {
    // each searchString creates an OR predicate for: name, id
    //
    // example if searchItems contains "iphone 599 2007":
    //      name CONTAINS[c] "lanmaq"
    //      id CONTAINS[c] "1568689942"
    NSMutableArray *searchResults = [self.models mutableCopy];
    
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    NSMutableArray *searchItemsPredicate = [NSMutableArray array];
    
    // use NSExpression represent expressions in predicates.
    // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value)
    
    // friendName field matching
    NSExpression *lhs = [NSExpression expressionForKeyPath:@"friendName"];
    NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
    NSPredicate *finalPredicate = [NSComparisonPredicate
                                   predicateWithLeftExpression:lhs
                                   rightExpression:rhs
                                   modifier:NSDirectPredicateModifier
                                   type:NSContainsPredicateOperatorType
                                   options:NSCaseInsensitivePredicateOption];
    [searchItemsPredicate addObject:finalPredicate];
    
    // friendId field matching
    
    lhs = [NSExpression expressionForKeyPath:@"friendId"];
    rhs = [NSExpression expressionForConstantValue:searchString];
    finalPredicate = [NSComparisonPredicate
                      predicateWithLeftExpression:lhs
                      rightExpression:rhs
                      modifier:NSDirectPredicateModifier
                      type:NSContainsPredicateOperatorType
                      options:NSCaseInsensitivePredicateOption];
    [searchItemsPredicate addObject:finalPredicate];
    
    
    
    // at this OR predicate to our master AND predicate
    NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
    [andMatchPredicates addObject:orMatchPredicates];
    //   }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    self.searchArray = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    [self.tableView reloadData];
    
}

@end
