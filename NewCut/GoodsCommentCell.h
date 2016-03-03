//
//  GoodsCommentCell.h
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsCommentCellDelegate <NSObject>

@optional
-(void)noLogin;

@end
@interface GoodsCommentCell : UITableViewCell

@property (strong, nonatomic) NSArray *commentArray;
@property(nonatomic,strong) UIImageView *userImage;
@property(nonatomic,strong) UILabel *badCount;
@property(nonatomic,strong) UILabel *username;
@property(nonatomic,strong) UILabel *commentLab;
@property(nonatomic,strong) UIButton *agreeBtn;
@property(nonatomic,strong) UIButton *badBtn;
@property(nonatomic,strong) UILabel *agreeCount;
@property(nonatomic,copy)NSString *commentId;

@property(nonatomic ,weak)id<GoodsCommentCellDelegate> delegate;
@end
