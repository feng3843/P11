//
//  FilmDetailViewController.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

#import "FilmDetailViewController.h"
#import "PYAllCommon.h"
#import "BrowseImageViewController.h"
#import "FilmStarsDetailViewController.h"
#import "DressDetailViewController.h"
#import "AllImageViewController.h"
#import "FilmDetailModel.h"
#import "DataBaseTool.h"
#import "ContactsNavViewController.h"
#import "CMData.h"

#import "SDImageView+SDWebCache.h"
#import "ImageBrowseController.h"
#import "UIImage+RTTint.h"

#import "MovieModel.h"
#import "StarsModel.h"
#import "HotGoodsModel.h"
#import "CommentModel.h"
#import "UIImage+Extensions.h"
//#import "zxViewController.h"
@interface FilmDetailViewController ()<FilmCommentCellDelegate>
{
    FilmDetailViewController *filmDetailView;
    FilmStarsDetailViewController *filmStarsDetail;
    DressDetailViewController *dressDetailView;
    
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
    
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;
@property (weak, nonatomic) UIView *bgview;
@property (nonatomic,assign) BOOL isMoving;

@property(nonatomic ,copy)NSString *commentCount;
@property(nonatomic ,weak)UIView *commentView;

@end

@implementation FilmDetailViewController
@synthesize FilmDetail,backBtn,comment,send,flag,agreeBtn,shareBtn,collectionBtn,filmImages,filmIntructionView,filmDetailInfo,MovieContent,imgUrlArr,filmImage,strID,filmStarContent,filmStarImage,filmStarName,filmStarYear,goodPhoto,goodIds,goodsContent,movieImage,stageContent,stageImage,account,filmStarId,praiseCountArray,filmsInstruction,commentContent,commentContentList,textContent;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"";
    /**夏雪**/
    self.navigationController.navigationBarHidden = NO;
    
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    self.FilmDetail.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 64)];

    bgview.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    bgview.alpha = 0;
    self.bgview = bgview;
    [self.view addSubview:bgview];
  
     self.FilmDetail.contentOffset = CGPointMake(0,64);


    /**夏雪**/
    
    
//    CGFloat hi = FilmDetail.contentSize.height;
//    NSString *str = [NSString stringWithFormat:@"%f",hi];
//    [SVProgressHUD showInfoWithStatus:str];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self setUpForDismissKeyboard];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
  
    
    comment.delegate = self;
    
    filmIntructionView.separatorStyle = UITableViewCellSelectionStyleDefault;
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16*h/568, 30*h/568, 23*h/568,23*h/568)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(185*h/568, 30*h/568, 23*h/568, 23*h/568)];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"bt_good"] forState:UIControlStateNormal];
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"bt_good_2"] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if([DataBaseTool isCollectAgree:self.strID :@"1"])
    {
        self.agreeBtn.selected = YES;
    }
    UIBarButtonItem *agreeItem = [[UIBarButtonItem alloc]initWithCustomView:self.agreeBtn];
    

    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(227*h/568, 30*h/568, 23 *h/568, 23*h/568)];
    self.collectionBtn = collectBtn;
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect"] forState:UIControlStateNormal];
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect_2"] forState:UIControlStateSelected];
    
    [self.collectionBtn addTarget:self action:@selector(filmCollectClick) forControlEvents:UIControlEventTouchUpInside];
    FilmDetailModel *model = [[FilmDetailModel alloc]init];
    model.movieId = self.strID;
    if ([DataBaseTool isCollectedFilm:model]) {
        self.collectionBtn.selected = YES;
    }
    
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc]initWithCustomView:self.collectionBtn];
    
   shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(270*h/568, 30*h/568, 23*h/568, 23*h/568)];
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(270*h/568, 20*h/568, 2*1.5*h/568, 23*h/568);
    UIBarButtonItem *divideView = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItems = @[shareItem,divideView,collectionItem,divideView,agreeItem];
    
    /**夏雪**/
    
    self.FilmDetail.showsVerticalScrollIndicator = NO;
    //self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
    
    if (![self isKindOfClass:[FilmStarsDetailViewController class]]) {
//
        UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, 525*h/568, fDeviceWidth, 45*h/568)];
        commentView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        [self.view addSubview:commentView];
        UIView *commentLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 0.5)];
        commentLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [commentView addSubview:commentLine];
        self.commentView = commentView;
        self.comment = [[UITextField alloc]initWithFrame:CGRectMake(11*h/568, 6.5*h/568, 238*h/568, 32*h/568)];
        comment.borderStyle = UITextBorderStyleNone;
        comment.placeholder = @"写评论......";
        comment.background = [UIImage resizedImage:@"text.png"];
