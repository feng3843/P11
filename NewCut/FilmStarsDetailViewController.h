//
//  FilmStarsDetailViewController.h
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarsImageCell.h"
#import "StarsDetailCell.h"
#import "StarsIntructionCell.h"
#import "StarBlankCell.h"
#import "PopularGoodsCell.h"
#import "JoinFilmCell.h"
#import "TwoBlankCell.h"
#import "GoAllImageBrowseDelegate.h"
#import "AllStarImageViewController.h"
#import "FilmDetailViewController.h"

@interface FilmStarsDetailViewController : FilmDetailViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,GoAllImageBrowseDelegate>
{
    NSString *starName;
    NSString *Id;
    NSString *starYear;
    NSString *starNation;
    NSString *imageUrl;
    
    
}

@property (strong, nonatomic) IBOutlet UITableView *FilmStarsTable;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UIButton *collectionBtn;
@property (strong,nonatomic) UIButton *shareBtn;
@property (strong,nonatomic) NSDictionary *starDetailInfo;
@property (strong,nonatomic) NSMutableArray *StarContent;
@property (strong,nonatomic) NSMutableArray *stagePhotoImageContent;
//@property (strong,nonatomic) NSString *starId;
//@property (strong,nonatomic) NSDictionary *products;
@property (strong,nonatomic) NSMutableArray *productContent;
@property (strong,nonatomic) NSMutableArray *filmName;
@property (strong,nonatomic) NSMutableArray *filmImage;
@property (strong,nonatomic) NSMutableArray *filmTime;
@property (strong,nonatomic) NSMutableArray *filmId;
@property (strong,nonatomic) NSMutableArray *goodContent;
@property (strong,nonatomic) NSMutableArray *goodIds;
@property (strong,nonatomic) NSMutableArray *goodImage;
@property (strong,nonatomic) NSMutableArray *headImage;
@property (strong,nonatomic) NSString *starInstruction;
//@property (strong,nonatomic) FilmDetailViewController *filmStarsDetail;

@end
