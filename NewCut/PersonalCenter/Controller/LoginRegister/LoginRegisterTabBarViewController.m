//
//  LoginRegisterTabBarViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "LoginRegisterTabBarViewController.h"
#import "PYAllCommon.h"
#import "SCNavTabBarController.h"
#import "LRViewController.h"
@interface LoginRegisterTabBarViewController ()

@end

@implementation LoginRegisterTabBarViewController
@synthesize favoriteFilmView,allFilmView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
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
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
//      self.view.backgroundColor = [UIColor clearColor];
    self.favoriteFilmView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewId"];
    favoriteFilmView.title = @"登录";
    
    self.allFilmView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"RegisterViewId"];
    allFilmView.title = @"注册";

    
    LRViewController *navTabBarController = [[LRViewController alloc] initWithSubViewControllers:@[self.favoriteFilmView, self.allFilmView]];

//    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
//    image.frame = navTabBarController.view.frame;
//    [navTabBarController.view addSubview:image];
    //navTabBarController.view.frame = CGRectMake(20, 20, w, h);
    
//    navTabBarController.view.backgroundColor = [UIColor redColor];
//    navTabBarController.view.alpha = 0.3;
    
    navTabBarController.view.backgroundColor = [UIColor colorWithHexString:@"ff9c00"];
//    navTabBarController.borderWidth = 28;
    navTabBarController.showArrowButton = YES;
//    navTabBarController.navTabBarLineColor = [UIColor redColor];
//    navTabBarController.navTabBarColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
   
    [navTabBarController addParentController:self];
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
