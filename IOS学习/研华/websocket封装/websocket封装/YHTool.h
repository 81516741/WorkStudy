//
//  YHDateTool.h
//  DriveCloudPhone
//
//  Created by yh on 16/3/17.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

//tag列表.
#define kAppointMakeTaskTag         0x0DA00000  //预约的taskTag
#define kAppointTaskTag         0x0DA00001  //预约详情单查询的taskTag
#define kAppointCancelTaskTag         0x0DA00002  //取消预约的taskTag

//查询预约列表的URL
#define AppointListURL      [NSString stringWithFormat:@"%@/cardealer/api-get/get-order-list.html",CARHOME_URL]
#define AppointCancelURL    [NSString stringWithFormat:@"%@/cardealer/api-get/cancel-order.html",CARHOME_URL]
#define AppointMakelURL    [NSString stringWithFormat:@"%@/cardealer/api-get/maintain-appoint.html",CARHOME_URL]

@class YHHTTPModel;
@interface YHHttpTool : NSObject
/**
 * 预约
 */
+(void)makeAppointByParamas:(id)paramas taskTag:(int32_t )taskTag success:(void(^)(YHHTTPModel * model)) success failure:(void(^)(YHHTTPModel * model)) failure;


/**
 * 获取预约列表
 */
+(void)getAppointListByStartPageNum:(NSString *)pageNum maxDataCount:(NSString *)maxDataCount taskTag:(int32_t )taskTag dataClass:(Class)dataClass success:(void(^)(YHHTTPModel * model)) success failure:(void(^)(YHHTTPModel * model)) failure;
/**
 * 取消预约列表
 */
+(void)cancelAppointByAppointmentID:(NSNumber *)appointID  taskTag:(int32_t )taskTag success:(void(^)(YHHTTPModel * model)) success failure:(void(^)(YHHTTPModel * model)) failure;


/**
 * 取消该描述的task网络任务
 */
+(void)cancelHttpRequestByTaskTag:(int32_t)taskTag;

@end
