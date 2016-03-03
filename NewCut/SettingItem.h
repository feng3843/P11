//
//  SettingItem.h
// 
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SettingItemOption)();

@interface SettingItem : NSObject
/**
 *  头像
 */
@property(nonatomic,copy)NSString *icon;
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)SettingItemOption option;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title;
@end
