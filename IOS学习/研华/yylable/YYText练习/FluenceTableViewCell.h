//
//  FluenceTableViewCell.h
//  YYText练习
//
//  Created by Kingpoint on 16/1/13.
//  Copyright © 2016年 kingpoint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText.h"
@interface FluenceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet YYLabel *yyText;
@property(nonatomic, strong) YYTextLayout  * textLayout;

@end