//        comment.layer.cornerRadius = 0.5;
        [comment setTintColor:[UIColor blackColor]];
        comment.keyboardType = UIKeyboardTypeDefault;
        [commentView addSubview:comment];
        //
        //
        self.send = [[UIButton alloc]initWithFrame:CGRectMake(257*h/568, 6.5*h/568, 55*h/568, 32*h/568)];
        send.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        [send setBackgroundImage:[UIImage resizedImage:@"send.png"] forState:UIControlStateNormal];
        UILabel *btnTitle  = [[UILabel alloc] initWithFrame:CGRectMake(14*h/568, 9*h/568, 30*h/568, 15*h/568)];
        btnTitle.textColor = [UIColor colorWithHexString:@"999999"];
        btnTitle.text = @"发送";
        btnTitle.font = [UIFont systemFontOfSize:14*h/568];
        [send addSubview:btnTitle];
        [send addTarget:self action:@selector(addCommentForFilm) forControlEvents:UIControlEventTouchUpInside];
        //send.layer.cornerRadius = 0.5;
        send.layer.borderWidth = 0.5;
            send.layer.borderColor = [UIColor colorWithHexString:@"bababa"].CGColor;
        [commentView addSubview:send];
    }

    //UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    
   // [recognizer delaysTouchesBegan];
   // [self.view addGestureRecognizer:recognizer];
    
    filmDetailInfo = [[NSDictionary alloc] init];
    MovieContent = [[NSMutableArray alloc] init];
    filmStarContent = [[NSMutableArray alloc] init];
    goodsContent = [[NSMutableArray alloc] init];
    stageContent = [[NSMutableArray alloc] init];
    filmImage = [[NSMutableArray alloc] init];
    filmStarImage = [[NSMutableArray alloc] init];
    filmStarName = [[NSMutableArray alloc] init];
    filmStarYear = [[NSMutableArray alloc] init];
    filmStarId = [[NSMutableArray alloc] init];
    goodPhoto = [[NSMutableArray alloc] init];
    goodIds = [[NSMutableArray alloc] init];
    stageImage = [[NSMutableArray alloc]init];
    praiseCountArray = [[NSMutableArray alloc]init];
    commentContent = [[NSMutableArray alloc]init];
    commentContentList = [[NSMutableArray alloc]init];
    
     startP = 1;
     stageP = 1;
     goodsP = 1;
     commnentP = 1;
    
    self.arrayFilms = [[NSMutableArray alloc]init];
    self.arrayStars = [[NSMutableArray alloc]init];
    self.arrayGoods = [[NSMutableArray alloc]init];
    self.arrayComments = [[NSMutableArray alloc]init];
    
     self.FilmDetail.tableFooterView = [[UIView alloc]init];
    
//    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                                                 action:@selector(paningGestureReceive:)];
//    [recognizer delaysTouchesBegan];
//    [self.view addGestureRecognizer:recognizer];
    [self reloadData];
    if(![self isKindOfClass:[FilmStarsDetailViewController class]]&&![self isKindOfClass:[DressDetailViewController class]])
    {
        [self getFilmDetail];
    }

    //[self initImageArray];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]
     ];
    self.navigationController.navigationBar.translucent = YES;
    self.FilmDetail.delegate = self;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.FilmDetail addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [self.FilmDetail headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.FilmDetail addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.FilmDetail.headerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_DOWN_TO_REFRESH, @"");
//    self.FilmDetail.headerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_REFRESH, @"");
//    self.FilmDetail.headerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING, @"");
    
    self.FilmDetail.footerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_UP_TO_LOAD_MORE, @"");
    self.FilmDetail.footerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_LOAD_MORE, @"");
    self.FilmDetail.footerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING_MORE, @"");
}


#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    // 2.2秒后刷新表格UI
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self reloadData];
//    });
//}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        commnentP++;
        [self getFilmDetailInfo_Comment];
    });
}

