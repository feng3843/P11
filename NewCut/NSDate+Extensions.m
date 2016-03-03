//
//  NSDate+Extensions.m
//  YHT
//
//  Created by puyun on 15/2/13.
//  Copyright (c) 2015年 puyun. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate(NSDateExtensions)


-(NSString*)GetString_FormatString:(NSString*)formatstring
{
    NSDateFormatter* df= [[NSDateFormatter alloc]init];
    [df setDateFormat:formatstring];
    NSString* str= [df stringFromDate:self];
    return str;
}


-(NSDate*)addDays:(int)days Months:(int)months Years:(int)years
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:days];
    [comps setMonth:months];
    [comps setYear:years];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    return mDate;
}

//添加天数
-(NSDate*)addDays:(int)days
{
    return [self addDays:days Months:0 Years:0];
}

//添加月数
-(NSDate*)addMonths:(int)months
{
    return [self addDays:0 Months:months Years:0];
}

//添加年数
-(NSDate*)addYears:(int)years
{
    return [self addDays:0 Months:0 Years:years];
}

-(NSDate*)addMinutes:(int)minutes Hours:(int)hours
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:hours];
    [comps setMinute:minutes];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    return mDate;
}



@end
