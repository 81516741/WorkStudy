//
//  GMActivityView.h
//  Gmcchh
//
//  Created by Wilson on 14-5-8.
//  Copyright (c) 2014年 KingPoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMActivityView : UIView
@property (nonatomic,assign)BOOL isFull;//
@property (nonatomic,assign)BOOL hidesWhenStopped;
-(void)startAnimation;
-(void)stopAnimation;
@end