-(void)reloadData
{
    [self.FilmDetail reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.FilmDetail headerEndRefreshing];
    [self.FilmDetail footerEndRefreshing];
    
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
}



-(void)loadNewData:(NSInteger)page Type:(PYHTableCellType)type
{
    switch (type) {
        case PYHTableCellGoods:
            break;
        case PYHTableCellMovie:
            break;
        case PYHTableCellStar:
            break;
        default:
            break;
    }
}

-(void)loadOldData:(NSInteger)page Type:(PYHTableCellType)type
{
    switch (type) {
        case PYHTableCellGoods:
            [self getFilmDetailInfo_Goods];
            break;
        case PYHTableCellMovie:
            [self getFilmDetailInfo_Stage];
            break;
        case PYHTableCellStar:
            [self getFilmDetailInfo_Star];
            break;
        default:
            break;
    }
}

-(void)jump2Detail:(NSString*)index Type:(PYHTableCellType)type
{
    switch (type) {
        case PYHTableCellGoods:
            [self gotoGoodsDetailView:index];
            break;
        case PYHTableCellMovie:
            [self gotoFilmDetailView:index];
            break;
        case PYHTableCellStar:
            [self gotoStarDetailView:index];
            break;
        default:
            break;
    }
}

-(void)getFilmDetail
{
    [self getFilmDetailInfo_Movies];
//    [self performSelector:@selector(getFilmDetailInfo_Star) withObject:nil afterDelay:0.1];
//    [self performSelector:@selector(getFilmDetailInfo_Stage) withObject:nil afterDelay:0.2];
//    [self performSelector:@selector(getFilmDetailInfo_Goods) withObject:nil afterDelay:0.3];
//    [self performSelector:@selector(getFilmDetailInfo_Comment) withObject:nil afterDelay:0.4];
    [self getFilmDetailInfo_Star];
    [self getFilmDetailInfo_Stage];
    [self getFilmDetailInfo_Goods];
    [self getFilmDetailInfo_Comment];

}

//滑动事件处理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.comment.isFirstResponder)
    {
        [self.comment resignFirstResponder];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (!self.FilmDetail.isFooterRefreshing) {
        [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
        self.commentView.hidden = YES;
    }
//    self.comment.hidden = YES;
//    self.send.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"big" object:nil];

//    CGPoint point = scrollView.contentOffset;

    
    /**夏雪**/
    CGFloat offset=scrollView.contentOffset.y;
    
    if(offset <=0)
    {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
       if (offset < (208 )){
        CGFloat alpha= 1 - (208 - offset)/208.0;
        self.bgview.alpha = alpha *0.95;
        
        UIImage *oldImage = [UIImage imageNamed:@"bt_back"];
        UIImage *newImage =  [oldImage rt_darkenWithLevel:alpha *0.5 ];
  
        [self.backBtn setBackgroundImage:newImage forState:UIControlStateNormal];
           
        UIImage *shareImage = [UIImage imageNamed:@"shareBtn"];
           UIImage *shareImageNew =  [shareImage rt_darkenWithLevel:alpha*0.5];
        [self.shareBtn setBackgroundImage:shareImageNew forState:UIControlStateNormal];
        
        UIImage *collectionImage = [UIImage imageNamed:@"bt_collect"];
        UIImage *collectionImageNew =  [collectionImage rt_darkenWithLevel:alpha*0.5];
        [self.collectionBtn setBackgroundImage:collectionImageNew forState:UIControlStateNormal];
        
        UIImage *agreeImage = [UIImage imageNamed:@"bt_good"];
        UIImage *agreeImageNew =  [agreeImage rt_darkenWithLevel:alpha*0.5];
        [self.agreeBtn setBackgroundImage:agreeImageNew forState:UIControlStateNormal];
        
    }
    if (self.bgview.alpha > 0.5) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
//
    
    /**夏雪**/
}

-(void)share:(id)sender
{
    [self shareImage:sender];
}


//对影视进行评论
-(void)addCommentForFilm
{
    
    NSString *commentType = @"1";
    NSString *Content = self.comment.text;
    NSInteger ID = [self.strID intValue];
    NSString *userToken = [CMData getToken];
    NSString *userId = [CMData getUserId ];
    NSInteger Id = [userId intValue];
    
    NSDictionary *params = @{@"token":userToken,@"movieGoodId":@(ID),
                             @"comment":Content,@"type":commentType,
                             @"userId":@(Id)};
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else if (!userToken||[userToken isEqualToString:@""]){
        
        [self.comment endEditing:YES];
        [self noLogin];
    
    }else{
        
        if([Content isEqualToString:@""]){
            
            [SVProgressHUD showInfoWithStatus:@"评论内容不能为空！"];
        }
        else if (Content.length > 200)
        {
            [SVProgressHUD showInfoWithStatus:@"评论过长！"];
        }else{
            [CMAPI postUrl:API_COMMENT_ADDCOMMENT Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
                
                id result = [detailDict objectForKey:@"code"];
                if(succeed){
                    [SVProgressHUD showInfoWithStatus:@"评论成功！"];
                    
                    CommentModel* commentModel = [[CommentModel alloc] init];
                    if (![[DataBaseTool getNickName] isEqualToString:@""]) {
                        commentModel.strName = [DataBaseTool getNickName];
                    }else
                    {
                        commentModel.strName = [DataBaseTool getUserPhone];
                    }
                    commentModel.strID =[[[detailDict objectForKey:@"result"] objectForKey:@"success"][0] objectForKey:@"id"];
                    commentModel.strPhoto = [DataBaseTool getuserImage];
                    commentModel.strDescription = Content;
                    commentModel.strPraise = @"0";
                    commentModel.strTsuCount = @"0";
                    [self.arrayComments insertObject:commentModel atIndex:0];
                    [self.comment setText:@""];
                    [self reloadData];
                    [self.FilmDetail scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:11] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }else{
                    
                    NSDictionary *dic=[detailDict valueForKey:@"result"];
                    if(!!dic&&dic.count>0)
                        result=[dic valueForKey:@"reason"];
                    
                    result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                    
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                    [SVProgressHUD setInfoImage:nil];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD showInfoWithStatus:result];
                    
                }
                
                
            }];
            
        }
        
    }
    
    
}


