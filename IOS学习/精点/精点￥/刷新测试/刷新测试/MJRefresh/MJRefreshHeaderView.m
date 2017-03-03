//
//  MJRefreshHeaderView.m
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  下拉刷新

#import "MJRefreshConst.h"
#import "MJRefreshHeaderView.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"
#import "GMActivityView.h"

@interface MJRefreshHeaderView()
// 最后的更新时间
@property (nonatomic, strong) NSDate *lastUpdateTime;
@property (nonatomic, weak) UILabel *lastUpdateTimeLabel;
@property(nonatomic, strong) CAShapeLayer  * circleLayer;

@end

@implementation MJRefreshHeaderView
#pragma mark - 控件初始化

-(CAShapeLayer *)circleLayer{
    if (_circleLayer == nil) {
        _circleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_circleLayer];
    }
    return _circleLayer;
}

/**
 *  时间标签
 */
- (UILabel *)lastUpdateTimeLabel
{
    if (!_lastUpdateTimeLabel) {
        // 1.创建控件
        UILabel *lastUpdateTimeLabel = [[UILabel alloc] init];
        lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        lastUpdateTimeLabel.font = [UIFont boldSystemFontOfSize:12];
        lastUpdateTimeLabel.textColor = MJRefreshLabelTextColor;
        lastUpdateTimeLabel.backgroundColor = [UIColor clearColor];
        lastUpdateTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lastUpdateTimeLabel = lastUpdateTimeLabel];
        
        // 2.加载时间
        if(self.dateKey){
            self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:self.dateKey];
        } else {
            self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:MJRefreshHeaderTimeKey];
        }
    }
    return _lastUpdateTimeLabel;
}

+ (instancetype)header
{
    return [[MJRefreshHeaderView alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pullToRefreshText = MJRefreshHeaderPullToRefresh;
        self.releaseToRefreshText = MJRefreshHeaderReleaseToRefresh;
        self.refreshingText = MJRefreshHeaderRefreshing;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat statusX = 0;
    CGFloat statusY = 0;
    CGFloat statusHeight = self.mj_height * 0.5;
    CGFloat statusWidth = self.mj_width;
    // 1.状态标签
    self.statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 2.时间标签
    CGFloat lastUpdateY = statusHeight;
    CGFloat lastUpdateX = 0;
    CGFloat lastUpdateHeight = statusHeight;
    CGFloat lastUpdateWidth = statusWidth;
    self.lastUpdateTimeLabel.frame = CGRectMake(lastUpdateX, lastUpdateY, lastUpdateWidth, lastUpdateHeight);
   
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 设置自己的位置和尺寸
    self.mj_y = - self.mj_height;
}

#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    _lastUpdateTime = lastUpdateTime;
    
    // 1.归档
    if(self.dateKey){
        [[NSUserDefaults standardUserDefaults] setObject:lastUpdateTime forKey:self.dateKey];
    }   else{
        [[NSUserDefaults standardUserDefaults] setObject:lastUpdateTime forKey:MJRefreshHeaderTimeKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 2.更新时间
    [self updateTimeLabel];
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    if (!self.lastUpdateTime) return;
    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:self.lastUpdateTime];
    
    // 3.显示日期
    self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
}

#pragma mark - 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;

    // 如果正在刷新，直接返回
    if (self.state == MJRefreshStateRefreshing || self.endingRefresh) return;

    if ([MJRefreshContentOffset isEqualToString:keyPath]) {
        [self adjustStateWithContentOffset];
    }
    
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.mj_contentOffsetY;
    CGFloat currentOffsetYToTop = currentOffsetY + 74;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    // 如果是向上滚动到看不见头部控件，直接返回
    if (currentOffsetY >= happenOffsetY) return;
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_height;
        
        if (self.state == MJRefreshStateNormal && currentOffsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
       
        } else if (self.state == MJRefreshStatePulling && currentOffsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateNormal;
        }
        
        //画旋转圈圈***************************
        CGFloat scale = currentOffsetYToTop/(normal2pullingOffsetY + 74);
        /*
         注意这里的圆心一定要是在它要显示的图层的中心，不然绕z轴旋转的轨迹就很诡异了
        而这里不可以直接设圆心等于self.indicatorView.center ,因为他们不在一个坐标
         系里面，圆是在self.circleLayer 这里个坐标系里面绘制的，所以圆心就是
         (self.circleLayer.bounds.size.width * 0.5, self.circleLayer.bounds.size.height * 0.5)注意啦
         */
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.circleLayer.bounds.size.width * 0.5, self.circleLayer.bounds.size.height * 0.5) radius:self.indicatorView.mj_width * 0.65 startAngle:-M_PI_4 endAngle:-M_PI_4 * 1.3 clockwise:YES];
        self.circleLayer.strokeColor = [UIColor colorWithRed:49/255.0 green:139/255.0 blue:207/255.0 alpha:1].CGColor;
        self.circleLayer.fillColor = [UIColor clearColor].CGColor;
        self.circleLayer.path = path.CGPath;
        self.circleLayer.bounds = CGRectMake(0, 0, 25, 25);
        self.circleLayer.position = self.indicatorView.center;

        
        if (currentOffsetY < -129) {
            //currentOffsetY < -129时，就已经全部看的到circle了，这时候让
            //圈圈画满，不知道为什么，如果不设置，托快了有时候圈圈画不满
            self.circleLayer.strokeEnd = 1;
            //这里是在拖动的时候旋转circle圈的
            self.circleLayer.transform = CATransform3DMakeRotation(-(currentOffsetY + 129) * 0.15 + M_PI_4, 0, 0, 1);
        }else{
            //复位图层的旋转位置
            self.circleLayer.transform = CATransform3DIdentity;
        }
        //这是在绘制圆的进度
        if (scale < 1) {
            self.circleLayer.strokeEnd = scale;
        }
        
    
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = MJRefreshStateRefreshing;
    }
}

