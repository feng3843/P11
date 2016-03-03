//
//  FilmCommentCell.h
//  NewCut
//
//  Created by py on 15-7-13.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CommentCellTypeAdmin,
    CommentCellTypeOthers,
    CommentCellTypeAdminGood
}CommentCellType;

@protocol FilmCommentCellDelegate <NSObject>

@optional
-(void)noLogin;

@end

@class CommentModel;
@interface FilmCommentCell : UITableViewCell

@property CommentCellType type;
@property CommentModel* model;

@property(nonatomic,strong) UIImageView *userImage;
@property(nonatomic,strong) UILabel *badCount;
@property(nonatomic,strong) UILabel *username;
@property(nonatomic,strong) UILabel *commentLab;
@property(nonatomic,strong) UIButton *agreeBtn;
@property(nonatomic,strong) UIButton *badBtn;
@property(nonatomic,strong) UILabel *agreeCount;
@property(strong, nonatomic) NSArray *commentArray;
@property(nonatomic,copy)NSString *commentId;

@property(nonatomic ,strong)UIView *line;
@property(nonatomic ,weak)id<FilmCommentCellDelegate> delegate;
//@property (strong) NSInteger n;
@end
