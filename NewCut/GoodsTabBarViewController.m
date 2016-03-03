//
//  GoodsTabBarViewController.m
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodsTabBarViewController.h"
#import "PYAllCommon.h"
#import "GoodsTabBarController.h"
#import "UIView+AutoLayout.h"
#import "MCTabBarController.h"
#import "UIImage+Extensions.h"
@interface GoodsTabBarViewController ()

@end

@implementation GoodsTabBarViewController
@synthesize accessoryView,dressView,peiJianView,shoesView,bagView,menuView;

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,-64,w , 64)];
    
    bgview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgview];
    
//   UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(w - 244 * 0.5 *0.5, 0.0f, 244 * 0.5, 47 * 0.5)];//初始化图片视图控件
////    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    UIImage *image = [UIImage imageNamed:@"title.png"];//初始化图像视图
//    [imageView setImage:image];
//    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"title_1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0f, image.size.width * 0.5,image.size.height  * 0.5)];//初始化图片视图控件

    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
//初始化图像视图

    [imageView setImage:image];

    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView
  
    
    
  self.navigationController.navigationBar.translucent = NO;
//
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
//    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.accessoryView = [self.storyboard instantiateViewControllerWithIdentifier:@"accessoryViewId"];
    accessoryView.title = @"饰品";
    
    self.dressView = [self.storyboard instantiateViewControllerWithIdentifier:@"dressViewId"];
    dressView.title = @"服装";
    
    self.peiJianView = [self.storyboard instantiateViewControllerWithIdentifier:@"PeiJianViewId"];
    peiJianView.title = @"配件";
    
    self.shoesView = [self.storyboard instantiateViewControllerWithIdentifier:@"shoesViewId"];
    shoesView.title = @"鞋子";
    
    self.bagView = [self.storyboard instantiateViewControllerWithIdentifier:@"bagViewId"];
    bagView.title = @"包包";
    self.surroundingMovie =  [[SurroundingMovieViewController alloc]init];
    self.surroundingMovie.title =  @"周边";
   GoodsTabBarController *goodsTabBarController = [[GoodsTabBarController alloc] init];
//    goodsTabBarController.view.backgroundColor = [UIColor whiteColor];
    goodsTabBarController.subViewControllers = @[ self.dressView,self.bagView,self.peiJianView,self.shoesView,self.accessoryView,self.surroundingMovie];
//    goodsTabBarController.showArrowButton = YES;
    [goodsTabBarController addParentController:self];
    goodsTabBarController.index = self.index;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = NO;

    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f6f6f6"]]                                                      forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f6f6f6"]]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0f, 427 * 0.5,47 * 0.5)];//初始化图片视图控件
//    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
//    UIImage *image = [UIImage imageNamed:@"title_1.png"];//初始化图像视图
//    [imageView setImage:image];
//    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView
//    
//    
        UIImage *image = [UIImage imageNamed:@""];
    //    //
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f6f6f6"]]                                                      forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f6f6f6"]]];
      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.presentingViewController.hidesBottomBarWhenPushed = NO;
}

-(void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)backToPreView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backToHomeView
{
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.menuView = [View instantiateViewControllerWithIdentifier:@"menuTabId"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)backToPersonView{
    
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.menuView = [View instantiateViewControllerWithIdentifier:@"menuTabId"];

    self.menuView.selectedIndex = 2;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
