//
//  ViewController.m
//  数字时钟
//
//  Created by ld on 16/12/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *digitalsView;
@property (nonatomic,strong) NSTimer *  timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *digits = [UIImage imageNamed:@"pic"];
    
    //set up digit views
    for (UIView *view in self.digitalsView) {
        //set contents
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
        view.layer.magnificationFilter = kCAFilterNearest;
    }
    
    //start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    //set initial clock time
    [self tick];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour |NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    //set hours
    [self setDigit:components.hour / 10 forView:self.digitalsView[0]];
    [self setDigit:components.hour % 10 forView:self.digitalsView[1]];
    
    //set minutes
    [self setDigit:components.minute / 10 forView:self.digitalsView[2]];
    [self setDigit:components.minute % 10 forView:self.digitalsView[3]];
    
    //set seconds
    [self setDigit:components.second / 10 forView:self.digitalsView[4]];
    [self setDigit:components.second % 10 forView:self.digitalsView[5]];
}

@end