//获取影视详情内容
-(void)getFilmDetailInfo_Movies
{

    NSInteger Id = [self.strID intValue];
  
    NSDictionary *params = @{
                             @"id":@(Id)
                             };

    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_MOVIE_GETMOVIEDETAIL_V2 Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                MovieContent = [filmDetailInfo objectForKey:@"movie"];
                
                MovieModel* movieModel;
                for (NSDictionary* dic in MovieContent) {
                    movieModel = [[MovieModel alloc] init];
                    movieModel.strID = [dic objectForKey:@"movieId"];
                    movieModel.filmName = [dic objectForKey:@"movieName"];
                    movieModel.filmImage = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"moviePhoto"]];
                    movieModel.directorName = [dic objectForKey:@"director"];
                    movieModel.starsName = [dic objectForKey:@"starsName"];
                    
                    movieModel.movieTopic = [dic objectForKey:@"movieTopic"];
                    movieModel.movieYear = [dic objectForKey:@"movieYear"];
                    movieModel.praiseCount = [dic objectForKey:@"praiseCount"];// 点赞数
                    movieModel.movieRelated = [dic objectForKey:@"movieRelated"];
                    movieModel.goodsCounts = [dic objectForKey:@"counts"];
                    movieModel.movieNationality = [dic objectForKey:@"movieNationality"];
                    movieModel.systemRelated = [dic objectForKey:@"systemRelated"];
                    
//                    if (movieModel.systemRelated&&![@"" isEqualToString:movieModel.systemRelated]) {
//                        CommentModel* model = [[CommentModel alloc] init];
//                        model.strDescription = movieModel.systemRelated;
//                        self.systemComment = model;
//                    }
//                    
                    [self.arrayFilms addObject:movieModel];
                }
                
                
                [self reloadData];
                
            }else{
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
            }
        }];
    }
}

