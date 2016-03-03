//
//  RegisterViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "SVProgressHUD.h"
#import "RegisterTwoViewController.h"
#import "CMTool.h"
#import "NSString+Extensions.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CMAPI.h"
//#import "HttpRequest.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confrimPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtnClick;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
//    bgImage.image = [UIImage imageNamed:@"bg_me.png"];
//    [self.view insertSubview:bgImage atIndex:0];
        self.view.backgroundColor = [UIColor clearColor];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dbdbdb"]] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b6b6b6"]] forState:UIControlStateHighlighted];
    [self.nextBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.masksToBounds = YES;
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.pwdTextField.secureTextEntry = YES;
    self.confrimPwdTextField.secureTextEntry = YES;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    /***王朋****鼠标定位光标颜色*/
    self.phoneTextField.tintColor = [UIColor whiteColor];
    self.pwdTextField.tintColor = [UIColor whiteColor];
    self.confrimPwdTextField.tintColor = [UIColor whiteColor];
    
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextBtnClick {
    

    NSString *userName = self.phoneTextField.text;
    NSString *passWord = self.pwdTextField.text;
    NSString *repassWord = self.confrimPwdTextField.text;
 
//    self.LoadingView.hidden = NO;
//    [self.RegisterName becomeFirstResponder];//获取焦点弹出键盘
    if([userName isEqualToString:@""] || ![CMTool validateTel:userName]){
        [SVProgressHUD showInfoWithStatus:@"请输入有效的手机号！"];
        // [self.navigationController pushViewController:identifyView animated:YES];
//        self.LoadingView.hidden = YES;
        return;
        
    }else if ([passWord isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入密码！"];
//        self.LoadingView.hidden = YES;
        return;
        
    }else if (passWord.length < 6 || repassWord.length < 6){
        [SVProgressHUD showInfoWithStatus:@"密码至少为6位！"];
//        self.LoadingView.hidden = YES;
        return;
        
    }else if (![passWord isEqualToString:repassWord]){
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致！"];
//        self.LoadingView.hidden = YES;
        return;
    }else{
        if(![CMTool isConnectionAvailable]){
            
            [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
        }else{
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"tel"] = self.phoneTextField.text;
        
        [CMAPI postUrl:API_USER_IS_REG Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            id result = [detailDict objectForKey:@"code"];
        if(succeed){
             
            [self getIdentifyCode];
            
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
        }
    }
}

//获取验证码
-(void)getIdentifyCode{
    
    NSString *tel = self.phoneTextField.text;
    NSString *message=[NSString stringWithFormat:@"%@****%@",[tel SubsLeft:3],[tel SubsRight:4]];
    NSString *string1 = @"请输入";
    NSString *string2 = @"收到的短信验证码";
    NSString *alert1 = [string1 stringByAppendingString:message];
    NSString *alert2 = [alert1 stringByAppendingString:string2];
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:tel zone:@"86" result:^(SMS_SDKError *error) {
        if(!error){
            
            UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            RegisterTwoViewController *identifyView = [registerView instantiateViewControllerWithIdentifier:@"registerTwoId"];
            identifyView.tel =  self.phoneTextField.text;
            identifyView.password = self.pwdTextField.text;
            [self.navigationController pushViewController:identifyView animated:YES];
        }else{
       RegisterViewShowMessageIdentify(@"提示！", @"发送失败，请重新获取！");
        }
    }];
    
    
}

//提示框
int RegisterViewShowMessageIdentify(NSString *title,NSString* message){
    
    UIAlertView *Alert = [[UIAlertView alloc]
                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Alert show];
    return 1;
}

@end
