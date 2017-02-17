//
//  ViewController.m
//  baiduditu
//
//  Created by yh on 16/4/5.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface ViewController ()
@property(weak,nonatomic)BMKMapView * mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.mapView = mapView;
    self.view = mapView;
    [_mapView setTrafficEnabled:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.mapView.delegate = nil;
}
@end