//获取影视详情内容-主演信息
-(void)getFilmDetailInfo_Star
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(self.arrayStars.count == 0?1:2),
                             @"limit":@(self.arrayStars.count == 0?DEFAULT_ARRAY_NUM:self.arrayStars.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_MOVIE_GETMOVIEDETAIL_STAR Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                filmStarContent = [filmDetailInfo objectForKey:@"star"];

                StarsModel* starModel;
                for (NSDictionary* dic in filmStarContent) {
                    starModel = [[StarsModel alloc] init];
                    
                    starModel.starName = [dic objectForKey:@"starName"];
                    starModel.starImage = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"starPhoto"]];
                    starModel.nation = [dic objectForKey:@"nation"];
                    
                    starModel.starBirth = [NSString stringWithFormat:@"(%@)",[dic objectForKey:@"starYear"]];
                    starModel.strID = [dic objectForKey:@"starId"];
                    
                    starModel.starSex = [dic objectForKey:@"starSex"];
                    starModel.starRelated = [dic objectForKey:@"starRelated"];
                    starModel.movieName = [dic objectForKey:@"movieName"];
                    starModel.counts = [dic objectForKey:@"counts"];
                    
                    [self.arrayStars addObject:starModel];
                }

                
                [self reloadData];
                
            }
            else
            {
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
            }
        }];
    }
}
//获取影视详情内容-剧照信息
-(void)getFilmDetailInfo_Stage
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(stageImage.count == 0?1:2),
                             @"limit":@(stageImage.count == 0?DEFAULT_ARRAY_NUM:stageImage.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_MOVIE_GETMOVIEDETAIL_STAGE_PHOTO Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                stageContent = [filmDetailInfo objectForKey:@"stagePhoto"];
                
                for(int i=0;i<stageContent.count;i++){
                    NSString *path = [stageContent[i] objectForKey:@"movieImagePath"];
                    //NSString *ImagePath = [CMRES_BaseURL stringByAppendingString:path];
                    [stageImage addObject:path];
                    self.commentCount =[stageContent[i] objectForKey:@"relatedCount" ];
                  
                }
                if(stageImage.count == 0)
                {
                    [stageImage addObject:@""];
                }
                [self reloadData];
                
            }else{
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
            }
        }];
    }
}
//获取影视详情内容-商品信息
-(void)getFilmDetailInfo_Goods
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(self.arrayGoods.count == 0?1:2),
                             @"limit":@(self.arrayGoods.count == 0?DEFAULT_ARRAY_NUM:self.arrayGoods.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_MOVIE_GETMOVIEDETAIL_GOOD_DETAIL Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                goodsContent = [filmDetailInfo objectForKey:@"goodPhoto"];
                
                HotGoodsModel* goodModel;
                for (NSDictionary* dic in goodsContent) {
                    goodModel = [[HotGoodsModel alloc] init];
                    goodModel.goodPhotoPath = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"goodsPhoto"]];
                    goodModel.strID = [dic objectForKey:@"goodId"];
                    [self.arrayGoods addObject:goodModel];
                }
                
                [self reloadData];
                
            }else{
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
            }
        }];
    }
}
//获取影视详情内容-评论信息
-(void)getFilmDetailInfo_Comment
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(self.arrayComments.count == 0?1:2),
                             @"limit":@(self.arrayComments.count == 0?DEFAULT_ARRAY_NUM:self.arrayComments.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_MOVIE_GETMOVIEDETAIL_COMMENT_DETAIL Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                commentContent = [filmDetailInfo objectForKey:@"commentYonghu"];
                
               NSArray* systemArray = [filmDetailInfo objectForKey:@"comment"];
                if (systemArray.count > 0) {
                    NSDictionary *systemDic = systemArray[0];
                    //
                    CommentModel *model = [[CommentModel alloc]init];
                    model.strID = [systemDic objectForKey:@"commentId"];
                    model.strDescription = [systemDic objectForKey:@"related"];
                    model.strPraise = [systemDic objectForKey:@"praiseCount"];
                    model.strTsuCount =[systemDic objectForKey:@"tsukkomiCount"];
                    self.systemComment = model;
                }
      
                CommentModel* commentModel;
                for (NSDictionary* dic in commentContent) {
                    commentModel = [[CommentModel alloc] init];
                    commentModel.strID = [dic objectForKey:@"commentId"];
                    if ([[dic objectForKey:@"nickName"] isEqualToString:@""])
                    {commentModel.strName = [dic objectForKey:@"userName"];
                    }else
                    { commentModel.strName = [dic objectForKey:@"nickName"];
                    }
                    commentModel.strDescription = [dic objectForKey:@"related"];
                    commentModel.strPraise = [dic objectForKey:@"praiseCount"];
                    commentModel.strTsuCount = [dic objectForKey:@"tsukkomiCount"];
                    commentModel.userType = [dic objectForKey:@"userType"];
                    commentModel.strPhoto = [dic objectForKey:@"user_image"];
                  
                    [self.arrayComments addObject:commentModel];
                   
                }
                [self reloadData];
                
            }else{
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
            }
        }];
    }
}

