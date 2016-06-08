//
//  GALActionOnCalendar.h
//  写入日历demo
//
//  Created by guanalong on 16/6/7.
//  Copyright © 2016年 smartdot. All rights reserved.
//

//添加事件到日历以及提醒事项
//使用日历需要添加EvenKit库
/*代码示例
 NSDate*startData=[NSDate dateWithTimeIntervalSinceNow:10];
 NSDate*endDate=[NSDate dateWithTimeIntervalSinceNow:20];
 //设置事件之前多长时候开始提醒
 float alarmFloat=-5;
 NSString*eventTitle=@"提醒事件标题";
 NSString*locationStr=@"提醒副标题";
 //isReminder 是否写入提醒事项
 [SSCActionOnCalendar saveEventStartDate:startData endDate:endDate alarm:alarmFloat eventTitle:eventTitle location:locationStr isReminder:YES];
 
 */




#import <Foundation/Foundation.h>

@interface GALActionOnCalendar : NSObject

+ (void)saveEventStartDate:(NSDate*)startData endDate:(NSDate*)endDate alarm:(float)alarm eventTitle:(NSString*)eventTitle location:(NSString*)location notes:(NSString*)notes;


@end
