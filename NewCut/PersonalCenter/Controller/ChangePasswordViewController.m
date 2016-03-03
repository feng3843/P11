//
//  ChangePasswordViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/15.
//  Copyright (c) 2015年 py. All rights reserved.
//  重置登录密码 

#import "ChangePasswordViewController.h"
#import "UIColor+Extensions.h"
#import "CMData.h"
#import "CMAPI.h"
#import "SVProgressHUD.h"
#import "MD5.h"

#import "ContactsNavViewController.h"
#import "UIImage+Extensions.h"
#import "CMTool.h"
#import "PYAllCommon.h"

@interface ChangePasswordViewController ()<UIAlertViewDelegate>

@property(nonatomic ,weak)UIView *centerView;
/** 当前密码*/
@property(nonatomic ,weak)UITextField *currentPwdText;
/** 新密码*/
@property(nonatomic ,weak)UITextField *newpwdText;
/** 确认密码*/
@property(nonatomic ,weak)UITextField *confrimPwdText;
/** 完成按钮*/
@property(nonatomic ,weak)UIButton *finishBtn;

@end

@implementation ChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([CMData getLoginType]) {
        [SVProgressHUD showInfoWithStatus:@"第三方登录不能修改密码"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [self.navigationController popViewControllerAnimated:YES];
        });

    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    // 设置控件
    [self setupView];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];


}


- (void)hidKeyborad:(id)sender {
    [self.view endEditing:YES];
}
/** 设置View*/
- (void)setupView
{
    // 密码字体
    int PwdFont = 14;
    int screenW = [UIScreen mainScreen].bounds.size.width;
    // 密码lable的宽度
    int PwdW = 95;
    int height = 44;
    int topH = 18 ;
    int leftW = 16;
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, topH, screenW, height * 3)];
    centerView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    self.centerView = centerView;
    [self.view addSubview:centerView];
    // 第一个分割线
    UIView *oneDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    oneDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.centerView addSubview:oneDividingLine];
    
    UILabel *currentPwd = [[UILabel alloc]initWithFrame:CGRectMake(leftW, 0, PwdW, height)];
    currentPwd.text = @"当前密码";
    currentPwd.textColor = [UIColor colorWithHexString:@"666666"];
    currentPwd.font = [UIFont systemFontOfSize:PwdFont];
    [self.centerView addSubview:currentPwd];
   
    // 第二个分割线
    UIView *twoDividingLine = [[UIView alloc]initWithFrame:CGRectMake(leftW, height, (screenW - leftW), 0.5)];
    twoDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.centerView addSubview:twoDividingLine];
    
    UILabel *newPwd = [[UILabel alloc]initWithFrame:CGRectMake(leftW, height, PwdW, height)];
    newPwd.text = @"新密码";
    newPwd.textColor = [UIColor colorWithHexString:@"666666"];
    newPwd.font = [UIFont systemFontOfSize:PwdFont];
    [self.centerView addSubview:newPwd];
   
    // 第三个分割线
    UIView *threeDividingLine = [[UIView alloc]initWithFrame:CGRectMake(leftW, height * 2, (screenW - leftW), 0.5)];
    threeDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.centerView addSubview:threeDividingLine];
    
    UILabel *confrimPwd = [[UILabel alloc]initWithFrame:CGRectMake(leftW, height * 2, PwdW , height)];
    confrimPwd.text = @"确认新密码";
    confrimPwd.font = [UIFont systemFontOfSize:PwdFont];
    confrimPwd.textColor = [UIColor colorWithHexString:@"666666"];
    [self.centerView addSubview:confrimPwd];
        // 第四个分割线
    UIView *fourDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, height * 3, screenW , 0.5)];
    fourDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.centerView addSubview:fourDividingLine];
    
    UITextField *currentPwdText = [[UITextField alloc]initWithFrame:CGRectMake(PwdW, 0, (screenW - PwdW), height)];
    currentPwdText.borderStyle = UITextBorderStyleNone;
    currentPwdText.placeholder = @"当前密码";
    currentPwdText.font = [UIFont systemFontOfSize:PwdFont];
    currentPwdText.textColor = [UIColor colorWithHexString:@"666666"];
    currentPwdText.secureTextEntry = YES;
    [self.centerView addSubview:currentPwdText];
    self.currentPwdText = currentPwdText;
    /***王朋***/
    self.currentPwdText.tintColor = [UIColor blackColor];
    
    UITextField *newPwdText = [[UITextField alloc]initWithFrame:CGRectMake(PwdW, height, (screenW - PwdW), height)];
    newPwdText.borderStyle = UITextBorderStyleNone;
    newPwdText.placeholder = @"新密码";
    newPwdText.font = [UIFont systemFontOfSize:PwdFont];
    newPwdText.textColor = [UIColor colorWithHexString:@"666666"];
    [self.centerView addSubview:newPwdText];
    self.newpwdText = newPwdText;
    /***王朋***/
    self.newpwdText.tintColor = [UIColor blackColor];
      newPwdText.secureTextEntry = YES;
    UITextField *confrimPwdText = [[UITextField alloc]initWithFrame:CGRectMake(PwdW, height * 2, (screenW - PwdW), height)];
    confrimPwdText.borderStyle = UITextBorderStyleNone;
