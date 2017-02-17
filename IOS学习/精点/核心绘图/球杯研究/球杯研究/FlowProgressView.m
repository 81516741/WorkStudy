//
//  FlowProgressView.m
//  VinTest
//
//  Created by Vin on 14-12-12.
//  Copyright (c) 2014年 kingpoint. All rights reserved.
//

#import "FlowProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
//color
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface FlowProgressView () {
    UIColor *_waterColor;
    UIColor *_waterShadowColor;
    float drwaProgress;
    float a;
    float b;
    BOOL jia;
    BOOL isProgressChange;
}

@property (nonatomic, readonly) CAGradientLayer* gradientLayer;
@property (nonatomic, strong) NSThread *progressThread;
@property (nonatomic, strong) NSThread *waveThread;

@end

@implementation FlowProgressView

#pragma mark - View Lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configBackground];
        
        a = 1.5;
        b = 0;
        jia = NO;
        
        self.progress = 0.f;
        drwaProgress = 0.f;
    }
    return self;
}

- (void)dealloc {
    [self cancelProgressThread];
    [self cancelWaveThread];
}

#pragma mark - Gradient Layer

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (void)setShape:(CGPathRef)shape {
    if (shape == nil) {
        self.gradientLayer.mask = nil;
    }
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = shape;
    self.gradientLayer.mask = maskLayer;
}

//设置圆球渐变背景色
- (void)updateGradientColors {
    self.gradientLayer.colors = [[NSArray alloc] initWithObjects:
                                 (id)RGB(81, 164, 229).CGColor,
                                 (id)RGB(50, 135, 210).CGColor,
                                 (id)RGB(20, 110, 190).CGColor,nil];
    [self.gradientLayer setNeedsDisplay];
}

#pragma mark Public

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    CGFloat pinnedProgress = MIN(MAX(progress, 0.f), 1.f);
    int i = (int)(pinnedProgress*100);
    _progress = pinnedProgress;
    
    if (animated) {
        [self cancelProgressThread];
        
        if (self.delegate && [self.delegate performSelector:@selector(flowProgressViewStartProgress:) withObject:nil]) {
            [self.delegate flowProgressViewStartProgress:self];
        }
        
        isProgressChange = YES;
        drwaProgress = 0;
        [self setNeedsDisplay];
        
        self.progressThread = [[NSThread alloc] initWithTarget:self selector:@selector(animateProgress) object:nil];
        [self.progressThread start];
        
    } else {
        isProgressChange = NO;
        [self onMainChangeProgress:[NSNumber numberWithInt:i]];
    }
}

- (void)setProgress:(CGFloat)progress flowLevel:(FlowLevel)level {
    [self setProgress:progress animated:YES];
    [self updateSubViewsWithFlowLevel:level];
}

-(void)stopAnimation{
    [self cancelProgressThread];
    [self cancelWaveThread];
}

#pragma mark - Private

- (void)configBackground {
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.image = [UIImage imageNamed:@"flow_circle"];
    [self addSubview:bgImageView];
}

- (void)updateSubViewsWithFlowLevel:(FlowLevel)level {
    UIColor *tipColor = nil;
    UIColor *laveColor = nil;
    switch (level) {
        case Flow_Level_Ample:
            tipColor = [UIColor whiteColor];
            laveColor = [UIColor whiteColor];
            _waterColor = RGB(14 , 112, 198);
            _waterShadowColor = RGB(50, 147, 224);
            break;
            
        case Flow_Level_Tight:
            tipColor = RGB(219, 0, 97);
            laveColor = [UIColor whiteColor];
            _waterColor = RGB(219, 0, 97);
            _waterShadowColor = RGB(234, 75, 160);
            break;
            
        case Flow_Level_Drain:
            tipColor = RGB(51, 51, 51);
            laveColor = RGB(51, 51, 51);
            _waterColor = RGB(219, 0, 97);
            _waterShadowColor = RGB(234, 75, 160);
            break;
            
        case Flow_Level_Overspend:
            tipColor = RGB(219, 0, 97);
            laveColor = RGB(219, 0, 97);
            _waterColor = RGB(219, 0, 97);
            _waterShadowColor = RGB(234, 75, 160);
            break;
        default:
            break;
    }
}

