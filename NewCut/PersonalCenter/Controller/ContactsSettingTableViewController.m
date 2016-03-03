//
//  ContactsSettingTableViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/20.
//  Copyright (c) 2015年 py. All rights reserved.
//  个人中心-设置

#import "ContactsSettingTableViewController.h"
#import "ContactsSettingHeaderView.h"
#import "CMAPI.h"
#import "CMData.h"
#import "SVProgressHUD.h"
#import "UIColor+Extensions.h"

#import "ContactsNavViewController.h"
#import "CMTool.h"
#import "MenuTabBarViewController.h"
#import "PYAllCommon.h"

@interface ContactsSettingTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@property(nonatomic ,weak) IBOutlet UIButton *logoutBtn;
- (IBAction)logoutBtnClick;
@end

@implementation ContactsSettingTableViewController
- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 50;
    
    self.tableView.tableHeaderView = [[ContactsSettingHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230)];
    self.title = @"设置";

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    self.versionLabel.text = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // 设置不可以滚动
    self.tableView.scrollEnabled = NO;
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)logoutBtnClick {
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
    NSString *token = [CMData getToken];
    
    NSDictionary *param = @{@"token":token
                            };
    [CMAPI postUrl:API_USER_LOGOUT Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        //        //do something
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCEL_LOADING" object:nil];
        
        id result = [detailDict objectForKey:@"code"];
        if(succeed)
        {
             [SVProgressHUD showInfoWithStatus:@"退出成功！"];
            
            NSString* username = [CMData getUserName];
            if (![username containsString:@"TEL"]) {
                if ([username containsString:@"WX"]) {
                    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
                }
                else if ([username containsString:@"WB"]) {
                    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
                }
                else if ([username containsString:@"QQ"]) {
                    AppDelegate* appde = (AppDelegate*)[UIApplication sharedApplication].delegate;
                    TencentOAuth* tOAuth = appde.tencentOAuth;
//                    [tOAuth logout:appde];//logout之后 有一段时间 无法使用QQ登录
                }
            }
            
             [CMData setToken: @""];
             [CMData setUserName:@""];
             [CMData setUserId:@""];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCEL_LOGOUT" object:nil];
//              UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//               MenuTabBarViewController *vc = [registerView instantiateViewControllerWithIdentifier:@"menuTabId"];
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            //如果失败，弹出提示
            NSDictionary *dic=[detailDict valueForKey:@"result"];
            if(!!dic&&dic.count>0)
                result=[dic valueForKey:@"reason"];
            
            result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
            [SVProgressHUD setInfoImage:nil];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:@"退出失败！"];
         
          }
    }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
