//
//  GALActionOnCalendar.m
//  写入日历demo
//
//  Created by guanalong on 16/6/7.
//  Copyright © 2016年 smartdot. All rights reserved.
//

#import "GALActionOnCalendar.h"
#import <EventKit/EventKit.h>

@implementation GALActionOnCalendar

+(void)saveEventStartDate:(NSDate *)startData endDate:(NSDate *)endDate alarm:(float)alarm eventTitle:(NSString *)eventTitle location:(NSString *)location notes:(NSString *)notes
{
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //06.07 使用 requestAccessToEntityType:completion: 方法请求使用用户的日历数据库
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                }
                else
                {
                    //事件保存到日历
                    //06.07 元素
                    //title(标题 NSString),
                    //location(位置NSString),
                    //startDate(开始时间 2016/06/07 11:14AM),
                    //endDate(结束时间 2016/06/07 11:14AM),
                    //addAlarm(提醒时间 2016/06/07 11:14AM),
                    //notes(备注类容NSString)
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title  = eventTitle;
                    event.location = location;
                    
                    //设定事件开始时间
                    event.startDate = startData;
                    //设定事件结束时间
                    event.endDate   = endDate;
                    
                    //添加提醒 可以添加多个
                    //第一次提醒  (几分钟q前-)
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -1.0f]];
                    //第二次提醒  ()
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -10.0f * 24]];
                    
                    //06.07 add 事件类容备注
                    event.notes = notes;
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    NSLog(@"保存成功");
                    
                    //直接杀死进程
                    exit(2);
                    
                }
            });
        }];
    }
}


@end
