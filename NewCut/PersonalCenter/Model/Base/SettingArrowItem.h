//
//  SettingArrowItem.h
//  0410-彩票
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem

@property(nonatomic,assign)Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
