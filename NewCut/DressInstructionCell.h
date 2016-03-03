//
//  DressInstructionCell.h
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotGoodsModel;
@interface DressInstructionCell : UITableViewCell
{
   // NSString *url;

}

@property HotGoodsModel* model;

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *goodName;
@property (nonatomic,strong) NSString *praiseCount;
@property (nonatomic,strong) NSString *relatedCount;
@property (nonatomic,strong) UILabel *goodsBrand;
@property (nonatomic,strong) UILabel *likeCount;
@property (nonatomic,strong) UILabel *commentCount;
@property (nonatomic,strong) UIImageView *goodsImage;

@end
