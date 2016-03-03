//
//  NSDate+Extensions.h
//  YHT
//
//  Created by puyun on 15/2/13.
//  Copyright (c) 2015年 puyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(NSDateExtensions)


-(NSString*)GetString_FormatString:(NSString*)formatstring;
//添加天、月、年
-(NSDate*)addDays:(int)days Months:(int)months Years:(int)years;
//添加天数
-(NSDate*)addDays:(int)days;
//添加月数
-(NSDate*)addMonths:(int)months;
//添加年数
-(NSDate*)addYears:(int)years;

-(NSDate*)addMinutes:(int)minutes Hours:(int)hours;

@end
