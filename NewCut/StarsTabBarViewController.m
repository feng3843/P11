//
//  StarsTabBarViewController.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarsTabBarViewController.h"
#import "SCNavTabBarController.h"

@interface StarsTabBarViewController ()

@end

@implementation StarsTabBarViewController
@synthesize allStarsView,favoriteStarsView;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.allStarsView = [self.storyboard instantiateViewControllerWithIdentifier:@"AllStarsViewId"];
    allStarsView.title = @"全部影星";
    
    self.favoriteStarsView = [self.storyboard instantiateViewControllerWithIdentifier:@"popularStarsViewId"];
    favoriteStarsView.title = @"热门影星";
    
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
 
    navTabBarController.subViewControllers = @[self.favoriteStarsView, self.allStarsView];
    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
    
   self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16*h/568, 28*h/568, 23*h/568, 23*h/568)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back_gray"] forState:UIControlStateNormal];
    [self.view addSubview:self.backBtn];
    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
