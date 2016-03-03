//
//  SettingArrowItem.m
//  0410-彩票
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    SettingArrowItem *item = [self itemWithIcon:icon title:title];
    
    item.destVcClass = destVcClass;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    SettingArrowItem *item = [self itemWithTitle:title];
    
    item.destVcClass = destVcClass;
    return item;
}
@end