//    confrimPwdText.borderStyle = UITextBorderStyleRoundedRect;
    confrimPwdText.textAlignment = UITextAlignmentLeft;
    confrimPwdText.placeholder = @"新密码";
    confrimPwdText.font = [UIFont systemFontOfSize:PwdFont];
    confrimPwdText.textColor = [UIColor colorWithHexString:@"666666"];
    [self.centerView addSubview:confrimPwdText];
    self.confrimPwdText = confrimPwdText;
    /***王朋***/
    self.confrimPwdText.tintColor = [UIColor blackColor];
    [confrimPwdText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        confrimPwdText.secureTextEntry = YES;
    UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(leftW, 3 * height + topH + 12, screenW, 20)];
    promptLable.text = @"密码由6-20位英文、数字或者字母组成";
    promptLable.font = [UIFont systemFontOfSize:9];
    promptLable.textColor = [UIColor colorWithHexString:@"999999"];
    [self.view addSubview:promptLable];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(leftW, 3 * height + topH + 36, screenW - leftW * 2, 41);
    finishBtn.layer.cornerRadius = 5;
    finishBtn.layer.masksToBounds = YES;
    
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"919191"]] forState:UIControlStateNormal];
    
    [finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"717171"]] forState:UIControlStateHighlighted];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
 
    [self.view addSubview:finishBtn];
    [finishBtn addTarget:self action:@selector(finishBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.finishBtn = finishBtn;
  
    
}


//监听输入框事件
-(void)textFieldDidChange:(UITextField*) TextField{
    
//    
//    if(![TextField.text isEqualToString:@""] && ![TextField.text isEqualToString:@""]){
//        
//        //        self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"d28000"];
////        self.loginBtn.userInteractionEnabled = YES;
//      
//        TextField.textColor = [UIColor colorWithHexString:@"666666"];
//    }else{
//        
//        TextField.textColor = [UIColor colorWithHexString:@"cccccc"];
//        //        self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"ff9c00"];
////        self.loginBtn.userInteractionEnabled = NO;
//    }
    
}
/** 完成按钮点击事件*/
- (void)finishBtnDidClick
{
 
    NSString *oldPwd = [CMData getPassword];
    NSString *newPwd = [NSString stringWithMD5EncodedString:self.newpwdText.text];
    NSString *oldPwd2 = [NSString stringWithMD5EncodedString:self.currentPwdText.text];
    NSString *newPwd2 = [NSString stringWithMD5EncodedString:self.confrimPwdText.text];
    NSLog(@"完成按钮点击");
    if([oldPwd2 isEqualToString:newPwd]){
        [SVProgressHUD showInfoWithStatus:@"新密码不能与旧密码相同"];
    }else if(![newPwd isEqualToString:newPwd2])
    {
           [SVProgressHUD showInfoWithStatus:@"新密码与确认密码不相同"];
    }
    else if(![oldPwd2 isEqualToString:oldPwd]){
        [SVProgressHUD showInfoWithStatus:@"旧密码不正确"];
        
    }else if([self.newpwdText.text length] <6  || [self.currentPwdText.text length] <6 ){
        [SVProgressHUD showInfoWithStatus:@"密码不能少于6位"];
        
    }else if([self.newpwdText.text length] >20  || [self.currentPwdText.text length] >20 ){
        [SVProgressHUD showInfoWithStatus:@"密码不能超过20位"];
        
    }else{
        if(![CMTool isConnectionAvailable]){
            
            [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        }else{
        //请求验证
        PyResetValueKey *p=[PyResetValueKey alloc];
        NSMutableArray *settings=[[NSMutableArray alloc] init];
        p=[p initNewkey:@"result" OldKey:@"result"];
        [settings addObject:p];
        
        NSDictionary *param=@{
                              @"token":[CMData getToken],
                              @"newPwd":newPwd,
                              @"oldPwd":oldPwd};
           NSLog(@"%@",param);
        [CMAPI getUrl:API_USER_UPDATE Param:param Settings:settings completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            NSString* result=@"";
         
            if(succeed)
            {
                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                [userDefaults setValue:[NSString stringWithMD5EncodedString:newPwd] forKey:@"pwd"];
                //弹出提示成功
                result=@"修改密码成功";
                
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil
                                                               message:result
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                
                [alert show];
             
                
            }
            else
            {
                //如果失败，弹出提示
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result]; ;
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
                
            }
            
            
            
        }];
        }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
           [self changePwdLogout];
    }
}
- (void)changePwdLogout{
    
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
              NSString *newPwd = [NSString stringWithMD5EncodedString:self.newpwdText.text];
            [CMData setPassword:newPwd];
            [CMData setToken: @""];
            [CMData setUserName:@""];
            [CMData setUserId:@""];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCEL_LOGOUT" object:nil];
            
            [self noLogin];
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
@end
