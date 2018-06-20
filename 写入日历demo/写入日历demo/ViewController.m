//
//  ViewController.m
//  写入日历demo
//
//  Created by guanalong on 16/6/6.
//  Copyright © 2016年 smartdot. All rights reserved.
//

#import "ViewController.h"

#import "GALActionOnCalendar.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加点击按钮???
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
//    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSString* string  = @"2016-08-13 21:28";
//    //开始时间
//    NSDate* startDate = [inputFormatter dateFromString:string];
//    
//    NSString* string1 = @"2016-08-13 21:28";
//    //结束时间
//    NSDate* endDate   = [inputFormatter dateFromString:string1];
    
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setAMSymbol:@"AM"];
    [dateFormatter setPMSymbol:@"PM"];
    [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mmaaa"];
    NSDate *date = [NSDate date];
    NSString * s = [dateFormatter stringFromDate:date];
    NSLog(@"%@",s);
    
    //开始时间(必须传)
    NSDate * startDate = [date dateByAddingTimeInterval:60 * 2];
    //结束时间(必须传)
    NSDate * endDate   = [date dateByAddingTimeInterval:60 * 5 * 24];
    
    
    //设置事件之前多长时候开始提醒
    float alarmFloat      = -500;
    NSString *eventTitle  = @"提醒主题";
    NSString *location = @"提醒内容";
    NSString *notes = @"接受信息类容备注";
    
    //isReminder 是否写入提醒事项
    [GALActionOnCalendar saveEventStartDate:startDate endDate:endDate alarm:alarmFloat eventTitle:eventTitle location:location notes:notes];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
