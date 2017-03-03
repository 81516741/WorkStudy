//
//  GMActivityView.m
//  Gmcchh
//
//  Created by Wilson on 14-5-8.
//  Copyright (c) 2014年 KingPoint. All rights reserved.
//

#import "GMActivityView.h"
#define FRONT_IMAGE @"bg_ActivityView_normal"
#define BACK_IMAGE  @"bg_ActivityView_hight"
#define SPEED_TIME 1.2
#define SPEED_DELAY 0.05
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
@interface GMActivityView()
@property (nonatomic,strong)UIView *frontView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,assign)BOOL   isStop;
@end

@implementation GMActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}
-(void)configSubViews{
    self.frontView=[[UIView alloc] initWithFrame:self.bounds];
    self.frontView.backgroundColor = [UIColor redColor];
    UIImageView *fImage=[[UIImageView alloc] initWithFrame:self.frontView.bounds];;
    fImage.image=PNGIMAGE(FRONT_IMAGE);
    [self.frontView addSubview:fImage];
    self.frontView.backgroundColor=[UIColor clearColor];
    self.frontView.clipsToBounds=YES;
    
    
    self.backView=[[UIView alloc] initWithFrame:self.bounds];
    self.backView.backgroundColor = [UIColor redColor];
    UIImageView *bImage=[[UIImageView alloc] initWithFrame:self.backView.bounds];;
    bImage.image=PNGIMAGE(BACK_IMAGE);
    [self.backView addSubview:bImage];
    self.backView.backgroundColor=[UIColor clearColor];
    self.backView.clipsToBounds=YES;
    [self addSubview:self.backView];
    [self addSubview:self.frontView];
    
}
-(void)setIsFull:(BOOL)isFull{
    _isFull=isFull;
    if (!isFull) {
        self.frontView.frame=self.bounds;
    }else{
        CGRect rect=self.bounds;
        rect.size.height=0;
        self.frontView.frame=rect;
    }
}

-(void)startAnimation{

    __weak GMActivityView *weakSelf=self;
    self.hidden=NO;
    self.isFull=NO;
    self.isStop=NO;
    CGRect rect=self.bounds;
    rect.size.height=0;
    
    [UIView animateWithDuration:SPEED_TIME delay:SPEED_DELAY options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.frontView.frame=rect;
    } completion:^(BOOL finished) {
        
        if (weakSelf.isStop) {
            
            return;
            
        }
        
        [weakSelf startAnimation];
        
    }];
 
    
}
-(void)stopAnimation{
    
    self.isStop=YES;
    self.isFull=YES;
    if (self.hidesWhenStopped) {
        self.hidden=YES;
    }
}



@end