//跳转到影星详情界面
-(void)gotoStarDetailView:(NSString*)ID
{
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    filmStarsDetail = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
    filmStarsDetail.strID = ID;
    [self.navigationController pushViewController:filmStarsDetail animated:YES];
}

//跳转到商品详情页面
-(void)gotoGoodsDetailView:(NSString*)ID
{
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    dressDetailView = [View instantiateViewControllerWithIdentifier:@"dressDetail"];
    dressDetailView.strID = ID;
    
    [self.navigationController pushViewController:dressDetailView animated:YES];

}

//跳转到影视详情界面
-(void)gotoFilmDetailView:(NSString *)ID{
    
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    filmDetailView = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
    filmDetailView.strID = ID;
    [self.navigationController pushViewController:filmDetailView animated:YES];
    
}

//避免键盘遮住输入框
-(void)keyboardWillShow:(NSNotification *)notification
{
//    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        NSInteger offset =self.view.frame.size.height-keyboardBounds.origin.y;
        CGRect listFrame = CGRectMake(0, -offset, self.view.frame.size.width,self.view.frame.size.height);
//        NSLog(@"offset is %ld",(long)offset);
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        //处理移动事件，将各视图设置最终要达到的状态
        
        self.view.frame=listFrame;
        self.bgview.frame = CGRectMake(0, offset, [UIScreen mainScreen].bounds.size.width, 64);
        [UIView commitAnimations];
    
    }
}


-(void)keyboardWillHidden:(NSNotification *)notification
{
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
       self.bgview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}


-(void)closeView{
    
    //[SVProgressHUD showInfoWithStatus:@"wwwwww"];
//   [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 14;

}


