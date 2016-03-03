//
//  ContactsNavViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ContactsNavViewController.h"
#import "SingleGoodViewController.h"
#import "ChangePasswordViewController.h"
#import "CMData.h"
#import "SVProgressHUD.h"
@interface ContactsNavViewController ()

@end

@implementation ContactsNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.tintColor = [UIColor clearColor];
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
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (![viewController isKindOfClass:[SingleGoodViewController class]]) {
         viewController.hidesBottomBarWhenPushed = YES;
    }else
    {
        viewController.hidesBottomBarWhenPushed = NO;

    }
 
    
    UIImage *image = [UIImage imageNamed:@""];
    
    [self.navigationController.navigationBar setBackgroundImage:image
     
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:image];
//        viewController.edgesForExtendedLayout = UIRectEdgeAll;
//    if ([viewController isKindOfClass:[ChangePasswordViewController class]]) {
//        
//        if ([CMData getLoginType]) {
//            [SVProgressHUD showInfoWithStatus:@"第三方登录不能修改密码"];
//            return;
//        }
//    }
        [super pushViewController:viewController animated:animated];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(15, 5, 23, 23);
    
    [btn setImage:[UIImage imageNamed:@"bt_back_gray"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:btn];
 // 设置导航栏的leftButton
    
    viewController.navigationItem.leftBarButtonItem=back;

//    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
//    backItem.title=@"后退";
//    backItem.tintColor=[UIColor colorWithRed:129/255.0 green:129/255.0  blue:129/255.0 alpha:1.0];
//    self.navigationItem.backBarButtonItem = backItem;
    
}
-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
       UIViewController *vc = ( UIViewController *)[self.childViewControllers lastObject];
    [vc.navigationController popViewControllerAnimated:YES];
    
}
@end
