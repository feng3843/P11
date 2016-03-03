//
//  HomeViewController.m
//  NewCut
//
//  Created by py on 15-7-7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "HomeViewController.h"
#include "UIColor+Extensions.h"
//#import "HomeCell.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMDefault.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"

@interface HomeViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    NSTimer *timer;
}
@end

@implementation HomeViewController
@synthesize images1,images2,hotFilmTableView,hotFilmList,filmDetail,filmStarsDetail,imgUrlArr,filmImage,hotStarTableView,starImage,nameArr,hotStarList;


- (void)viewWillAppear:(BOOL)animated
{      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"bg.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
   // keys = [[NSArray alloc] initWithObjects:@"最受关注", @"本周上映", nil];
    
    //self.homeCollectionView.delegate = self;
   // self.homeCollectionView.dataSource = self;
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;


    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h *64/568)];
    titleView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(8*h/568, 12*h/568, 85*h/568, 21*h/568)];
    titleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    titleLabel.font = [UIFont boldSystemFontOfSize:h*20/568];
    titleLabel.text = @"热门影视";
    
//    UIView *filmTitle = [[UIView alloc]initWithFrame:CGRectMake(0, 64*h/568, w, h*64/568)];
//    filmTitle.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    //[filmTitle addSubview:titleLabel];
    //[self.view addSubview:filmTitle];
    
    UIImageView *filmBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64*h/568, w, 251*h/568)];
    UIImage *borderImage = [UIImage imageNamed:@"biankuang.png"];
    [filmBorder setImage:borderImage];
    [self.view addSubview:filmBorder];
    
    //0, h *64/568,
    hotFilmTableView = [[UITableView alloc] initWithFrame:CGRectMake(48 , 29.5, h *224/568, w)];
    //hotFilmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , 64, w, 225)];
    hotFilmTableView.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
    hotFilmTableView.dataSource = self;
    hotFilmTableView.delegate = self;
    hotFilmTableView.pagingEnabled = YES;//是否设置分页,滑动一次显示一张图片
    //hotFilmTableView.backgroundColor = [UIColor blueColor];
    hotFilmTableView.showsVerticalScrollIndicator = NO;
    hotFilmTableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:hotFilmTableView];
    
    hotStarTableView = [[UITableView alloc] initWithFrame:CGRectMake(74, 280, h *178/568, w)];
    hotStarTableView.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
    hotStarTableView.dataSource = self;
    hotStarTableView.delegate = self;
    //hotStarTableView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    hotStarTableView.pagingEnabled = YES;//是否设置分页,滑动一次显示一张图片
   // hotStarTableView.backgroundColor = [UIColor blueColor];
    hotStarTableView.showsVerticalScrollIndicator = NO;
    hotStarTableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:hotStarTableView];

    /*
     ***容器，装载
     */
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(filmBorder.frame)-30+64, CGRectGetWidth(self.view.frame), 20)];
    containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:containerView];
    UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame))];
    alphaView.backgroundColor = [UIColor clearColor];
    alphaView.alpha = 0.7;
    [containerView addSubview:alphaView];
    
    //分页控制
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 0, CGRectGetWidth(containerView.frame)-20, 20)];
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//貌似不起作用呢
    _pageControl.currentPage = 0; //初始页码为0
    _pageControl.backgroundColor  = [UIColor clearColor];
    [containerView addSubview:_pageControl];
    
    /*
     ***配置定时器，自动滚动广告栏
     */
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:8.0f];
    
    UIImage *image2 = [UIImage imageNamed:@"title.png"];
    UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(104, 31, image2.size.width * 0.5,image2.size.height  * 0.5)];

    [titleImage setImage:image2];
    [self.view addSubview:titleImage];
    //[self.navigationController.view addSubview:titleImage];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(h *100/568, h *32/568, h *130/568, h *25/568)];
    titleLab.text = @"New Cut";
    titleLab.font = [UIFont systemFontOfSize :h * 25/568];
    titleLab.textColor = [UIColor whiteColor];
    //[titleView addSubview:titleLab];
    
    UILabel *filmViewLab = [[UILabel alloc] initWithFrame:CGRectMake(0, h *64/568, w, 1)];
    filmViewLab.backgroundColor = [UIColor colorWithHexString:@"616161"];
   // [self.view addSubview:filmViewLab];
    
   // self.filmView = [[FilmImageViewController alloc] initWithFrame:CGRectMake(0, w *64/320, w, w *226/320)];
   // [self.view addSubview:filmView];
    
   // self.starView = [[PopularStarsImageViewController alloc] initWithFrame:CGRectMake(0, w *364/320, w, w *160/320)];
    //[self.view addSubview:starView];
    UILabel *starViewLab= [[UILabel alloc] initWithFrame:CGRectMake(0, h *524/568, w, 1)];
    starViewLab.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    //[self.view addSubview:starViewLab];
    
    self.images1 = @[[UIImage imageNamed:@"aa.jpg"],
                        [UIImage imageNamed:@"bb.jpg"],
                        [UIImage imageNamed:@"cc.jpg"],
                        [UIImage imageNamed:@"dd.jpg"],
                        [UIImage imageNamed:@"h.jpg"]];
    
