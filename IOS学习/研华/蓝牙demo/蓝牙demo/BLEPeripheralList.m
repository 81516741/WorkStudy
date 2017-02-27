//
//  BLEPeripheralList.m
//  蓝牙demo
//
//  Created by yh on 16/8/18.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "BLEPeripheralList.h"
#import "BLEManager.h"

@interface BLEPeripheralList ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * peripherals;
@property (nonatomic, strong) dispatch_source_t timer;//定时器
@end

@implementation BLEPeripheralList

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startGCDTimter];
    /*
     这个名字是目标硬件蓝牙的名字，可以由硬件提供，也可以自己搜索周边打印日志看到,
     可以不填，如果不填，当周边有该设备，则不会主动去连接
     */
//    [BLEManager shareBLE].peripheralName = @"YH28000A00E1005ACD000001AA";
    [[BLEManager shareBLE] scanForPeripherals];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(BLECANW) name:@"BLECANW" object:nil];
}

-(void)BLECANW
{
    [self performSegueWithIdentifier:@"BLEWriteVC" sender:nil];
}


#pragma mark - tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.peripherals.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BLEPeripheralList"];
    cell.textLabel.text = [self.peripherals[indexPath.row] name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    CBPeripheral * peripheral = self.peripherals[indexPath.row];
    [[BLEManager shareBLE] connectPeripheral:peripheral];

}

#pragma  mark - GCD定时器
- (void)startGCDTimter
{
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    // 创建一个定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t interval = (uint64_t)(5.0 * NSEC_PER_SEC);
    //表示1.2秒开始执行第一次，以后没3秒执行一次
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC));
    
    dispatch_source_set_timer(self.timer, start, interval, 0);
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        LDLog(@"打印------");
        [self diDaEvent];
    });
    // 启动定时器
    dispatch_resume(self.timer);
}

-(void)diDaEvent
{
    [[BLEManager shareBLE].peripheralList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 > obj2;
    }];
    NSMutableArray * tempArr = @[].mutableCopy;
    [[BLEManager shareBLE].peripheralList enumerateObjectsUsingBlock:^(CBPeripheral *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj.name hasPrefix:@"YH"] || obj.name.length != 26){
            [tempArr addObject:obj];
        }
    }];
    [[BLEManager shareBLE].peripheralList removeObjectsInArray:tempArr];
    self.peripherals = [BLEManager shareBLE].peripheralList.copy;
    [self.tableView reloadData];
    [[BLEManager shareBLE].peripheralList removeAllObjects];
    [[BLEManager shareBLE] scanForPeripherals];
}

-(void)stopGCDTimter
{
    // 取消定时器
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
}

@end
