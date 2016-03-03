//
//  FimTabBarViewController.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FimTabBarViewController.h"
#import "SCNavTabBarController.h"
#import "PYAllCommon.h"

@interface FimTabBarViewController ()

@end

@implementation FimTabBarViewController
@synthesize favoriteFilmView,allFilmView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;

   // self.backBtn.backgroundColor = [UIColor blueColor];
//    UIImageView* imgView=[[UIImageView alloc]init];
//    UIImage* img=[[UIImage alloc]init];
//    img=[UIImage imageNamed:@"back"];
//    [imgView setImage:img];
//    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(2, 40 , 20, 22)];
//    [backBtn addSubview:imgView];
//
//    [self.view addSubview:backBtn];
//    [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.favoriteFilmView = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteFilmViewId"];
    favoriteFilmView.title = @"热门影视";
    
    self.allFilmView = [self.storyboard instantiateViewControllerWithIdentifier:@"AllFilmViewId"];
    allFilmView.title = @"全部影视";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
//    navTabBarController.view.frame = CGRectMake(20, 20, w, h);
//    navTabBarController.view.backgroundColor = [UIColor redColor];
    navTabBarController.subViewControllers = @[self.favoriteFilmView, self.allFilmView];
    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
//    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16*h/568, 28*h/568, 23*h/568, 23*h/568)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back_gray"] forState:UIControlStateNormal];
    [self.view addSubview:self.backBtn];
    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (IBAction)closeView:(id)sender {
    
    [SVProgressHUD showInfoWithStatus:@"wwwwww"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)closeView
{
    [self.navigationController popViewControllerAnimated:YES];
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