//   // [self.filmView setImages:images1];
//    
    images2 = @[[UIImage imageNamed:@"lou.jpg"],
                        [UIImage imageNamed:@"zhong.jpg"],
                        [UIImage imageNamed:@"yang.jpg"],
                        [UIImage imageNamed:@"yangy.jpg"],
                        [UIImage imageNamed:@"sun.jpg"]];
    
   // [self.starView setImages:images2];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    //NSArray* objects = [NSArray arrayWithObjects:images1, images2,nil];
    
   // dataSources = [[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    
    UILabel *blankLab= [[UILabel alloc] initWithFrame:CGRectMake(0, h *282/568, w,  h *19/568)];
    blankLab.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    //[self.view addSubview:blankLab];
    
    UILabel *blankTopLab= [[UILabel alloc] initWithFrame:CGRectMake(0, h *282/568, w, 1)];
    blankTopLab.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    //[self.view addSubview:blankTopLab];
    
    UILabel *blankBottomLab= [[UILabel alloc] initWithFrame:CGRectMake(0, h *301/568, w, 1)];
    blankBottomLab.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    //[self.view addSubview:blankBottomLab];

    
    UIView *starTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, h*315/568, w, h*35/568)];
    starTitleView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    UILabel *starLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*h/568, 14*h/568, 85*h/568, 21*h/568)];
    starLabel.textColor = [UIColor colorWithHexString:@"000000"];
    starLabel.font = [UIFont fontWithName:@"ArialHebrew-Bold" size:h*16/568];
    starLabel.text = @"热门影星";
    [starTitleView addSubview:starLabel];
    [self.view addSubview:starTitleView];
    
    
    filmInfo = [[NSDictionary alloc] init];
    filmPhoto = [[NSMutableArray alloc] init];
    filmName = [[NSMutableArray alloc] init];
    filmId = [[NSMutableArray alloc] init];
    content = [[NSMutableArray alloc] init];
    filmImage = [[NSMutableArray alloc] init];
    starImage = [[NSMutableArray alloc] init];
    hotFilmList = [[NSMutableArray alloc] init];
    hotStarList = [[NSMutableArray alloc] init];
    starContent = [[NSMutableArray alloc] init];
    starInfo = [[NSDictionary alloc] init];
    starPhoto = [[NSMutableArray alloc] init];
    starName = [[NSMutableArray alloc] init];
    starId = [[NSMutableArray alloc] init];
//    NSString *
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 200)];
//    NSString *url = @"7d8e67bd-7481-464c-917f-b8921580edcc.jpg";
//    
//    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
//    NSURL *imageUrl = [NSURL URLWithString:newUrl];
//    
//    NSError *error = nil;
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imageUrl];
//    
//    NSData *imgData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
//    
//    UIImage *img = nil;
//    if(imgData){
//    
//        img = [UIImage imageWithData:imgData];
//        imageView.image = img;
//    
//    }

    [self.hotStarTableView reloadData];
    [self.hotFilmTableView reloadData];
    [self getFilmPhoto];
    [self getStarPhoto];
//    [self initImageArray];
    
   // [self.view addSubview:imageView];
    //[self getFilmPhoto];
    
   // [self setUpCollection];
