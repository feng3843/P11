//
//  FilmStarsDetailViewController.m
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FilmStarsDetailViewController.h"
#import "PYAllCommon.h"
#import "BrowseImageViewController.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "FilmDetailViewController.h"
#import "DressDetailViewController.h"

#import "StarDetailModel.h"
#import "DataBaseTool.h"
#import "CMData.h"

#import "ContactsNavViewController.h"
#import "SDImageView+SDWebCache.h"
#import "UIImage+RTTint.h"
#import "ImageBrowseController.h"

#import "MovieModel.h"
#import "StarsModel.h"
#import "HotGoodsModel.h"
#import "CommentModel.h"

@interface FilmStarsDetailViewController ()
{

     FilmDetailViewController *filmDetailView;
     DressDetailViewController *dressDetailView;
    
    int startP;
    int stageP;
    int goodsP;
}
@property (weak, nonatomic) UIView *bgview;


@property (nonatomic,retain) NSMutableArray *arrayFilms;
@property (nonatomic,retain) NSMutableArray *arrayStars;
@property (nonatomic,retain) NSMutableArray *arrayGoods;
@property (nonatomic,retain) NSMutableArray *arrayComments;

@end

@implementation FilmStarsDetailViewController
@synthesize backBtn,FilmStarsTable,collectionBtn,shareBtn,starDetailInfo,StarContent,productContent,filmName,filmImage,filmTime,filmId,goodContent,goodImage,headImage,stagePhotoImageContent,starInstruction,goodIds;

- (void)viewDidLoad {
    [super viewDidLoad];
    /**夏雪**/
    self.navigationController.navigationBarHidden = NO;
    
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    self.FilmStarsTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 64)];
    
    bgview.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    bgview.alpha = 0;
    self.bgview = bgview;
    [self.view addSubview:bgview];
    self.FilmStarsTable.contentOffset = CGPointMake(0,64);
    /**夏雪**/
    
    
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoGoodsDetailView:) name:@"good" object:nil];
    
//    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 30, 30, 30)];
//    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
//    [self.view addSubview:backBtn];
//    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
//    
//    collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, 30, 43*0.5, 42*0.5)];
//    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect"] forState:UIControlStateNormal];
//    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateSelected];
//    [collectionBtn addTarget:self action:@selector(startCollectClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:collectionBtn];
//    StarDetailModel *model = [[StarDetailModel alloc]init];
//    model.strID = self.strID;
//    if ([DataBaseTool isCollectedStart:model]) {
//        self.collectionBtn.selected = YES;
//    }
//    
//    
//    shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, 30, 30, 30)];
//    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
//    [self.view addSubview:shareBtn];
    
    /**夏雪**/
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16*h/568, 30*h/568, 23*h/568, 23*h/568)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    //    [self.view addSubview:backBtn];
    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //
