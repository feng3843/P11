//
//  MenuTabBarViewController.m
//  NewCut
//
//  Created by py on 15-7-8.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MenuTabBarViewController.h"
#import "PYAllCommon.h"

@interface MenuTabBarViewController ()

@end

@implementation MenuTabBarViewController
@synthesize menuTabBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat h=[UIScreen mainScreen].bounds.size.height;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    [self.menuTabBar setFrame:CGRectMake(0, 528*h/568, w, 40*h/568)];
    self.menuTabBar.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    //menuTabBar.tintColor = [UIColor colorWithHexString:@"333333"];
    //MenuTabBarViewController.menuTabBar.tintColor = [UIColor colorWithHexString:@"333333"];;
    // Do any additional setup after loading the view.
    self.delegate  = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [CMAPI checkWeb:^{
        
    }];
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