#pragma mark 设置状态
- (void)setState:(MJRefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    MJRefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态执行不同的操作
	switch (state) {
		case MJRefreshStateNormal: // 下拉可以刷新
        {
            // 刷新完毕
            if (MJRefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformIdentity;
                // 保存刷新时间
                self.lastUpdateTime = [NSDate date];
                // 移除动画*********************************
                [self.circleLayer removeAnimationForKey:@"rotateAnimation"];
                
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
#warning 这句代码修复了，top值不断累加的bug
                    if (self.scrollViewOriginalInset.top == 0) {
                        self.scrollView.mj_contentInsetTop = 0;
                    } else if (self.scrollViewOriginalInset.top == self.scrollView.mj_contentInsetTop) {
                        self.scrollView.mj_contentInsetTop -= self.mj_height;
                    } else {
                        self.scrollView.mj_contentInsetTop = self.scrollViewOriginalInset.top;
                    }
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;
                }];
            }
			break;
        }
            
		case MJRefreshStatePulling: // 松开可立即刷新
        {
            // 执行动画
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            }];
			break;
        }
            
		case MJRefreshStateRefreshing: // 正在刷新中
        {
            // 执行动画
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                // 1.增加滚动区域
                CGFloat top = self.scrollViewOriginalInset.top + self.mj_height;
                self.scrollView.mj_contentInsetTop = top;
                
                // 2.设置滚动位置
                self.scrollView.mj_contentOffsetY = - top;
                
                // 3.开是旋转circle
                CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                animation.duration = 0.15;
                animation.fromValue = @0;
                animation.toValue = @1;
                animation.cumulative = YES;
                animation.repeatCount = INT16_MAX;
                [self.circleLayer addAnimation:animation forKey:@"rotateAnimation"];
                
            }];
			break;
        }
            
        default:
            break;
	}
}
@end