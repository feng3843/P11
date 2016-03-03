//
//  ForgetPasswordOneViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/25.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ForgetPasswordOneViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "NSString+Extensions.h"
#import <SMS_SDK/SMS_SDK.h>
#import "SVProgressHUD.h"
#import "ForgetPasswordTwoViewController.h"
#import "MenuTabBarViewController.h"
#import "RegisterTwoViewController.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "PYAllCommon.h"

@interface ForgetPasswordOneViewController ()
- (IBAction)nextBtnClick;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeText;
@property(nonatomic ,assign)BOOL isSendCode;
@end

@implementation ForgetPasswordOneViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIImage *image = [UIImage imageNamed:@"bg.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:image
     
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:image];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        self.navigationController.navigationBar.translucent = YES;
    UIImage *image = [UIImage imageNamed:@"bg.png"];
    
    [self.navigationController.navigationBar setBackgroundImage:image
     
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:image];
    UIButton *back  = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [back setImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /***王朋****/
    self.checkCodeText.tintColor = [UIColor whiteColor];

    self.nextBtn.enabled = NO;
    self.title = @"忘记密码";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor],UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};
   [self.checkCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Do any additional setup after loading the view.
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_2.png"];
    [self.view insertSubview:bgImage atIndex:0];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dbdbdb"]] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b6b6b6"]] forState:UIControlStateHighlighted];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.masksToBounds = YES;
   [self.nextBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
//    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];

//    
//    UILabel *titleLable = [[UILabel alloc]init];
//    titleLable.font = [UIFont boldSystemFontOfSize:14];
//    titleLable.textColor = [ UIColor colorWithHexString:@"dfdfdf"];
//     titleLable.text = @"忘记密码";
//    titleLable.frame = CGRectMake(0, 0, 60, 14);
//    self.navigationItem.titleView = titleLable;

//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//   [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    closeBtn.frame = CGRectMake(0, 0, 35, 35);
//    [closeBtn setBackgroundImage:[UIImage imageNamed:@"backsmall"] forState:UIControlStateNormal];
//    UIBarButtonItem *CloseItem = [[UIBarButtonItem alloc]initWithCustomView:closeBtn];
//    
//    self.navigationItem.leftBarButtonItem = CloseItem;
    
//    UIImage *image = [UIImage imageNamed:@"bg.png"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:image];
    self.navigationController.navigationBarHidden = NO;

}


-(void)textFieldDidChange:(UITextField*) TextField{
    NSString* checkCodeText=self.checkCodeText.text;
    if(checkCodeText.length>0&&[CMTool validateTel:checkCodeText])//这里进行手机号判断
    {
     self.nextBtn.enabled=YES;
     
    }
    else
    {
        self.nextBtn.enabled=NO;
    }
}
- (void)closeBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)hidKeyborad:(id)sender {
    [self.view endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextBtnClick {
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"tel"] = self.checkCodeText.text;
    [CMAPI postUrl:API_USER_IS_REG Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        id result = [detailDict objectForKey:@"code"];
        if(succeed){
            //如果失败，弹出提示
            //                self.LoadingView.hidden = YES;
            NSDictionary *dic=[detailDict valueForKey:@"result"];
            if(!!dic&&dic.count>0)
                result=[dic valueForKey:@"reason"];
            result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
            [SVProgressHUD setInfoImage:nil];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:@"此手机号没有注册过！"];
            
            return;
         
            
        }else{
            
           [self getIdentifyCode];
            
        }
    }];
    }

    
}

//获取验证码
-(void)getIdentifyCode{
    
    NSString *tel = self.checkCodeText.text;
    NSString *message=[NSString stringWithFormat:@"%@****%@",[tel SubsLeft:3],[tel SubsRight:4]];
    NSString *string1 = @"请输入";
    NSString *string2 = @"收到的短信验证码";
    NSString *alert1 = [string1 stringByAppendingString:message];
    NSString *alert2 = [alert1 stringByAppendingString:string2];
    
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:tel zone:@"86" result:^(SMS_SDKError *error) {
        if(!error){
            self.isSendCode = YES;
          //  forgetPasswordShowMessageIdentify(@"提示！", alert2);
            UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ForgetPasswordTwoViewController *vc = [registerView instantiateViewControllerWithIdentifier:@"forgetPasswordTwo"];
            vc.phone = self.checkCodeText.text;
            
             vc.title = @"忘记密码";
        /*****王朋****将忘记密码文字修改颜色和更改字体*/

            
            [self.navigationController pushViewController:vc animated:YES];

            
            
        }else{
            self.isSendCode = NO;
            forgetPasswordShowMessageIdentify(@"提示！", @"发送失败，请重新获取！");
        }
    }];
    
    
}

//提示框
int forgetPasswordShowMessageIdentify(NSString *title,NSString* message){
    
    UIAlertView *Alert = [[UIAlertView alloc]
                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Alert show];
    return 1;
}

@end
