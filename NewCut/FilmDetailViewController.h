//
//  FilmDetailViewController.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmImageCell.h"
#import "FilmDetailCell.h"
#import "FilmIntructionCell.h"
#import "BlankCell.h"
#import "PopularGoodsCell.h"
#import "JoinStarsCell.h"
#import "FilmCommentCell.h"
#import "FourBlankCell.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "GoAllImageBrowseDelegate.h"
#import "FiveBlankCell.h"
#import "MJRefresh.h"
#import "UIViewController+Puyun.h"

@class MovieModel;
@class StarsModel;
@class HotGoodsModel;
@class CommentModel;

@interface FilmDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,GoAllImageBrowseDelegate,PYHTableCellDelagate>
{
    
    NSString *filmname;
    NSString *movieType;
    NSString *movieYear;
    
    NSString *starid;
    NSString *praiseCount;
    
    
    
    int startP;
    int stageP;
    int goodsP;
    int commnentP;
}


@property (strong, nonatomic) IBOutlet UITableView *FilmDetail;
@property (strong,nonatomic) UIButton *backBtn;
@property (strong,nonatomic) UITextField *comment;
@property (strong,nonatomic) UIButton *send;
@property (strong,nonatomic) UIButton *agreeBtn;
@property (strong,nonatomic) UIButton *collectionBtn;
@property (strong,nonatomic) UIButton *shareBtn;
@property (strong,nonatomic) UITableView *filmIntructionView;
@property (strong,nonatomic) NSDictionary *filmDetailInfo;
@property (strong,nonatomic) NSMutableArray *MovieContent;
@property (strong,nonatomic) NSMutableArray *filmStarContent;
@property (nonatomic,strong) NSArray *imgUrlArr;
@property (strong,nonatomic) NSMutableArray *filmImage;
@property (strong,nonatomic) NSMutableArray *filmStarImage;
@property (strong,nonatomic) NSString *strID;
@property (strong,nonatomic) NSMutableArray *filmStarName;
@property (strong,nonatomic) NSMutableArray *filmStarYear;
@property (strong,nonatomic) NSMutableArray *filmStarId;
@property (strong,nonatomic) NSMutableArray *goodPhoto;
@property (strong,nonatomic) NSMutableArray *goodIds;
@property (strong,nonatomic) NSMutableArray *goodsContent;
@property (strong,nonatomic) NSString *movieImage;
@property (strong,nonatomic) NSMutableArray *stageContent;
@property (strong,nonatomic) NSMutableArray *stageImage;
@property (strong,nonatomic) NSMutableArray *praiseCountArray;
@property (nonatomic,strong) NSString *filmsInstruction;
@property (strong,nonatomic) NSMutableArray *commentContent;
@property (strong,nonatomic) NSMutableArray *commentContentList;

@property BOOL flag;
@property NSInteger account;
@property NSString *textContent;
@property (strong, nonatomic) NSArray *filmImages;


@property (nonatomic,retain) NSMutableArray *arrayFilms;
@property (nonatomic,retain) NSMutableArray *arrayStars;
@property (nonatomic,retain) HotGoodsModel* goodsModel;
@property (nonatomic,retain) NSMutableArray *arrayGoods;
@property (nonatomic) CommentModel* systemComment;
@property (nonatomic,retain) NSMutableArray *arrayComments;

-(void)gotoStarDetailView:(NSString*)ID;
-(void)gotoGoodsDetailView:(NSString*)ID;

-(void)jump2BrowseImageViewController:(ExhibitionType)pExhibitionType;
-(void)jump2Detail:(NSString*)index Type:(PYHTableCellType)type;

@end
