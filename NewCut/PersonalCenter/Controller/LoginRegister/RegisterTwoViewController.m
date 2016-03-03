//
//  RegisterTwoViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "NSString+Extensions.h"
#import <SMS_SDK/SMS_SDK.h>
#import "MD5.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "CMAPI.h"
#import "PYUserData.h"
#import "MJExtension.h"
#import "CMData.h"
#import "DataBaseTool.h"
#import "MenuTabBarViewController.h"
@interface RegisterTwoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;
@property(nonatomic ,assign)BOOL isSendCode;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeText;
@property(nonatomic ,assign)BOOL isVerifyCodeSuccess;
@property (weak, nonatomic) IBOutlet UILabel *promLable;

- (IBAction)resendBtnClick;


- (IBAction)finishBtnClick;
@end

@implementation RegisterTwoViewController


- (void)viewWillAppear:(BOOL)animated
{
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:image];
    
//    self.navigationController.navigationBarHidden = NO;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.promLable.text = [NSString stringWithFormat:@"请输入%@****%@收到的短信校验码",[self.tel SubsLeft:3],[self.tel SubsRight:4]];
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_2.png"];
    [self.view insertSubview:bgImage atIndex:0];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dbdbdb"]] forState:UIControlStateNormal];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b6b6b6"]] forState:UIControlStateHighlighted];
    [self.finishBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.finishBtn.layer.cornerRadius = 5;
    self.finishBtn.layer.masksToBounds = YES;
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];
    [self startTime];
}

- (void)hidKeyborad:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

- (IBAction)resendBtnClick {
    [self getIdentifyCode];
}

- (IBAction)finishBtnClick {
    [self CommitIdentifyCode];
}

-(void)textFieldDidChange:(UITextField*) TextField{
    
    if(![TextField.text isEqualToString:@""]){
        
        self.finishBtn.backgroundColor = [UIColor colorWithHexString:@"184ca2"];
        self.finishBtn.userInteractionEnabled = YES;
    }else{
        
        self.finishBtn.backgroundColor = [UIColor grayColor];
        self.finishBtn.userInteractionEnabled = NO;
    }
    
}



//验证码有效时间
-(void)startTime{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    __block int timeout=50; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.resendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.resendBtn.titleLabel.font = [UIFont systemFontOfSize :13] ;
                self.resendBtn.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
                [self.resendBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                self.resendBtn.titleLabel.font = [UIFont systemFontOfSize :13] ;
                [self.resendBtn setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
                
                self.resendBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

//获取验证码
-(void)getIdentifyCode{
    
    NSString *tel = self.tel;
    NSString *message=[NSString stringWithFormat:@"%@****%@",[tel SubsLeft:3],[tel SubsRight:4]];
    NSString *string1 = @"请输入";
    NSString *string2 = @"收到的短信验证码";
    NSString *alert1 = [string1 stringByAppendingString:message];
    NSString *alert2 = [alert1 stringByAppendingString:string2];
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:tel zone:@"86" result:^(SMS_SDKError *error) {
        if(!error){
            self.isSendCode = YES;
            //showMessageCheckIdentify(@"提示！", alert2);
            
        }else{
            self.isSendCode = NO;
            showMessageCheckCode(@"提示！", @"发送失败，请重新获取！");
        }
    }];
    
    [self startTime];
    
}


-(void)CommitIdentifyCode{
    
    
    NSString *identifyCode = self.checkCodeText.text;
    //    setPasswordView.strTel = self.strTel;
    //[self.navigationController pushViewController:setPasswordView animated:YES];
    [SMS_SDK commitVerifyCode:identifyCode result:^(enum SMS_ResponseState state) {
        if(state==1){
            if(![CMTool isConnectionAvailable]){
                
                [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
            }else{
            self.isVerifyCodeSuccess = YES;
            
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"Username"] = self.tel;
            param[@"tel"] = self.tel;
            param[@"password"] = [NSString stringWithMD5EncodedString:self.password];
            //          param[@"password"] = passWord;
            param[@"nickName"] = @"";
            param[@"userImage"] = @"";
            param[@"regDate"] = [NSDate date];
            NSLog(@"%@",param);
            [CMAPI postUrl:API_USER_REG Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
                id result = [detailDict objectForKey:@"code"];
//                NSString *strCode =  [NSString stringWithFormat:@"%@",result];
                // NSLog(@"%@",strCode);
                
                if(succeed){
                    //                self.LoadingView.hidden = YES;
                    NSDictionary* result = [detailDict valueForKey:@"result"];
                    PYUserData *userData = [PYUserData objectWithKeyValues:[result objectForKey:@"success"]];
                    NSString *token = [result objectForKey:@"token"];
                    
                    [DataBaseTool addUserInfo:userData];
                    [CMData setToken: token];
                    [CMData setUserName:userData.name];
                    [CMData setUserId:userData.userId];
                    [CMData setPassword:[NSString stringWithMD5EncodedString:self.password]];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERIMAGE" object:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_USERNICKNAME" object:nil userInfo:@{@"nickName":userData.nickName}];
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                    return ;
                    
                }else{
                    
                    //如果失败，弹出提示
                    //                self.LoadingView.hidden = YES;
                    NSDictionary *dic=[detailDict valueForKey:@"result"];
                    if(!!dic&&dic.count>0)
                        result=[dic valueForKey:@"reason"];
                    
                    result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                    
                    NSString *message ;
                    if([result isEqualToString:@"4012"]){
                        message = @"此手机号已被注册！";
                    }
                    
                    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                    [SVProgressHUD setInfoImage:nil];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD showInfoWithStatus:@"此手机号已被注册！"];
                    
                    return;
                    
                }
            }];
            
            
            return ;
            }
        
            }else if(state==0){
            self.isVerifyCodeSuccess = NO;
            showMessageCheckCode(@"提示！", @"验证失败！");
            
            return;
        }
    }];
    
}
//提示框
int showMessageCheckCode(NSString *title,NSString* message){
    
    UIAlertView *Alert = [[UIAlertView alloc]
                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Alert show];
    return 1;
}


@end
