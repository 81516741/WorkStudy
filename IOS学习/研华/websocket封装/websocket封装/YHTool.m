//
//  YHDateTool.m
//  DriveCloudPhone
//
//  Created by yh on 16/3/17.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "YHTool.h"
#import "YHHTTPManage.h"
#import "MJExtension.h"

@implementation YHHttpTool

+(void)makeAppointByParamas:(id)paramas taskTag:(int32_t)taskTag success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure
{
    YHHTTPModel * message = [YHHTTPModel new];
    message.httpType = YHHTTPTypePost;
    message.taskTag = taskTag;
    message.url = AppointMakelURL;
    message.parameters = paramas;
    @try {
        [[YHHTTPManage shared]sendMessage:message success:^(YHHTTPModel *model) {
            if ([model.data[@"status"] integerValue] == 0) {
                YHLog(@"预约成功");
                success(model);
            }else{
                model.errorOfMy = model.data[@"error"];
                YHLog(@"预约失败,失败原因\n:%@",model.errorOfMy);
                failure(model);
                
            }
            
        } failure:^(YHHTTPModel *model) {
            YHLog(@"预约失败,失败原因\n:%@",model.errorOfAFN);
            failure(model);
        }];
    } @catch (NSException *exception) {
    }
}

+(void)getAppointListByStartPageNum:(NSString *)pageNum maxDataCount:(NSString *)maxDataCount taskTag:(int32_t)taskTag dataClass:(Class)dataClass success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure{
    YHHTTPModel * message = [YHHTTPModel new];
    message.httpType = YHHTTPTypeGet;
    message.taskTag = taskTag;
    message.url = AppointListURL;
    message.dataClass = dataClass;
    NSMutableDictionary * paramasDic = [NSMutableDictionary dictionary];
    [paramasDic setObject:[YHSingleObj shared].userID forKey:@"strUserID"];
    [paramasDic setObject:[YHSingleObj shared].carID forKey:@"strCarID"];
    [paramasDic setObject:maxDataCount forKey:@"strPageSize"];
    [paramasDic setObject:pageNum forKey:@"strPageNum"];
    message.parameters = paramasDic;
    @try {
        [[YHHTTPManage shared]sendMessage:message success:^(YHHTTPModel *model) {
            if ([model.data[@"status"] integerValue] == 0) {
                YHLog(@"获取数据成功");
                model.data = [dataClass mj_objectArrayWithKeyValuesArray:model.data[@"orders"]];
                success(model);
            }else{
                YHLog(@"获取数据失败,失败原因\n:%@",model.errorOfMy);
                model.errorOfMy = model.data[@"error"];
                failure(model);
                
            }
            
        } failure:^(YHHTTPModel *model) {
            YHLog(@"获取数据失败,失败原因\n:%@",model.errorOfAFN);
            failure(model);
        }];
    } @catch (NSException *exception) {
    }
}

+(void)cancelAppointByAppointmentID:(NSNumber *)appointID  taskTag:(int32_t )taskTag success:(void (^)(YHHTTPModel *))success failure:(void (^)(YHHTTPModel *))failure{
    YHHTTPModel * message = [YHHTTPModel new];
    message.httpType = YHHTTPTypePost;
    message.taskTag = taskTag;
    message.url = AppointCancelURL;
    NSMutableDictionary * paramasDic = [NSMutableDictionary dictionary];
    [paramasDic setObject:[YHSingleObj shared].userID forKey:@"strUserID"];
    [paramasDic setObject:appointID forKey:@"strAppointmentID"];
    message.parameters = paramasDic;
    @try {
        [[YHHTTPManage shared]sendMessage:message success:^(YHHTTPModel *model) {
            if ([model.data[@"status"] integerValue] == 0) {
                YHLog(@"取消成功");
                success(model);
            }else{
                YHLog(@"取消失败,失败原因\n:%@",model.errorOfMy);
                model.errorOfMy = model.data[@"error"];
                failure(model);
                
            }
            
        } failure:^(YHHTTPModel *model) {
            YHLog(@"取消失败,失败原因\n:%@",model.errorOfAFN);
            failure(model);
        }];
    } @catch (NSException *exception) {
    }
}

+(void)cancelHttpRequestByTaskTag:(int32_t)taskTag
{
    [[YHHTTPManage shared]cancelTaskByTaskTag:taskTag];
}
@end