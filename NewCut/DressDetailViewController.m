//
//  DressDetailViewController.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DressDetailViewController.h"
#import "PYAllCommon.h"
#import "BrowseImageViewController.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "GoodDetailModel.h"
#import "DataBaseTool.h"
#import "ContactsNavViewController.h"
#import "CMData.h"

#import "SDImageView+SDWebCache.h"
#import "UIViewController+Puyun.h"
#import "UIImage+RTTint.h"
#import "ImageBrowseController.h"
#import "CommentModel.h"
#import "FilmCommentCell.h"
#import "HotGoodsModel.h"
#import "UIImage+Extensions.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface DressDetailViewController ()<GoodsCommentCellDelegate>
@property (weak, nonatomic) UIView *bgview;

//@property(nonatomic ,weak)UIButton *agreeBtn;
//
//@property (nonatomic,retain) NSMutableArray *arrayComments;
@property(nonatomic ,strong)GoodDetailModel *good;

@property(nonatomic ,weak)UIView *commentView;

@property(nonatomic ,weak)DressInstructionCell *dressInstructionCell;
@end

@implementation DressDetailViewController
@synthesize backBtn,collectionBtn,shareBtn,DressDetailTable,comment,send,filmDetailInfo,goodContent,goodPhotoContent,commentContent,goodPhotoImageArray,goodCommentContentList;



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    UIImage *image = [UIImage imageNamed:@"bg.png"];
    //
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image
     ];
    [super viewWillAppear:animated];

     self.navigationController.navigationBar.translucent = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    /**夏雪**/
    self.title = @"";
    //
    UIImage *image = [UIImage imageNamed:@"bg.png"];
    //
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image
     ];
    self.navigationController.navigationBarHidden = NO;
    
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    self.DressDetailTable.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 64)];
    
    bgview.backgroundColor = [UIColor whiteColor];
//    bgview.alpha = 0;
    self.bgview = bgview;
    [self.view addSubview:bgview];
    self.DressDetailTable.contentOffset = CGPointMake(0,64);
    
    /**夏雪**/

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [self setUpForDismissKeyboard];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];

    self.DressDetailTable.delegate = self;
    self.DressDetailTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.DressDetailTable.showsVerticalScrollIndicator = NO;
    
    /**夏雪**/
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16*h/568, 30*h/568, 23*h/568, 23*h/568)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    //    [self.view addSubview:backBtn];
    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(185*h/568, 20*h/568, 23*h/568, 23*h/568)];
    self.agreeBtn = agreeBtn;
    [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"bt_good"] forState:UIControlStateNormal];
     [self.agreeBtn setBackgroundImage:[UIImage imageNamed:@"bt_good_2"] forState:UIControlStateSelected];
    if([DataBaseTool isCollectAgree:self.strID :@"2"])
    {
        self.agreeBtn.selected = YES;
    }
    [self.agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *agreeItem = [[UIBarButtonItem alloc]initWithCustomView:self.agreeBtn];

    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(227*h/568, 20*h/568, 23 *h/568, 23*h/568)];
    self.collectionBtn = collectBtn;
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect"] forState:UIControlStateNormal];
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bt_collect_2"] forState:UIControlStateSelected];
    
    [self.collectionBtn addTarget:self action:@selector(goodCollectClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:collectionBtn];
    GoodDetailModel *model = [[GoodDetailModel alloc]init];
    model.goodId = self.strID;
    if ([DataBaseTool isCollectedGood:model]) {
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
    
    self.navigationItem.rightBarButtonItems = @[shareItem,divideView,collectionItem,divideView,agreeItem];
    
    /**夏雪**/
    
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, 525*h/568, fDeviceWidth, 45*h/568)];
//    commentView.backgroundColor = [UIColor redColor];
    commentView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.view addSubview:commentView];
    UIView *commentLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 0.5)];
    commentLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [commentView addSubview:commentLine];
    self.commentView = commentView;
    self.comment = [[UITextField alloc]initWithFrame:CGRectMake(11*h/568,6.5*h/568, 238*h/568, 32*h/568)];
    comment.borderStyle = UITextBorderStyleNone;
    comment.placeholder = @"写评论......";
    comment.background = [UIImage resizedImage:@"text.png"];
    comment.layer.cornerRadius = 0;
    comment.keyboardType = UIKeyboardTypeDefault;
    [commentView addSubview:comment];
