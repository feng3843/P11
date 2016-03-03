//
//  DressDetailViewController.h
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DressImageCell.h"
#import "DressBlankCell.h"
#import "DressInstructionCell.h"
#import "DressBottomBlankCell.h"
#import "GoodsCommentCell.h"
#import "GoAllImageBrowseDelegate.h"
#import "AllGoodsImageViewController.h"
#import "TitleBlankCell.h"
#import "LineBlankCell.h"
#import "commentTextCell.h"
#import "MJRefresh.h"
#import "FilmDetailViewController.h"

@interface DressDetailViewController : FilmDetailViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,GoAllImageBrowseDelegate>
{
    NSString *name;
    NSString *goodPhotoUrl;
    
    NSString *PraiseCount;
    NSString *Related;

}

@property (strong, nonatomic) IBOutlet UITableView *DressDetailTable;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UIButton *collectionBtn;
@property (strong,nonatomic) UIButton *shareBtn;

@property (strong, nonatomic) NSArray *filmImages;
@property (strong,nonatomic) UITextField *comment;
@property (strong,nonatomic) UIButton *send;
@property (strong,nonatomic) NSString *goodId;
@property (strong,nonatomic) NSDictionary *filmDetailInfo;
@property (strong,nonatomic) NSMutableArray *goodContent;
@property (strong,nonatomic) NSMutableArray *goodPhotoContent;
@property (strong,nonatomic) NSMutableArray *commentContent;
@property (strong,nonatomic) NSMutableArray *goodPhotoImageArray;
@property (strong,nonatomic) NSMutableArray *goodCommentContentList;
//@property (strong,nonatomic) ;

@end
