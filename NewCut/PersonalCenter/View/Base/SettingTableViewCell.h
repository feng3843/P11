//
//  SettingTableViewCell.h
//  0410-彩票
//
//  Created by 夏雪 on 15/6/5.
//  Copyright (c) 2015年 夏雪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"

@interface SettingTableViewCell : UITableViewCell

@property(nonatomic ,strong)SettingItem *item;

@property(nonatomic ,assign,)BOOL IsLong;

- (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)initWithTableView:(UITableView *)tableView;
@end