#pragma Progress & Wave Animation

- (void)animateWave {
    while (TRUE) {
        if ([[NSThread currentThread] isCancelled]) {
            [NSThread exit];
        }
        [self performSelectorOnMainThread:@selector(onMainWave) withObject:nil waitUntilDone:NO];
        [NSThread sleepForTimeInterval:0.03];
    }
}

- (void)onMainWave {
    if (jia) {
        a += 0.01;
        
    }else{
        a -= 0.01;
    }
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    b+=0.1;
    
    [self setNeedsDisplay];
}

#pragma mark Progress Animation

- (void)animateProgress {
    int num = (int)(self.progress*100);
    int i = 0;
    while (isProgressChange) {
        if ([[NSThread currentThread] isCancelled]) {
            [NSThread exit];
        }
        if (i == num) {
            isProgressChange = NO;
            [NSThread sleepForTimeInterval:0.03];
            [self performSelectorOnMainThread:@selector(onMainChangeProgress:) withObject:[NSNumber numberWithInteger:i] waitUntilDone:YES];
            break;
            
        } else {
            i ++;
        }
        
        [NSThread sleepForTimeInterval:0.03];
        [self performSelectorOnMainThread:@selector(onMainChangeProgress:) withObject:[NSNumber numberWithInt:i] waitUntilDone:NO];
    }
}

- (void)onMainChangeProgress:(NSNumber *)number {
    @synchronized(self) {
        int i = [number intValue];
        drwaProgress = (float)i/100;
        [self setNeedsDisplay];
        
        if (!self.waveThread || !self.waveThread.isExecuting) {
            self.waveThread = [[NSThread alloc] initWithTarget:self selector:@selector(animateWave) object:nil];
            [self.waveThread start];
        }
        
        if (!isProgressChange) {
            if (self.delegate && [self.delegate performSelector:@selector(flowProgressViewEndedProgress:) withObject:nil]) {
                [self.delegate flowProgressViewEndedProgress:self];
            }
        //永不停止
//            [self performSelector:@selector(cancelWaveThread) withObject:nil afterDelay:2.f];
        }
    }
}

#pragma Cancel Thread

- (void)cancelProgressThread {
    if (self.progressThread && self.progressThread.isExecuting) {
        [self.progressThread cancel];
        self.progressThread = nil;
    }
}

- (void)cancelWaveThread {
    if (self.waveThread && self.waveThread.isExecuting) {
        [self.waveThread cancel];
        self.waveThread = nil;
    }
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    //Draw Wave
    CGContextSetLineWidth(context, 1);
    
    float waveHeight = rect.size.height*(1-drwaProgress);
    float y = waveHeight;
    
    CGPathMoveToPoint(path1, NULL, 0, y);
    CGPathMoveToPoint(path2, NULL, 0, y);
    if (y == 0 || y == rect.size.height) {
        CGPathAddLineToPoint(path1, nil, rect.size.width, y);
        CGPathAddLineToPoint(path2, nil, rect.size.width, y);

    } else {
        for (float x=0; x<=rect.size.width; x++){
            y = a * sin(x/rect.size.width*M_PI - 4*b/M_PI) * 3 + waveHeight;
            CGPathAddLineToPoint(path1, nil, x, y);
            
            y = a * sin(x/rect.size.width*M_PI + 4*b/M_PI) * 5 + waveHeight;
            CGPathAddLineToPoint(path2, nil, x, y);
        }
    }
    
    CGPathAddLineToPoint(path1, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path1, nil, 0, waveHeight);
    
    CGContextSetFillColorWithColor(context, [_waterShadowColor CGColor]);
    CGContextAddPath(context, path1);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathAddLineToPoint(path2, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path2, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path2, nil, 0, waveHeight);
    
    CGContextSetFillColorWithColor(context, [_waterColor CGColor]);
    CGContextAddPath(context, path2);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathRelease(path1);
    CGPathRelease(path2);
}


@end
