//
//  ContactsViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/16.
//  Copyright (c) 2015年 py. All rights reserved.
//  个人中心首页

#import "ContactsViewController.h"
#import "SettingGroup.h"
#import "SettingArrowItem.h"
#import "SettingItem.h"
#import "ChangePasswordViewController.h"
#import "ContactsHeaderView.h"
#import "SecurityCheckPhoneViewController.h"
#import "MyCommentTableViewController.h"
#import "MyCollectionViewController.h"
#import "MyCollectionGoodsTableViewController.h"
#import "MyCollectionPhotoCollectionViewController.h"
#import "ContactsSettingTableViewController.h"
#import "PersonalInfoTableViewController.h"
#import "CMData.h"

#import "ContactsNavViewController.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "PYAllCommon.h"
#import "CMData.h"
@interface ContactsViewController ()<ContactsHeaderViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation ContactsViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.navigationController.navigationBarHidden = YES;

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
       self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor blackColor],UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};
    [super viewWillAppear:animated];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // Do any additional setup after loading the view.
 
    [self settupGroup0];
    [self settupGroup1];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor blackColor],UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};

   self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBarHidden = YES;
    self.title = @"";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    ContactsHeaderView *contactsHeader = [[ContactsHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 253 + 20)];
    contactsHeader.delegate = self;
    self.tableView.tableHeaderView = contactsHeader;
    //    self.navigationController.navigationBarHidden = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionHeaderHeight = 11;
    self.tableView.scrollEnabled = NO;
    
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
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


- (void)setUpBtnDidClick
{
   
    if (![[CMData getToken] isEqualToString:@""]) {
     
        UIStoryboard *registerView = self.storyboard;
        ContactsSettingTableViewController *vc = [registerView instantiateViewControllerWithIdentifier:@"ContactsSettingId"];
        [self.navigationController pushViewController:vc animated:YES];
        self.navigationController.navigationBarHidden = NO;
        return;
    }
    
    [self noLogin];
}
- (void)startBtnDidClick
{
     if (![[CMData getToken] isEqualToString:@""]) {
  
         
         
    UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalInfoTableViewController *vc = [registerView instantiateViewControllerWithIdentifier:@"PersonalInfoId"];
         
         [self.navigationController pushViewController:vc animated:YES];
         self.navigationController.navigationBarHidden = NO;
     
           return;
     }
    [self noLogin];
}



- (void)settupGroup0
{
    SettingGroup *group = [[SettingGroup alloc]init];

    SettingItem *changePhoneNum = [SettingArrowItem itemWithTitle:@"修改手机号码" destVcClass:[SecurityCheckPhoneViewController class]];
    
     SettingItem *changePassword = [SettingArrowItem itemWithTitle:@"修改密码" destVcClass:[ChangePasswordViewController class]];
        group.items = @[changePhoneNum,changePassword];
   

    [self.data addObject:group];
}


- (void)settupGroup1
{
    SettingGroup *group = [[SettingGroup alloc]init];
    
    SettingItem *myCollection = [SettingArrowItem itemWithTitle:@"我的收藏" destVcClass:[MyCollectionViewController class]];
    SettingItem *myComments = [SettingArrowItem itemWithTitle:@"我的评论" destVcClass:[MyCommentTableViewController class]];
     group.items = @[myCollection,myComments];
    
    [self.data addObject:group];
}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//    return 11;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
