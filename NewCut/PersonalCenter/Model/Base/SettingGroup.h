//
//  SettingGroup.h
//  
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingItem.h"
@interface SettingGroup : NSObject

@property(nonatomic,copy)NSString *header;

@property(nonatomic,copy)NSString *footer;

@property(nonatomic,strong)NSArray *items;

@end