//   UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(185*h/568, 20*h/568, 23*h/568, 23*h/568)];
//    self.agreeBtn = agreeBtn;
//    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"bt_good"] forState:UIControlStateNormal];
//     [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"bt_good_2"] forState:UIControlStateSelected];
////    if([DataBaseTool isCollectAgree:self.strID :@"2"])
////    {
////        self.agreeBtn.selected = YES;
////    }
////    [self.agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *agreeItem = [[UIBarButtonItem alloc]initWithCustomView:self.agreeBtn];
    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(227*h/568, 20*h/568, 23 *h/568, 23*h/568)];
    self.collectionBtn = collectBtn;
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect"] forState:UIControlStateNormal];
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect_2"] forState:UIControlStateSelected];
    
    [self.collectionBtn addTarget:self action:@selector(startCollectClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:collectionBtn];
    StarDetailModel *model = [[StarDetailModel alloc]init];
    model.starId = self.strID;
    if ([DataBaseTool isCollectedStart:model]) {
        self.collectionBtn.selected = YES;
    }
    UIBarButtonItem *collectionItem = [[UIBarButtonItem alloc]initWithCustomView:self.collectionBtn];
    
    shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(270*h/568, 20*h/568, 23*h/568, 23*h/568)];
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:self.shareBtn];
    
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(270*h/568, 20*h/568, 2*1.5*h/568, 23*h/568);
    UIBarButtonItem *divideView = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItems = @[shareItem,divideView,collectionItem];
    
    /**夏雪**/
    

    
    self.FilmStarsTable.showsVerticalScrollIndicator = NO;
    self.FilmStarsTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    starDetailInfo = [[NSDictionary alloc] init];
    StarContent = [[NSMutableArray alloc] init];
    productContent = [[NSMutableArray alloc] init];
    goodContent = [[NSMutableArray alloc] init];
    stagePhotoImageContent = [[NSMutableArray alloc]init];
   
    filmId = [[NSMutableArray alloc] init];
    filmImage = [[NSMutableArray alloc] init];
    filmName = [[NSMutableArray alloc] init];
    filmTime = [[NSMutableArray alloc] init];
    goodIds = [[NSMutableArray alloc] init];
    goodImage = [[NSMutableArray alloc] init];
    headImage = [[NSMutableArray alloc] init];
    
    self.arrayFilms = [[NSMutableArray alloc]init];
    self.arrayStars = [[NSMutableArray alloc]init];
    self.arrayGoods = [[NSMutableArray alloc]init];
    self.arrayComments = [[NSMutableArray alloc]init];
    
    startP = 1;
    stageP = 1;
    goodsP = 1;
    
    [self reloadData];
    
    [self getStarDetail];
    
    // Do any additional setup after loading the view.
    
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    UIImage *image = [UIImage imageNamed:@"bg.png"];
    //
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]
     ];
    self.navigationController.navigationBar.translucent = YES;
    self.FilmStarsTable.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.FilmStarsTable.delegate = nil;
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
//    [self.FilmStarsTable addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.FilmStarsTable.headerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_DOWN_TO_REFRESH, @"");
    self.FilmStarsTable.headerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_REFRESH, @"");
    self.FilmStarsTable.headerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING, @"");
    
    self.FilmStarsTable.footerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_UP_TO_LOAD_MORE, @"");
    self.FilmStarsTable.footerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_LOAD_MORE, @"");
    self.FilmStarsTable.footerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING_MORE, @"");
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        [self getFilmDetailInfo_Comment];
    });
}

-(void)reloadData
{
    [self.FilmStarsTable reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.FilmStarsTable headerEndRefreshing];
    [self.FilmStarsTable footerEndRefreshing];
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
            [self getStarDetailInfo_Goods];
            break;
        case PYHTableCellMovie:
            [self getStarDetailInfo_Stage];
            break;
        case PYHTableCellStar:
            [self getStarDetailInfo_Star];
            break;
        default:
            break;
    }
}

-(void)getStarDetail
{
    [self getStarDetailInfo_Star];
    [self getStarDetailInfo_Movie];
    [self getStarDetailInfo_Stage];
    [self getStarDetailInfo_Goods];
}