//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section == 0){
//        
//        return @"";
//    }else if (section == 1){
//    
//        return @"";
//    }else if (section == 2){
//    
//        
//    }
//    
//    return [keys objectAtIndex:section];
//    
//}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section == 0){
        return 1;
    }else if (section == 1){
        
        return 1;
    }else if (section == 2){
    
        return 1;
    }else if (section == 3){
    
        return 1;
    }else if (section == 4){
        
       return 1;
        
    }else if (section == 5){
        
       return 1;
    }else if (section == 6){
    
       return 1;
    }else if (section == 7){
    
        return 1;
    }else if (section == 8||section == 9){
        if (self.systemComment) {
            return 1;
        }
    }else if (section == 10){
        
        return 1;
    }else if (section == 11){

       return self.arrayComments.count;
    }else if (section == 12)
    {
        return 1;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 0;
  
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *cellname = @"cell";
    
    if(indexPath.section == 0){
        FilmImageCell *filmImageCell = (FilmImageCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (filmImageCell == nil){
            filmImageCell = [[FilmImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmImageCell = [[FilmImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        filmImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        filmImageCell.delegate=self;
        filmImageCell.filmImages = self.stageImage;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
      
        cell = filmImageCell;
//          cell.backgroundColor = [UIColor redColor];
    }else if(indexPath.section == 1){
        
        FilmDetailCell *filmDetailCell = (FilmDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (filmDetailCell == nil){
            filmDetailCell = [[FilmDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmDetailCell = [[FilmDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        if (self.arrayFilms.count > 0)
        {
            MovieModel* movieModel = self.arrayFilms[0];
            filmDetailCell.model = movieModel;
        }
       filmDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell = filmDetailCell;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
       cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    }else if(indexPath.section == 2){
    
        FilmIntructionCell *filmIntructionCell = (FilmIntructionCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (filmIntructionCell == nil){
            filmIntructionCell = [[FilmIntructionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmIntructionCell = [[FilmIntructionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        if (self.arrayFilms.count > 0)
        {
            MovieModel* movieModel = self.arrayFilms[0];
            filmIntructionCell.model = movieModel;
        }
        
        //filmIntructionCell.movieImagePath = filmImage;
        filmIntructionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = filmIntructionCell;
        
        
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    }else if(indexPath.section == 3||indexPath.section == 5||indexPath.section == 7){
        
        BlankCell *blankCell = (BlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (blankCell == nil){
            blankCell = [[BlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            blankCell = [[BlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = blankCell;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        
    }
    else if(indexPath.section == 4)
    {
        PopularGoodsCell *goodsCell = (PopularGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (goodsCell == nil){
            goodsCell = [[PopularGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            goodsCell = [[PopularGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        if (self.arrayFilms.count > 0)
        {
            MovieModel* movieModel = self.arrayFilms[0];
            goodsCell.count = movieModel.goodsCounts;
        }
        else
        {
            goodsCell.count = @"0";
        }
        
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        goodsCell.arrayModel = self.arrayGoods;
        
        goodsCell.page = goodsP;
        goodsCell.delegate = self;
        cell = goodsCell;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    else if(indexPath.section == 6)
    {
        JoinStarsCell *joinStarsCell = (JoinStarsCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (joinStarsCell == nil){
            joinStarsCell = [[JoinStarsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            joinStarsCell = [[JoinStarsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        joinStarsCell.delegate = self;
        joinStarsCell.arrayModel = self.arrayStars;
        joinStarsCell.page = goodsP;
        joinStarsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = joinStarsCell;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    else if(indexPath.section == 8)
    {
    
        FourBlankCell *fourblankViewCell = (FourBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (fourblankViewCell == nil){
            fourblankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            fourblankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        fourblankViewCell.type = CommentCellTypeAdmin;
        fourblankViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor blueColor];
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell = fourblankViewCell;
    }
    else if(indexPath.section == 9)
    {
        CommentModel* commentModel = self.systemComment;
        
        FilmCommentCell *filmCommentCell = (FilmCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        
        if (filmCommentCell == nil){
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        filmCommentCell.delegate = self;
        [filmCommentCell setModel:commentModel];
        filmCommentCell.type = CommentCellTypeAdmin;
      
        filmCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        filmCommentCell.username.text = commentModel.strName;
        filmCommentCell.commentLab.text = commentModel.strDescription;
        filmCommentCell.badCount.text = commentModel.strTsuCount;
        filmCommentCell.agreeCount.text= commentModel.strPraise;
        NSString *commentId = commentModel.strID;
        if ([DataBaseTool isCollectAgree:commentId :@"3"]) {
            filmCommentCell.agreeBtn.selected = YES;
        }else
        {
            filmCommentCell.agreeBtn.selected = NO;
        }
        
        if ([DataBaseTool isCollectStep:commentId]) {
            filmCommentCell.badBtn.selected = YES;
        }else
        {
            filmCommentCell.badBtn.selected = NO;
        }
        filmCommentCell.commentId = commentId;
        
        cell = filmCommentCell;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleDefault;
//        
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//        cell.backgroundColor = [UIColor redColor];
        
    }
    else if(indexPath.section == 10){
        
        FourBlankCell *fourblankViewCell = (FourBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (fourblankViewCell == nil){
            fourblankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            fourblankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        fourblankViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor blueColor];
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        
        fourblankViewCell.type = CommentCellTypeOthers;
        
        cell = fourblankViewCell;
    }
    else if(indexPath.section == 11)
    {
      
        CommentModel* commentModel = self.arrayComments[indexPath.row];
    
        FilmCommentCell *filmCommentCell = (FilmCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        
        if (filmCommentCell == nil){
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        filmCommentCell.delegate = self;
        [filmCommentCell setModel:commentModel];
        filmCommentCell.type = CommentCellTypeOthers;
        filmCommentCell.commentLab.text = commentModel.strDescription;
        filmCommentCell.username.text = commentModel.strName;
        filmCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *commentId = commentModel.strID;
        if ([DataBaseTool isCollectAgree:commentId :@"3"]) {
            filmCommentCell.agreeBtn.selected = YES;
        }else
        {
            filmCommentCell.agreeBtn.selected = NO;
        }
        
        if ([DataBaseTool isCollectStep:commentId]) {
            filmCommentCell.badBtn.selected = YES;
        }else
        {
            filmCommentCell.badBtn.selected = NO;
        }
        filmCommentCell.commentId = commentId;
        if (indexPath.row == self.arrayComments.count - 1) {
            filmCommentCell.line.hidden = YES;
        }else
        {  filmCommentCell.line.hidden = NO;
        }

        cell = filmCommentCell;
        self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    }
    else if(indexPath.section == 12)
    {
        FiveBlankCell *fiveBlankCell = (FiveBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (fiveBlankCell == nil){
            fiveBlankCell = [[FiveBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            fiveBlankCell = [[FiveBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }

        cell = fiveBlankCell;
    }
    else
    {
        commentTextCell *textBlankCell = (commentTextCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (textBlankCell == nil){
            
            textBlankCell = [[commentTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            textBlankCell = [[commentTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        cell = textBlankCell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 270 ;
    }else if (indexPath.section == 1){
        
        return 61 ;
    }else if (indexPath.section == 2){
    
          return 138;
    }else if (indexPath.section == 3){
        
        return 18;
    }else if (indexPath.section == 4){
        
        return 194 ;/***王朋*****/
    }else if (indexPath.section == 5){
        
        return 18;
    }else if (indexPath.section == 6){
   
        return 180;
    }else if (indexPath.section == 7){
    
        return 18;
    
    }else if (indexPath.section == 8){
    
        return 40;
    }else if (indexPath.section == 9){
        CommentModel* commentModel = self.systemComment;
        CGSize constraint = CGSizeMake(fDeviceWidth - (CELL_CONTENT_MARGIN * 2), 2000.0f);
        CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
        CGFloat height = size.height;
     
        return height+49;
    }else if (indexPath.section == 10){
        
        return 27;
    }else if (indexPath.section == 11){
        CommentModel* commentModel = self.arrayComments[indexPath.row];
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 2000.0f);
        CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
        
        CGFloat height = size.height;
        return height+50+ 15;
      
    }
    else if (indexPath.section == 12){
    
        return 1;
    }
    
    return 45;
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.commentView.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 跳转到浏览全部图片界面
-(void)jump2BrowseImageViewController:(ExhibitionType)pExhibitionType
{
//    zxViewController  *mycVC  = [[zxViewController   alloc]init];
//    mycVC.filmImages = self.stageImage;
//    [self.navigationController pushViewController:mycVC animated:YES];
//    
    
    
    
    ImageBrowseController *vc = [[ImageBrowseController alloc] init];
    vc.ImageId = self.strID;
    
    vc.type = pExhibitionType;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
    对评论进行点赞和踩
  
 */



/** 收藏功能*/
- (void)filmCollectClick
{
        if (![[CMData getToken] isEqualToString:@""]) {
            
            NSDictionary *tem = (NSDictionary *)[MovieContent firstObject];
            
            FilmDetailModel *model = [FilmDetailModel objectWithKeyValues:tem];
    
            if (self.collectionBtn.isSelected) {
                [DataBaseTool removeCollectFilm:model];
           
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
            }else
            {
                model.commentCount = self.commentCount;
                [DataBaseTool addCollectFilm:model];
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            }
            
            self.collectionBtn.selected = !self.collectionBtn.isSelected;
            return;
        }
    
    [self noLogin];
}

/** 点赞功能*/
- (void)agreeBtnClick
{
    if (![[CMData getToken] isEqualToString:@""]) {
        if(![CMTool isConnectionAvailable]){
            [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        NSString *url = @"";
     
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = [CMData getToken];
        params[@"movieGoodId"] = self.strID;
        params[@"IdType"] = @(1);

        if (self.agreeBtn.isSelected) {
            url = API_COMMENT_CANCERPRAISEORTRAMPLE;
        }else
        {
            url = API_COMMENT_ADDPRAISEORTRAMPLE;
            params[@"type"] = @(1);
        }
  
        [CMAPI postUrl:url Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                if (self.agreeBtn.isSelected) {
                    [DataBaseTool removeCollectAgree:self.strID :@"1"];
                    [SVProgressHUD showSuccessWithStatus:@"取消点赞成功"];
                }else
                {
                [DataBaseTool addCollectAgree:self.strID :@"1"];
                [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
                }
                self.agreeBtn.selected = !self.agreeBtn.isSelected;
                
            }else{
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
                
                
            }
        }];
        
    }
    }else
    {
        [self noLogin];
    }
}

@end
