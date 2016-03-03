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
#import "SecurityCheckViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
 
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // Do any additional setup after loading the view.
  
    [self settupGroup0];
    [self settupGroup1];
 
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    self.tableView.tableHeaderView = [[ContactsHeaderView alloc]initWithFrame:CGRectMake(0, -25, [UIScreen mainScreen].bounds.size.width, 253)];
//    self.navigationController.navigationBarHidden = YES;
//    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionHeaderHeight = 11;
}
- (void)settupGroup0
{
    SettingGroup *group = [[SettingGroup alloc]init];
    
#warning 修改手机号码 [ChangePasswordViewController class]
    SettingItem *changePhoneNum = [SettingArrowItem itemWithTitle:@"修改手机号码" destVcClass:[SecurityCheckViewController class]];
    
     SettingItem *changePassword = [SettingArrowItem itemWithTitle:@"修改密码" destVcClass:[ChangePasswordViewController class]];
    group.items = @[changePhoneNum,changePassword];
    [self.data addObject:group];
}


- (void)settupGroup1
{
    SettingGroup *group = [[SettingGroup alloc]init];
    
    SettingItem *myCollection = [SettingArrowItem itemWithTitle:@"我的收藏" destVcClass:nil];
    SettingItem *myComments = [SettingArrowItem itemWithTitle:@"我的评论" destVcClass:nil];
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
