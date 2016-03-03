//
//  StarsDetailCell.h
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarsModel;
@interface StarsDetailCell : UITableViewCell

@property StarsModel* model;

@property (nonatomic,strong) UILabel *starName;
@property (nonatomic,strong) UILabel *starLocation;
@property (nonatomic,strong) UILabel *time;
@end
