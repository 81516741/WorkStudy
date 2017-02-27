//
//  VC1.h
//  tableViewController浅浅的研究
//
//  Created by yh on 16/5/13.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC1 : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewSelf;

@end