//获取明星详情内容-参演电影
-(void)getStarDetailInfo_Star
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_STAR_GETSTARDETAIL_V2 Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                starDetailInfo = [detailDict objectForKey:@"result"];
                
                StarContent = [starDetailInfo objectForKey:@"movie"];
                
                StarsModel* starModel;
                for (NSDictionary* dic in StarContent) {
                    starModel = [[StarsModel alloc] init];
                    
                    starModel.starName = [dic objectForKey:@"starName"];
                    starModel.starImage = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"starPhoto"]];
                    starModel.nation = [dic objectForKey:@"starNationality"];
                    
                    starModel.starBirth = [NSString stringWithFormat:@"(%@)",[dic objectForKey:@"starBirthday"]];
                    starModel.strID = [dic objectForKey:@"starId"];
                    
                    starModel.starSex = [dic objectForKey:@"starSex"];
                    starModel.starRelated = [dic objectForKey:@"starRelated"];
                    starModel.movieName = [dic objectForKey:@"movieName"];
                    starModel.counts = [dic objectForKey:@"counts"];
                    
                    [self.arrayStars addObject:starModel];
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
//获取明星详情内容
-(void)getStarDetailInfo_Movie
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(self.arrayFilms.count == 0?1:2),
                             @"limit":@(self.arrayFilms.count == 0?DEFAULT_ARRAY_NUM:self.arrayFilms.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_STAR_GETSTARDETAIL_MOVIE Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                starDetailInfo = [detailDict objectForKey:@"result"];
                
                productContent = [starDetailInfo objectForKey:@"movies"];
                
                MovieModel* movieModel;
                for (NSDictionary* dic in productContent) {
                    movieModel = [[MovieModel alloc] init];
                    movieModel.strID = [dic objectForKey:@"movieId"];
                    movieModel.filmName = [dic objectForKey:@"movieName"];
                    movieModel.filmImage = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"movieImagePath"]];
                    movieModel.directorName = [dic objectForKey:@"director"];
                    movieModel.starsName = [dic objectForKey:@"starsName"];
                    
                    movieModel.movieTopic = [dic objectForKey:@"movieTopic"];
                    movieModel.movieYear = [dic objectForKey:@"movieYear"];
                    movieModel.praiseCount = [dic objectForKey:@"praiseCount"];// 点赞数
                    movieModel.movieRelated = [dic objectForKey:@"movieRelated"];
                    movieModel.goodsCounts = [dic objectForKey:@"counts"];
                    movieModel.movieNationality = [dic objectForKey:@"movieNationality"];
                    movieModel.systemRelated = [dic objectForKey:@"systemRelated"];
                    
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
//获取明星详情内容-剧照信息
-(void)getStarDetailInfo_Stage
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(headImage.count == 0?1:2),
                             @"limit":@(headImage.count == 0?DEFAULT_ARRAY_NUM:self.headImage.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_STAR_GETSTARDETAIL_STAGE_PHOTO Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                starDetailInfo = [detailDict objectForKey:@"result"];
                
                stagePhotoImageContent = [starDetailInfo objectForKey:@"starPhoto"];
                
                for(int i=0;i<stagePhotoImageContent.count;i++)
                {
                    NSString *path = [stagePhotoImageContent[i] objectForKey:@"starImagePath"];
                    //NSString *ImagePath = [CMRES_BaseURL stringByAppendingString:path];
                    [headImage addObject:path];
                }
                if(headImage.count == 0)
                {
                    [headImage addObject:@""];
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
//获取明星详情内容-商品信息
-(void)getStarDetailInfo_Goods
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
        
        [CMAPI postUrl:API_STAR_GETSTARDETAIL_GOOD_DETAIL Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                starDetailInfo = [detailDict objectForKey:@"result"];
                
                goodContent = [starDetailInfo objectForKey:@"goodPhoto"];
                
                HotGoodsModel* goodModel;
                for (NSDictionary* dic in goodContent) {
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 7;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        
        return 1;
    }
    else if (section == 1){

        return 1;
    }
    else if (section == 2){

        return 1;
    
    }else if (section == 3){
        
        return 1;
    }
    else if (section == 4){

        return 1;
        
    }
    else if (section == 5){

        return 1;
    }
    return 1;
    
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
         StarsImageCell *starsImageCell = (StarsImageCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (starsImageCell == nil){
             starsImageCell = [[StarsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
             starsImageCell = [[StarsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
             starsImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        starsImageCell.delegate=self;
        starsImageCell.starsImages = headImage;
        cell = starsImageCell;
        
    }else if (indexPath.section == 1){
        StarsDetailCell *starCell = (StarsDetailCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (starCell == nil){
            starCell = [[StarsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            starCell = [[StarsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        if (self.arrayStars.count > 0)
        {
            StarsModel* model = self.arrayStars[0];
            starCell.model = model;
        }
        
        starCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = starCell;
    
    
    }else if (indexPath.section == 2){
        StarsIntructionCell *starIntructionCell = (StarsIntructionCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (starIntructionCell == nil){
            starIntructionCell = [[StarsIntructionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            starIntructionCell = [[StarsIntructionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        starIntructionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.arrayStars.count > 0)
        {
            StarsModel* model = self.arrayStars[0];
            starIntructionCell.model = model;
        }
        
        cell = starIntructionCell;
     
    }
    else if (indexPath.section == 5||indexPath.section == 3){
        BlankCell *twoCell = (BlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (twoCell == nil){
            twoCell = [[BlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            twoCell = [[BlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = twoCell;
        
        
        
    }
    else if (indexPath.section == 4){
        PopularGoodsCell *goodsCell = (PopularGoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (goodsCell == nil){
            goodsCell = [[PopularGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            goodsCell = [[PopularGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        if (self.arrayStars.count > 0)
        {
            StarsModel* model = self.arrayStars[0];
            goodsCell.count = model.counts;
        }
        goodsCell.delegate=self;
        goodsCell.arrayModel = self.arrayGoods;
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = goodsCell;
       
    }else if (indexPath.section == 6){
        JoinFilmCell *joinCell = (JoinFilmCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (joinCell == nil){
            joinCell = [[JoinFilmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            joinCell = [[JoinFilmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        joinCell.delegate=self;
        joinCell.arrayModel = self.arrayFilms;
        joinCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = joinCell;
    
    }

    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell;
    //     static NSString *cellname = @"cell";
    //     FilmCommentCell *filmCommentCell = (FilmCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    //
    //    int n = [filmCommentCell.commentArray count];
    if (indexPath.section==0) {
        
        return 270;
    }
    else if (indexPath.section == 1){

        return 61;
    }
    else if (indexPath.section == 2){

        return 138;
    }
    else if (indexPath.section == 3){

        return 18;
    }
    else if (indexPath.section == 4){
        return 194;
    }
    else if (indexPath.section == 5){

        return 18;
    }
    return 180;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//滑动事件处理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    /**夏雪**/
    CGFloat offset=scrollView.contentOffset.y ;
    
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
//        
//        UIImage *agreeImage = [UIImage imageNamed:@"bt_good"];
//        UIImage *agreeImageNew =  [agreeImage rt_darkenWithLevel:alpha*0.5];
//        [self.agreeBtn setBackgroundImage:agreeImageNew forState:UIControlStateNormal];
        
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

- (void)startCollectClick
{
    
    if (![[CMData getToken] isEqualToString:@""]) {
        
        NSDictionary *tem = (NSDictionary *)[StarContent firstObject];
        
        StarDetailModel *starModel = [[StarDetailModel alloc]init];
        starModel.starName = [tem objectForKey:@"starName"];
        starModel.starPhotoPath = [tem objectForKey:@"starPhoto"];
        starModel.starNationality = [tem objectForKey:@"starNationality"];
        
        starModel.starYear = [NSString stringWithFormat:@"(%@)",[tem objectForKey:@"starBirthday"]];
        starModel.starId = [tem objectForKey:@"starId"];
        
        starModel.starSex = [tem objectForKey:@"starSex"];
        starModel.starRelated = [tem objectForKey:@"starRelated"];
        starModel.movies = [tem objectForKey:@"movieName"];
        

        
        if (self.collectionBtn.isSelected) {
            [DataBaseTool removeCollectStart:starModel];
            //        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            //        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
            //        [SVProgressHUD setInfoImage:nil];
            //        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
        }else
        {
            
            [DataBaseTool addCollectStart:starModel];
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }
        
        self.collectionBtn.selected = !self.collectionBtn.isSelected;
        return;
    }
    
    [self noLogin];
}

@end