//
//    
    self.send = [[UIButton alloc]initWithFrame:CGRectMake(257*h/568, 6.5*h/568, 55*h/568, 32*h/568)];
    send.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    UILabel *btnTitle  = [[UILabel alloc] initWithFrame:CGRectMake(14*h/568, 9*h/568, 30*h/568, 15*h/568)];
    btnTitle.textColor = [UIColor colorWithHexString:@"999999"];
    btnTitle.text = @"发送";
    btnTitle.font = [UIFont systemFontOfSize:14*h/568];
    [send addSubview:btnTitle];
    [send addTarget:self action:@selector(addCommentForGood) forControlEvents:UIControlEventTouchUpInside];
    //send.layer.cornerRadius = 0.5;
    send.layer.borderWidth = 0.5;
    send.layer.borderColor = [UIColor colorWithHexString:@"bababa"].CGColor;
    [commentView addSubview:send];
    [send setBackgroundImage:[UIImage resizedImage:@"send.png"] forState:UIControlStateNormal];
    self.filmDetailInfo = [[NSDictionary alloc] init];
    self.goodPhotoContent = [[NSMutableArray alloc] init];
    self.goodContent = [[NSMutableArray alloc] init];
    self.commentContent = [[NSMutableArray alloc] init];
    self.goodPhotoImageArray = [[NSMutableArray alloc] init];
    self.goodCommentContentList = [[NSMutableArray alloc] init];
    
    
    self.arrayComments = [[NSMutableArray alloc]init];
    
    [self reloadData];
    [self getGoodsDetail];
    
    // Do any additional setup after loading the view.
    
    [self setupRefresh];
   
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.DressDetailTable addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
//    [self.DressDetailTable headerBeginRefreshing];
//
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.DressDetailTable addFooterWithTarget:self action:@selector(footerRereshing)];
//
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.DressDetailTable.headerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_DOWN_TO_REFRESH, @"");
//    self.DressDetailTable.headerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_REFRESH, @"");
//    self.DressDetailTable.headerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING, @"");
    
    self.DressDetailTable.footerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_UP_TO_LOAD_MORE, @"");
    self.DressDetailTable.footerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_LOAD_MORE, @"");
    self.DressDetailTable.footerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING_MORE, @"");
}
- (void)dealloc
{
    [self.DressDetailTable removeFooter];
}

#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    
//    
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
        // 刷新表格
        commnentP++;
        [self getGoodsDetailInfo_Comment];
    });
}

-(void)reloadData
{
    [self.DressDetailTable reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.DressDetailTable footerEndRefreshing];

    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];
}

-(void)share:(id)sender
{
    [self shareImage:sender];
}

