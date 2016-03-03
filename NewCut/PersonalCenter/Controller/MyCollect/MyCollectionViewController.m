//
//  MyCollectionViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "SCNavTabBarController.h"
#import "PYAllCommon.h"
#import "GoodsTabBarController.h"
#import "MCTabBarController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

@synthesize myCollectionStartView,myCollectionGoodsView,myCollectionFilmView,myCollectionPhotoView;
- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
//    
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
//    //
//    [self.navigationController.navigationBar setBackgroundImage:image                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:image
//     ];
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"ededed"]];
    
}
- (void)viewDidAppear:(BOOL)animated
{ [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor colorWithHexString:@"ededed"];
     self.navigationController.navigationBar.translucent = NO;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,-64,w , 64)];
    
    bgview.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:bgview];
    //[SVProgressHUD showInfoWithStatus:@"wwwwww"];
    
    //     self.backBtn.backgroundColor = [UIColor blueColor];
    //        UIImageView* imgView=[[UIImageView alloc]init];
    //        UIImage* img=[[UIImage alloc]init];
    //        img=[UIImage imageNamed:@"back"];
    //        [imgView setImage:img];
    //        self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(2, 40 , 20, 22)];
    //        [backBtn addSubview:imgView];
    //
    //        [self.view addSubview:backBtn];
    //        [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.myCollectionFilmView = [[MyCollectionFilmTableViewController alloc]init];
    myCollectionFilmView.title = @"影视";
    
    self.myCollectionStartView = [[MyCollectionStartTableViewController alloc]init];
    myCollectionStartView.title = @"明星";
  
    self.myCollectionGoodsView = [[MyCollectionGoodsTableViewController alloc]init];
    myCollectionGoodsView.title = @"商品";
//    self.myCollectionPhotoView = [[MyCollectionPhotoCollectionViewController alloc]init];
//    myCollectionPhotoView.title = @"照片";
        self.myCollectionPhotoView = [[MyCollectionImageViewController alloc]init];
        myCollectionPhotoView.title = @"照片";
    
//    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
//    //navTabBarController.view.frame = CGRectMake(20, 20, w, h);
//    
//    navTabBarController.subViewControllers = @[self.myCollectionFilmView, self.myCollectionStartView,self.myCollectionGoodsView,self.myCollectionPhotoView];
//    //    navTabBarController.showArrowButton = YES;
//
//    [navTabBarController addParentController:self];
    
    MCTabBarController *goodsTabBarController = [[MCTabBarController alloc] init];
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    goodsTabBarController.subViewControllers = @[self.myCollectionFilmView, self.myCollectionStartView,self.myCollectionGoodsView,self.myCollectionPhotoView];
    goodsTabBarController.goodsTabBarColor = [UIColor whiteColor];
//    goodsTabBarController.showArrowButton = YES;

    [goodsTabBarController addParentController:self];

    
    
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
