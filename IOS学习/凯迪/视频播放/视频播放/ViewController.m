//
//  ViewController.m
//  视频播放
//
//  Created by yh on 16/8/12.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "ffmpeg.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "KxMovieViewController.h"


@interface ViewController ()
@property (nonatomic,strong) MPMoviePlayerController  * moviePlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
//    
//        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
//
//    NSString *path1 =[[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"input.wmv"];
//    
//    NSString * path2 = @"http://vodplay.pm.pengpeng.com/vodplay/mp4/YGYQc6Bd9Qip.mp4";
//    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path2
//                                                                            parameters:nil];
//    [self presentViewController:vc animated:YES completion:nil];
    [self nativePlayer];
    
    
}

-(void)nativePlayer
{
    [self.moviePlayer play];
    [self addNotification];
}

-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSString *urlStr=[[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"output.mp4"];
        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSURL * url1 = [NSURL URLWithString:@"http://vodplay.pm.pengpeng.com/vodplay/mp4/YGYQc6Bd9Qip.mp4"];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url1];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}
@end