//    [self.popularFilmView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
//    [self.popularFilmView setBackgroundColor:[UIColor clearColor]];
//    [self.popularFilmView reloadData];
//    [self.view addSubview:self.popularFilmView];
    
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)delayMethod
{
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [self openTimer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void)timerAction:(NSTimer *)timer
{
    UIScrollView* scrollView = (UIScrollView*)self.hotFilmTableView;
    CGRect frame = scrollView.frame;
    int width = CGRectGetWidth(frame);
    CGPoint newOffset = scrollView.contentOffset;
    newOffset.y = newOffset.y + width;
    //    NSLog(@"newOffset.x = %f",newOffset.x);
    if (newOffset.y > (width * (_totalNum-1))) {
        newOffset.y = 0 ;
    }
    int index = newOffset.y / width;   //当前是第几个视图
    newOffset.y = index * width;
    [scrollView setContentOffset:newOffset animated:YES];
}



- (void)openTimer{
    [timer setFireDate:[NSDate distantPast]];//开启定时器
}

- (void)closeTimer{
    [timer setFireDate:[NSDate distantFuture]];//关闭定时器
}

//
-(void)getFilmPhoto{

    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{

        [CMAPI postUrl:API_MOVIE_GETMOVIENAME Param:nil Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {

             id result = [detailDict objectForKey:@"code"];
            if(succeed){

                filmInfo = [detailDict objectForKey:@"result"];
                content = [filmInfo objectForKey:@"movie"];

                for(int i=0; i<content.count; i++){

                    NSString *Id = [content[i] objectForKey:@"movieId"];
                    NSString *Name = [content[i] objectForKey:@"movieName"];
                    NSString *Path = [content[i] objectForKey:@"moviePhoto"];
                    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:Path];
                    
                    [filmId addObject:Id];
                    [filmName addObject:Name];
                    [filmPhoto addObject:newUrl];
                }

               [self.hotFilmList insertObjects:content atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, content.count)]];
               
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

-(void)getStarPhoto{

    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{

        [CMAPI postUrl:API_STAR_GETSTARNAME Param:nil Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {

            id result = [detailDict objectForKey:@"code"];
            if(succeed){

                starInfo = [detailDict objectForKey:@"result"];
                starContent = [starInfo objectForKey:@"star"];
                for(int i=0; i<starContent.count; i++){

                    NSString *Id = [starContent[i] objectForKey:@"starId"];
                    NSString *Name = [starContent[i] objectForKey:@"starName"];
                    NSString *Path = [starContent[i] objectForKey:@"starPhoto"];

                    [starId addObject:Id];
                    [starName addObject:Name];
                    [starPhoto addObject:Path];

                }
                
                [self.hotStarList insertObjects:starContent atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, starContent.count)]];
                [self.hotStarTableView reloadData];


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

//
//- (void) initImageArray {
//    
//    if (imgUrlArr==nil) {
//
//        imgUrlArr = [NSArray arrayWithObjects:@"http://chongyin2.puyuntech.com:7074/res/assets/img/topic/7d8e67bd-7481-464c-917f-b8921580edcc.jpg",
//                     @"http://chongyin2.puyuntech.com:7074/res/assets/img/topic/7d8e67bd-7481-464c-917f-b8921580edcc.jpg",
//
//                     @"http://chongyin2.puyuntech.com:7074/res/assets/img/topic/7d8e67bd-7481-464c-917f-b8921580edcc.jpg",nil];
//        imgUrlArr = [NSArray arrayWithObjects:@"http://www.nyist.net/nyist_new/img/4562_1.jpg",
//         @"http://www.nyist.net/nyist_new/img/(5)_1.jpg",
//         @"http://soft.nyist.edu.cn/images/13/05/05/1mko5htk3p/pry2_vsb51E8-396.png",@"http://www.nyist.net/nyist_new/img/tyg.jpg",
//         @"http://soft.nyist.edu.cn/images/13/05/03/3va2w52ys4/7xin_image001.jpg",
//         @"http://soft.nyist.edu.cn/images/13/05/03/3va2w52ys4/7xin_image008.jpg",
//         @"http://soft.nyist.edu.cn/images/13/05/03/3va2w52ys4/7xin_image007.jpg", nil];
//        
//        //self.filmImage = [[NSMutableArray alloc]init];
//
//        for(int i=0;i <imgUrlArr.count;i++){
//
//            NSString *url = imgUrlArr[i];
//            [self.filmImage addObject:url];
//            [self.starImage addObject:url];
//
//        }
//
//    }
//    
//    if(nameArr==nil){
//    
//        nameArr = [NSArray arrayWithObjects:@"娄艺潇",@"钟汉良",@"杨幂",@"杨颖",@"孙红雷",
//                     @"aa",
//                     @"bb", nil];
//    
//    }
//}

#pragma mark- PageControl绑定ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//滚动就执行（会很多次）
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        int index = fabs(scrollView.contentOffset.y) / scrollView.frame.size.width;   //当前是第几个视图
        _pageControl.currentPage = index;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        CGRect frame = scrollView.frame;
        int y = fabs(scrollView.contentOffset.y);
        int width = CGRectGetWidth(frame);
        int index =  y/ width;   //当前是第几个视图
        _pageControl.currentPage = index;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
//    CGFloat h=[UIScreen mainScreen].bounds.size.height;
//    if(section == 0){
//        return 0;
//    
//    }
    //return 60*h/568;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n;
    
    if(tableView == hotFilmTableView){
    
        n = filmPhoto.count;
       // n = images1.count;
    
    }else if (tableView == hotStarTableView){
    
        n = starPhoto.count;
       // n = images2.count;
    }

    return n;
  
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section == 0)
//    {
//        return @" ";
//    }
//    
//        return @" ";
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    UITableViewCell *cell;
    static NSString *infocellname = @"cell";
    static NSString *starcellname = @"starcell";
    
    if(tableView == hotFilmTableView){
        
        NSDictionary *dic = [self.hotFilmList objectAtIndex:indexPath.row];
        InfoCell *infoCell = [hotFilmTableView dequeueReusableCellWithIdentifier:infocellname];
        if (infoCell == nil) {
        
            infoCell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellname];
            infoCell.transform = CGAffineTransformMakeRotation(M_PI /2 );
        }

        
        NSString *url = [dic objectForKey:@"moviePhoto"];
        NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
        NSURL *filmurl=[NSURL URLWithString:newUrl];
        [infoCell.filmImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_FILM_H]];
        //[infoCell.filmImageView setImage:[images1 objectAtIndex:indexPath.row]];
        infoCell.filmIdLab.text = [dic objectForKey:@"movieId"];
        cell = infoCell;
    }else if (tableView == hotStarTableView){
        
        NSDictionary *dic = [self.hotStarList objectAtIndex:indexPath.row];
        StarsCell *starCell = [hotStarTableView dequeueReusableCellWithIdentifier:starcellname];
        //starCell.se = [UIColor whiteColor];
        if (starCell == nil) {
            
            starCell = [[StarsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:starcellname];
            starCell.transform = CGAffineTransformMakeRotation(M_PI /2 );
        }
        
        NSString *url = [dic objectForKey:@"starPhoto"];
        NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
        NSURL *filmurl=[NSURL URLWithString:newUrl];
        [starCell.starImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_STAR]];
       //[starCell.starImageView setImage:[images2 objectAtIndex:indexPath.row]];
        starCell.starNameLab.text = [dic objectForKey:@"starName"];
        starCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = starCell;

    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat height;
    
    if(tableView == hotFilmTableView){
    
        height = w;
    }else if (tableView == hotStarTableView){
    
        height = 103*h/568;
    }
    
    return height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == hotFilmTableView){
    
        NSDictionary *dic = [self.hotFilmList objectAtIndex:indexPath.row];
        NSString *Id = [dic objectForKey:@"movieId"];
        
        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.filmDetail = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
       
        filmDetail.strID = Id;
//        self.filmDetail = [[FilmDetailViewController alloc]init];
//        filmDetail.strID = Id;
        [self.navigationController pushViewController:self.filmDetail animated:YES];
        //[self gotoFilmDetail];
       
    
    }else if (tableView == hotStarTableView){
    
        NSDictionary *dic = [self.hotStarList objectAtIndex:indexPath.row];
        NSString *ID = [dic objectForKey:@"starId"];

        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.filmStarsDetail = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
        filmStarsDetail.strID = ID;
       [self.navigationController pushViewController:self.filmStarsDetail animated:YES];
        //[self gotoFilmStarsDetail];
    }
    
}

-(void)reloadData
{
    [self.hotFilmTableView reloadData];
    _totalNum = filmId.count;
    _pageControl.numberOfPages = _totalNum; //设置页数 //滚动范围 600=300*2，分2页
    CGRect frame;
    frame = _pageControl.frame;
    frame.size.width = 15*_totalNum;
    frame.origin.x = (CGRectGetWidth(self.hotFilmTableView.frame) - CGRectGetWidth(frame))/2;
    _pageControl.frame = frame;
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

@end


