//
//  ViewController.m
//  写入日历demo
//
//  Created by guanalong on 16/6/6.
//  Copyright © 2016年 smartdot. All rights reserved.
//

#import "ViewController.h"

#import <EventKit/EventKit.h>

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加点击按钮
    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = CGPointMake(self.view.frame.size.width*0.5  , self.view.frame.size.height * 0.5);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"写日历" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)saveEvent:(id)sender
{
//calshow:后面加时间戳格式，也就是NSTimeInterval
//    注意这里计算时间戳调用的方法是-
//    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSinceDate:2016];
    
//    timeIntervalSinceReferenceDate的参考时间是2000年1月1日，
//    [NSDate date]是你希望跳到的日期。
    
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    //06.07 使用 requestAccessToEntityType:completion: 方法请求使用用户的日历数据库
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
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
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
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
                    event.title  = @"测试写入日历事件";
                    event.location = @"北京海淀";
                    
//                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
//                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    //06.07 时间格式
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setAMSymbol:@"AM"];
                    [dateFormatter setPMSymbol:@"PM"];
                    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mmaaa"];
                    NSDate *date = [NSDate date];
                    NSString * s = [dateFormatter stringFromDate:date];
                    NSLog(@"%@",s);
                    
                    //开始时间(必须传)
                    event.startDate = [date dateByAddingTimeInterval:60 * 2];
                    //结束时间(必须传)
                    event.endDate   = [date dateByAddingTimeInterval:60 * 5 * 24];
//                    event.endDate   = [[NSDate alloc]init];
//                    event.allDay = YES;//全天
                
                    //添加提醒
                    //第一次提醒  (几分钟后)
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -1.0f]];
                    //第二次提醒  ()
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -10.0f * 24]];
                    
                    //06.07 add 事件类容备注
                    NSString * str = @"接受信息类容备注";
                    event.notes = [NSString stringWithFormat:@"%@",str];
                    
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
    
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow:"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
