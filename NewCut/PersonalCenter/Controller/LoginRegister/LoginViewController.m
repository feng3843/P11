//
//  LoginViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
// 

#import "LoginViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "CoreArchive.h"
#import "CMAPI.h"
#import "CMData.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "MD5.h"
#import "PYUserData.h"
#import "MJExtension.h"
#import "DataBaseTool.h"
#import "ForgetPasswordOneViewController.h"
#import "ContactsNavViewController.h"
#import "PYAllCommon.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface LoginViewController ()
{
    PYUserData* uData;
    ShareType type;
}
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (weak, nonatomic) IBOutlet UIView *LoadingView;

- (IBAction)loginBtnDidClick;
- (IBAction)forgetPassword;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
   
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//   UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
//    bgImage.image = [UIImage imageNamed:@"bg_2.png"];
//    [self.view insertSubview:bgImage atIndex:0];
    self.view.backgroundColor = [UIColor clearColor];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dbdbdb"]] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b6b6b6"]] forState:UIControlStateHighlighted];
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];
    [self.PwdTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.PwdTextField.secureTextEntry = YES;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    type = ShareTypeAny;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogin:) name:@"AUTO_LOGIN" object:nil];
    self.phoneTextField.tintColor = [UIColor whiteColor];
     self.PwdTextField.tintColor = [UIColor whiteColor];
}

- (void)hidKeyborad:(id)sender {
    [self.view endEditing:YES];
}
//监听输入框事件
-(void)textFieldDidChange:(UITextField*) TextField{
    
   
    if(![self.phoneTextField.text isEqualToString:@""] && ![self.PwdTextField.text isEqualToString:@""]){
        
//        self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"d28000"];
        self.loginBtn.userInteractionEnabled = YES;
    }else{
        
//        self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"ff9c00"];
        self.loginBtn.userInteractionEnabled = NO;
    }
    
}
//限制输入框的内容的大小
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [self.phoneTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneTextField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
//            [SVProgressHUD showInfoWithStatus:@"手机号最多11位！"];
            
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtnDidClick {

    
    NSString *username = self.phoneTextField.text;
//    forgetView.strTel = username;
    NSString *passWord = self.PwdTextField.text;
//    NSString *pwdLocal = [CoreArchive strForKey:username];
////    viewController.strTel = username;
//
//    [SVProgressHUD showInfoWithStatus:pwdLocal];
    PyResetValueKey *p = [PyResetValueKey alloc];
    NSMutableArray *settings = [[NSMutableArray alloc] init];
    p = [p initNewkey:@"result" OldKey:@"result"];
    [settings addObject:p];
    // NSString *str = [CMData getRealName];

   // 显示加载动画
    self.LoadingView.hidden = NO;
    if ([username isEqualToString:@""]) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入注册时的手机号码"];
        [self.phoneTextField becomeFirstResponder];//获取焦点弹出键
        self.LoadingView.hidden = YES;
        return;
    }
    if ([username length]!=11) {
        
        [SVProgressHUD showInfoWithStatus:@"手机号码为11位"];
        [self.phoneTextField becomeFirstResponder];//获取焦点弹出键
        self.LoadingView.hidden = YES;
        return;
    }
     if ([passWord isEqualToString:@""]) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        [self.PwdTextField becomeFirstResponder];//获取焦点弹出键盘
        self.LoadingView.hidden = YES;
        return;
    }
    
    if (![CMTool validateTel:username]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        [self.phoneTextField becomeFirstResponder];//获取焦点弹出键盘
        self.LoadingView.hidden = YES;
        return;
    }

    [self.phoneTextField resignFirstResponder];//关闭键盘
    [self.PwdTextField resignFirstResponder];//关闭键盘

    
    [self autoLogin];
}

- (IBAction)forgetPassword {
    
    UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForgetPasswordOneViewController *vc = [registerView instantiateViewControllerWithIdentifier:@"ForgetPasswordOne"];
//    ContactsNavViewController *nav = [[ContactsNavViewController alloc]initWithRootViewController:vc];
//    [self.navigationController pushViewController:vc animated:YES];

    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)autoLogin:(NSNotification*)notification
{
    uData = notification.object;
    [self autoLogin];
}

