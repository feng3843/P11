//
//  PersonalInfoNicknameViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/23.
//  Copyright (c) 2015年 py. All rights reserved.
//


#import "PersonalInfoNicknameViewController.h"
#import "UIColor+Extensions.h"
#import "CMData.h"
#import "CMAPI.h"
#import "SVProgressHUD.h"
#import "UIImage+Extensions.h"
#import "DataBaseTool.h"
#import "DataBaseTool.h"
#import "CMTool.h"
#import "PYAllCommon.h"

#define userImagePath  @"MyImage"
@interface PersonalInfoNicknameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameText;

@property(nonatomic ,weak)UIButton *saveBtn;
@end

@implementation PersonalInfoNicknameViewController
- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([CMData getLoginType]) {
        [SVProgressHUD showInfoWithStatus:@"第三方登录不能修改昵称"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }
    /***王朋****/
    self.nickNameText.tintColor = [UIColor blackColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
     self.navigationController.navigationBar.translucent = NO; 
    self.title = @"昵称";
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveDidClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.frame = CGRectMake(0, 0, 35, 35);
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.saveBtn = saveBtn;
    [saveBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal ];
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
    self.navigationItem.rightBarButtonItem = saveBtnItem;
    [self changeStartName];
    [self.nickNameText addTarget:self action:@selector(nickNameTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.nickNameText.placeholder = @"请修改昵称";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nickNameTextDidChange:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""] && ![textField.text isEqualToString:@""]) {
        self.saveBtn.userInteractionEnabled = YES;
        
    }else
    {
        self.saveBtn.userInteractionEnabled = NO;
    }
}
- (void)saveDidClick
{
    [self.view endEditing:YES];
    [self ChangeNickName];
}
/** 昵称*/
- (void)changeStartName
{
    if (![[DataBaseTool getNickName] isEqualToString:@""]) {
        self.nickNameText.text = [DataBaseTool getNickName];
    }else
    {
        self.nickNameText.text = @"";
    }
    
}

- (void)ChangeNickName
{
    
    if(self.nickNameText.text.length >= 10)
    {
        [SVProgressHUD showInfoWithStatus:@"昵称不能超过10个字!"];

        return;
    }
    
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString *userName = [CMData getUserName];
    NSString *token = [CMData getToken];
    NSString *nickName = self.nickNameText.text;
    NSDictionary *param = @{@"token":token,
                            @"nickName":nickName,
                           @"username":userName
                            };

    [CMAPI postUrl:API_USER_MODIFYPERSONAL Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        //        //do someth ing
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCEL_LOADING" object:nil];
       
        id result = [detailDict objectForKey:@"code"];
        if(succeed)
        {
                [DataBaseTool updateNickName:nickName];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERNICKNAME" object:nil userInfo:@{@"nickName":nickName}];
            [self.navigationController popViewControllerAnimated:YES];
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
            [SVProgressHUD showInfoWithStatus:@"昵称修改错误！"];
            
        }
    }];
    }
}

@end
