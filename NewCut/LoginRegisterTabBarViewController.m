//
//  LoginRegisterTabBarViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "LoginRegisterTabBarViewController.h"
#import "SCNavTabBarController.h"
#import "PYAllCommon.h"
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.favoriteFilmView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewId"];
    favoriteFilmView.title = @"登录";
   
    self.allFilmView = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewId"];
    allFilmView.title = @"注册";

    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    //navTabBarController.view.frame = CGRectMake(20, 20, w, h);
    
    navTabBarController.subViewControllers = @[self.favoriteFilmView, self.allFilmView];
//    navTabBarController.showArrowButton = YES;
   
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