//对商品进行评论
-(void)addCommentForGood
{
    
    NSString *commentType = @"2";
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
                    [self.DressDetailTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:7] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                    
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

//点击界面任何部分，隐藏键盘
- (void)setUpForDismissKeyboard
{
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

-(void)keyboardWillShow:(NSNotification *)notification
{
    
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

-(void)getGoodsDetail
{
    [self getGoodsDetailInfo];
    [self getGoodsDetailInfo_Photo];
    [self getGoodsDetailInfo_Comment];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.comment.isFirstResponder)
    {
        [self.comment resignFirstResponder];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (!self.DressDetailTable.isFooterRefreshing) {
        [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.5];
        //    self.comment.hidden = YES;
        //    self.send.hidden = YES;
        self.commentView.hidden = YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"big" object:nil];
    
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:image];
    /**夏雪**/
    CGFloat offset=scrollView.contentOffset.y;
    
    if(offset <=0)
    {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    if (offset < (208 )){
        CGFloat alpha= 1 - (208 - offset)/208.0;
        self.bgview.alpha = alpha * 0.95;
          
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
    
    
    /**夏雪**/
    
//    CGPoint point = scrollView.contentOffset;

    
}

-(void)loadOldData:(NSInteger)page Type:(PYHTableCellType)type
{
    switch (type) {
        case PYHTableCellGoods:
            [self getGoodsDetailInfo];
            break;
        case PYHTableCellMovie:
            break;
        case PYHTableCellStar:
            break;
        default:
            break;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    self.comment.hidden = NO;
//    self.send.hidden = NO;
    self.commentView.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}



-(void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
}

////获取商品详情内容
//-(void)getGoodsDetailInfo
//{
//    
//    NSInteger Id = [self.strID intValue];
//    
//    NSDictionary *params = @{
//                             @"id":@(Id)
//                             };
//    
//    
//    if(![CMTool isConnectionAvailable]){
//        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
//    }else{
//        
//        [CMAPI postUrl:API_MOVIE_GETMOVIEDETAIL_V2 Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//            
//            id result = [detailDict objectForKey:@"code"];
//            if(succeed){
//                
//                filmDetailInfo = [detailDict objectForKey:@"result"];
//                
//                MovieContent = [filmDetailInfo objectForKey:@"movie"];
//                
//                MovieModel* movieModel;
//                for (NSDictionary* dic in MovieContent) {
//                    movieModel = [[MovieModel alloc] init];
//                    movieModel.filmID = [dic objectForKey:@"movieId"];
//                    movieModel.filmName = [dic objectForKey:@"movieName"];
//                    movieModel.filmImage = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"moviePhoto"]];
//                    movieModel.directorName = [dic objectForKey:@"director"];
//                    movieModel.starsName = [dic objectForKey:@"starsName"];
//                    
//                    movieModel.movieTopic = [dic objectForKey:@"movieTopic"];
//                    movieModel.movieYear = [dic objectForKey:@"movieYear"];
//                    movieModel.praiseCount = [dic objectForKey:@"praiseCount"];// 点赞数
//                    movieModel.movieRelated = [dic objectForKey:@"movieRelated"];
//                    movieModel.goodsCounts = [dic objectForKey:@"counts"];
//                    movieModel.movieNationality = [dic objectForKey:@"movieNationality"];
//                    movieModel.systemRelated = [dic objectForKey:@"systemRelated"];
//                    
//                    if (movieModel.systemRelated&&![@"" isEqualToString:movieModel.systemRelated]) {
//                        CommentModel* model = [[CommentModel alloc] init];
//                        model.strDescription = movieModel.systemRelated;
//                        self.systemComment = model;
//                    }
//                    
//                    [self.arrayFilms addObject:movieModel];
//                }
//                
//                
//                [self reloadData];
//                
//            }else{
//                
//                NSDictionary *dic=[detailDict valueForKey:@"result"];
//                if(!!dic&&dic.count>0)
//                    result=[dic valueForKey:@"reason"];
//                
//                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                [SVProgressHUD setInfoImage:nil];
//                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                [SVProgressHUD showInfoWithStatus:result];
//            }
//        }];
//    }
//}

////获取商品详情内容-主演信息
//-(void)getGoodsDetailInfo_Star
//{
//    
//    NSInteger Id = [self.strID intValue];
//    
//    NSDictionary *params = @{
//                             @"id":@(Id),
//                             @"p":@(startP),
//                             @"limit":@(DEFAULT_ARRAY_NUM)
//                             };
//    
//    
//    if(![CMTool isConnectionAvailable]){
//        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
//    }else{
//        
//        [CMAPI postUrl:API_GOODS_GETGOODSDETAIL_STAR Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//            
//            id result = [detailDict objectForKey:@"code"];
//            if(succeed){
//                
//                filmDetailInfo = [detailDict objectForKey:@"result"];
//                
//                filmStarContent = [filmDetailInfo objectForKey:@"star"];
//                
//                StarsModel* starModel;
//                for (NSDictionary* dic in filmStarContent) {
//                    starModel = [[StarsModel alloc] init];
//                    
//                    starModel.starName = [dic objectForKey:@"starName"];
//                    starModel.starImage = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"starPhoto"]];
//                    starModel.nation = [dic objectForKey:@"nation"];
//                    
//                    starModel.starBirth = [NSString stringWithFormat:@"(%@)",[dic objectForKey:@"starYear"]];
//                    starModel.starId = [dic objectForKey:@"starId"];
//                    
//                    
//                    starModel.starSex = [dic objectForKey:@"starSex"];
//                    starModel.starRelated = [dic objectForKey:@"starRelated"];
//                    starModel.movieName = [dic objectForKey:@"movieName"];
//                    starModel.counts = [dic objectForKey:@"counts"];
//                    
//                    [self.arrayStars addObject:starModel];
//                }
//                
//                
//                [self reloadData];
//                
//            }
//            else
//            {
//                
//                NSDictionary *dic=[detailDict valueForKey:@"result"];
//                if(!!dic&&dic.count>0)
//                    result=[dic valueForKey:@"reason"];
//                
//                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                [SVProgressHUD setInfoImage:nil];
//                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                [SVProgressHUD showInfoWithStatus:result];
//            }
//        }];
//    }
//}
//获取商品详情内容-剧照信息
//-(void)getGoodsDetailInfo_Stage
//{
//    
//    NSInteger Id = [self.strID intValue];
//    
//    NSDictionary *params = @{
//                             @"id":@(Id),
//                             @"p":@(stageP),
//                             @"limit":@(DEFAULT_ARRAY_NUM)
//                             };
//    
//    
//    if(![CMTool isConnectionAvailable]){
//        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
//    }else{
//        
//        [CMAPI postUrl:API_GOODS_GETGOODSDETAIL_STAGE_PHOTO Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//            
//            id result = [detailDict objectForKey:@"code"];
//            if(succeed){
//                
//                
//                filmDetailInfo = [detailDict objectForKey:@"result"];
//                
//                goodPhotoContent = [filmDetailInfo objectForKey:@"stagePhoto"];
//                
//                for(int i=0;i<goodPhotoContent.count;i++){
//                    NSString *path = [goodPhotoContent[i] objectForKey:@"movieImagePath"];
//                    //NSString *ImagePath = [CMRES_BaseURL stringByAppendingString:path];
//                    [goodPhotoImageArray addObject:path];
//                }
//                if(goodPhotoImageArray.count == 0)
//                {
//                    [goodPhotoImageArray addObject:@""];
//                }
//                [self reloadData];
//                
//            }else{
//                
//                NSDictionary *dic=[detailDict valueForKey:@"result"];
//                if(!!dic&&dic.count>0)
//                    result=[dic valueForKey:@"reason"];
//                
//                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                [SVProgressHUD setInfoImage:nil];
//                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                [SVProgressHUD showInfoWithStatus:result];
//            }
//        }];
//    }
//}
//获取商品详情内容
-(void)getGoodsDetailInfo
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_GOODS_GETGOODSDETAIL_V2 Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                goodContent = [filmDetailInfo objectForKey:@"good"];
                self.good = [GoodDetailModel objectWithKeyValues:goodContent[0]];
                HotGoodsModel* goodModel;
                for (NSDictionary* dic in goodContent) {
                    goodModel = [[HotGoodsModel alloc] init];
                    goodModel.goodPhotoPath = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"goodPhoto"]];
                    goodModel.strID = [dic objectForKey:@"goodId"];
                    goodModel.goodName = [dic objectForKey:@"goodName"];
                    goodModel.commentCount = [dic objectForKey:@"commentCount"];
                    goodModel.goodPraiseCount = [NSString stringWithFormat:@"%@人",[dic objectForKey:@"goodPraiseCount"]];
                    goodModel.goodRelated = [NSString stringWithFormat:@"%@条",[dic objectForKey:@"goodRelated"]];
                    goodModel.webSite = [dic objectForKey:@"webSite"];
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
//获取商品详情内容-商品信息
-(void)getGoodsDetailInfo_Photo
{
    
    NSInteger Id = [self.strID intValue];
    
    NSDictionary *params = @{
                             @"id":@(Id),
                             @"p":@(goodPhotoImageArray.count == 0?1:2),
                             @"limit":@(goodPhotoImageArray.count == 0?DEFAULT_ARRAY_NUM:goodPhotoImageArray.count)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_GOODS_GETGOODSDETAIL_GOODS_PHOTO Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                
                filmDetailInfo = [detailDict objectForKey:@"result"];
                
                goodContent = [filmDetailInfo objectForKey:@"goodPhoto"];
                
                HotGoodsModel* goodModel;
                for (NSDictionary* dic in goodContent) {
                    goodModel = [[HotGoodsModel alloc] init];
                    goodModel.goodPhotoPath = [CMRES_BaseURL stringByAppendingString:[dic objectForKey:@"goodImagePath"]];
                    goodModel.strID = [dic objectForKey:@"goodId"];
                    [goodPhotoImageArray addObject:goodModel.goodPhotoPath];
//                    [self.arrayGoods addObject:goodModel];
                }
                
                if(goodPhotoImageArray.count == 0)
                {
                    [goodPhotoImageArray addObject:@""];
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
//获取商品详情内容-评论信息
-(void)getGoodsDetailInfo_Comment
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
        NSLog(@"%@",params);
        [CMAPI postUrl:API_GOODS_GETGOODSDETAIL_COMMENT_DETAIL Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 8;
    
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
    }
    else if (section == 3){

        return 1;
    }else if (section == 4||section == 5){
        if (self.systemComment) {
            return 1;
        }
    }else if (section == 6){
        
        return 1;
    }else if (section == 7){
        
        return self.arrayComments.count;
    }else if (section == 8){

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
        DressImageCell *dressImageCell = (DressImageCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (dressImageCell == nil){
            
            dressImageCell = [[DressImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            dressImageCell = [[DressImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        dressImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        dressImageCell.delegate=self;
        dressImageCell.DressImages = goodPhotoImageArray;
        cell = dressImageCell;
        
    }else if(indexPath.section == 1){
        DressBlankCell *dressBlankCell = (DressBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (dressBlankCell == nil){
            
            dressBlankCell = [[DressBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            dressBlankCell = [[DressBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        dressBlankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = dressBlankCell;
        
    }else if (indexPath.section == 2){
    
        DressInstructionCell *dressIntructionCell = (DressInstructionCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (dressIntructionCell == nil){
            
            dressIntructionCell = [[DressInstructionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            dressIntructionCell = [[DressInstructionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        if (self.arrayGoods.count > 0) {
            
            dressIntructionCell.model = self.arrayGoods[0];
            
        }
        dressIntructionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dressInstructionCell = dressIntructionCell;
        cell = dressIntructionCell;
    
    }else if (indexPath.section == 3){
        
        DressBottomBlankCell *blankCell = (DressBottomBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (blankCell == nil){
            
            blankCell = [[DressBottomBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            blankCell = [[DressBottomBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        blankCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = blankCell;
        
        
    }else if (indexPath.section == 4){
        
        FourBlankCell *titleBlankViewCell = (FourBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (titleBlankViewCell == nil){
            
            titleBlankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            titleBlankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        titleBlankViewCell.type = CommentCellTypeAdminGood;
        titleBlankViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.backgroundColor = [UIColor blueColor];
        //self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell = titleBlankViewCell;
        
    }else if(indexPath.section == 5){

        CommentModel* commentModel = self.systemComment;
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 2000.0f);
        CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
        
        CGFloat height = size.height;
        
        FilmCommentCell *filmCommentCell = (FilmCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        
        if (filmCommentCell == nil){
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        filmCommentCell.delegate = self;
//        [filmCommentCell.commentLab setFrame:CGRectMake(11, 15, 320, height)];
        filmCommentCell.backgroundColor = [UIColor redColor];
        [filmCommentCell setModel:commentModel];
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
        filmCommentCell.type = CommentCellTypeAdminGood;
        cell = filmCommentCell;
        self.DressDetailTable.separatorStyle = UITableViewCellSelectionStyleDefault;
        
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        
    }else if (indexPath.section == 6){
        
        FourBlankCell *titleBlankViewCell = (FourBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (titleBlankViewCell == nil){
            
            titleBlankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            titleBlankViewCell = [[FourBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        titleBlankViewCell.type = CommentCellTypeOthers;
        titleBlankViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.backgroundColor = [UIColor blueColor];
        //self.FilmDetail.separatorStyle = UITableViewCellSelectionStyleNone;
        cell = titleBlankViewCell;
        
    }else if(indexPath.section == 7){
        
        CommentModel* commentModel = self.arrayComments[indexPath.row];
//        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 2000.0f);
//        CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
//        
//        CGFloat height = size.height;
        
        FilmCommentCell *filmCommentCell = (FilmCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        
        if (filmCommentCell == nil){
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            filmCommentCell = [[FilmCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        filmCommentCell.delegate = self;
//        [filmCommentCell.commentLab setFrame:CGRectMake(11, 15, 320, height)];
        [filmCommentCell setModel:commentModel];
   
        filmCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        filmCommentCell.username.text = commentModel.strName;
        filmCommentCell.commentLab.text = commentModel.strDescription;
        filmCommentCell.badCount.text = commentModel.strTsuCount;
        filmCommentCell.agreeCount.text= commentModel.strPraise;
         filmCommentCell.type = CommentCellTypeOthers;
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
        self.DressDetailTable.separatorStyle = UITableViewCellSelectionStyleDefault;
        
        cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
//        cell.backgroundColor = [UIColor redColor];
    }else if(indexPath.section == 8){
    
        LineBlankCell *lineBlankCell = (LineBlankCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
        if (lineBlankCell == nil){
            
            lineBlankCell = [[LineBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }else{
            
            lineBlankCell = [[LineBlankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
        }
        
        cell = lineBlankCell;
    
    }else{
    
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
    // UITableViewCell *cell;
    //     static NSString *cellname = @"cell";
    //     FilmCommentCell *filmCommentCell = (FilmCommentCell *)[tableView dequeueReusableCellWithIdentifier:cellname];
    //
    //    int n = [filmCommentCell.commentArray count];
    if (indexPath.section==0) {
        
        return 290;
    }else if (indexPath.section==1){
        
       return 18;
    }else if (indexPath.section==2){
    
        return 136;
    }else if (indexPath.section==3){
    
       return 18;
    }else if (indexPath.section==4){
    
        return 40;
    }else if (indexPath.section == 5){
        CommentModel* commentModel = self.systemComment;
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 2000.0f);
        CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
        
        CGFloat height = size.height;
        return height+30 +30;
    }else if (indexPath.section==6){
        
        return 25;
    }else if (indexPath.section == 7){
        CommentModel* commentModel = self.arrayComments[indexPath.row];
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 2000.0f);
        CGSize size = [commentModel.strDescription sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
   

        CGFloat height = size.height;
        return height+30 +30;
    }else if (indexPath.section == 8){
    
        return 1;
    }
    
    return 60;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/** 商品收藏*/
- (void)goodCollectClick
{
    if (![[CMData getToken] isEqualToString:@""]) {
        
        
//        NSDictionary *tem = (NSDictionary *)[goodContent firstObject];
           GoodDetailModel *model =   self.good;
          model.goodCommentCount = commentContent.count;
        if (self.collectionBtn.isSelected) {
            [DataBaseTool removeCollectGood:model];
      
            [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
        }else
        {
            
            [DataBaseTool addCollectGood:model];
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
                params[@"IdType"] = @(2);
                
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
                            [DataBaseTool removeCollectAgree:self.strID :@"2"];
                            [SVProgressHUD showSuccessWithStatus:@"取消点赞成功"];
                            
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCENAGREE" object:nil];
                        }else
                        {
                            [DataBaseTool addCollectAgree:self.strID :@"2"];
                            [SVProgressHUD showSuccessWithStatus:@"点赞成功"];
                              [[NSNotificationCenter defaultCenter] postNotificationName:@"AGREE" object:nil];
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
