//
//  SettingItem.m
//  
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
{
    
    SettingItem * item = [[self alloc]init];
        
    item.icon = icon;
    item.title = title;
    

    return item;
}

+(instancetype)itemWithTitle:(NSString *)title
{
    SettingItem * item = [[self alloc]init];
    item.title = title;
    return item;
}
@end