-(void)autoLogin
{
    NSString* userName = self.phoneTextField.text;
    NSString* username;
    switch (type) {
        case ShareTypeQQ:
        {
            username = [NSString stringWithFormat:@"QQ%@",uData.name];
        }
            break;
        case ShareTypeWeixiSession:
        {
            username = [NSString stringWithFormat:@"WX%@",uData.name];
        }
            break;
        case ShareTypeSinaWeibo:
        {
            username = [NSString stringWithFormat:@"WB%@",uData.name];
        }
            break;
            default:
        {
            username = [NSString stringWithFormat:@"TEL%@",userName];
        }
            break;
    }
    if (!uData) {
        uData = [[PYUserData alloc] init];
    }
    NSString *pwd = [NSString stringWithMD5EncodedString:self.PwdTextField.text];
    NSDictionary *param = @{@"userName":username,
                            @"pwd":pwd,
                            @"nickName":uData.nickName?uData.nickName:@""
                            };
    if(![CMTool isConnectionAvailable])
    {
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }
    else
    {
    
    [CMAPI postUrl:API_USER_LOGIN Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        
        id result = [detailDict objectForKey:@"code"];
        if(succeed)
        {
            self.LoadingView.hidden = YES;
            NSDictionary* result = [detailDict valueForKey:@"result"];
            PYUserData *userData = [PYUserData objectWithKeyValues:[result objectForKey:@"user"]];
            NSString *token = [result objectForKey:@"token"];

            uData.userId = userData.userId;
            uData.name = userData.name;
            uData.nickName = userData.nickName;
            if(userData.userImage&&![@"" isEqualToString:userData.userImage])
            {
                uData.userImage = userData.userImage;
            }
            [CMData setToken: token];
            [CMData setUserName:userData.name];
            [CMData setUserId:userData.userId];
            [CMData setPassword:pwd];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERNICKNAME" object:nil userInfo:@{@"nickName":userData.nickName}];
        
            //上传头像照片
            if (type != ShareTypeAny) {
                [CMData setLoginType:true];
                
                NSDictionary *param = @{@"token":token
                                        };
                [CMAPI postUrl:API_USER_MODIFYIMAGE Param:param Settings:nil FileData:[NSData dataWithContentsOfURL:[NSURL URLWithString:uData.userImage]] OpName:nil FileName:@"UserImage.jpg" FileType:@"image/jpeg" completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
                    
                    if(succeed)
                    {
                        NSString *fileName = [detailDict objectForKey:@"fileName"];
                        uData.userImage = fileName;
                        [DataBaseTool addUserInfo:uData];
                        
                    }else
                    {
                        [DataBaseTool addUserInfo:uData];
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERIMAGE" object:nil];
                }];
            }
            else
            {
                [CMData setLoginType:false];
                [DataBaseTool addUserInfo:userData];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERIMAGE" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            UITabBarController* menu = (UITabBarController*)self.navigationController.parentViewController;
//            [menu setSelectedIndex:0];99
        }
        else
        {
              self.LoadingView.hidden = YES;
            //如果失败，弹出提示
            NSDictionary *dic=[detailDict valueForKey:@"result"];
            if(!!dic&&dic.count>0)
                result=[dic valueForKey:@"reason"];
            
            result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
            
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
            [SVProgressHUD setInfoImage:nil];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:@"账号或密码错误！"];
            [CMData setToken: @""];
        }
    }];
    }
}

// 第三方登录
- (IBAction)loginWithQQ:(id)sender
{
    
    
    TencentOAuth* tOAuth = ((AppDelegate*)[UIApplication sharedApplication].delegate).tencentOAuth;
    NSArray* permissions = ((AppDelegate*)[UIApplication sharedApplication].delegate).permissions;
    
    if(![TencentOAuth iphoneQQInstalled])
    {
        [SVProgressHUD showInfoWithStatus:@"未安装QQ"];
        return;
    }
    
    type = ShareTypeQQ;
    if([tOAuth isSessionValid])
    {
        [tOAuth getUserInfo];
    }
    else
    {
        [tOAuth authorize:permissions inSafari:NO];
    }
}

- (IBAction)loginWithWX:(id)sender
{
    if(![WXApi isWXAppInstalled])
    {
        [SVProgressHUD showInfoWithStatus:@"未安装微信"];
        return;
    }
    
    type = ShareTypeWeixiSession;
    [self loginWithThird];
}

- (IBAction)loginWithWB:(id)sender
{
    if(![WeiboSDK isWeiboAppInstalled])
    {
        [SVProgressHUD showInfoWithStatus:@"未安装新浪微博"];
        return;
    }
    type = ShareTypeSinaWeibo;
    [self loginWithThird];
}

-(void)loginWithThird
{
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    [ShareSDK getUserInfoWithType:type
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               if (result)
                               {
                                   NSLog(@"userInfo%@",userInfo);
                                   if (!uData) {
                                      uData = [[PYUserData alloc] init];
                                   }
                                   uData.nickName = [userInfo nickname];
                                   uData.name = [userInfo uid];
                                   uData.userImage = [userInfo profileImage];
                                   
                                   [self autoLogin];
                               }
                               else
                               {
                                   NSLog(@"%ld:%@",(long)[error errorCode], [error errorDescription]);
                               }
                           }];
}

@end
