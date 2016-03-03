//
//  GoodViewCell.h
//  NewCut
//
//  Created by py on 15-7-29.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *goodsImage;
@property(nonatomic,strong) UILabel *goodsName;
@property(nonatomic,strong) UILabel *detailName;
@property(nonatomic,strong) UILabel *likeCount;
@property(nonatomic,strong) UILabel *commentCount;
@property(nonatomic,strong) UILabel *title1;
@property(nonatomic,strong) UILabel *title2;

@end
