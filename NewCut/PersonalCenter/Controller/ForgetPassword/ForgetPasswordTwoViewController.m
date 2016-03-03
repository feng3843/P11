//
//  ForgetPasswordTwoViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/25.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ForgetPasswordTwoViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "NSString+Extensions.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CMAPI.h"
#import "CMData.h"
#import "SVProgressHUD.h"
#import "DataBaseTool.h"
#import "ForgetPasswordThreeViewController.h"
@interface ForgetPasswordTwoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeText;
- (IBAction)nextBtnClick;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)getCodeClick;
@property (weak, nonatomic) IBOutlet UILabel *promLable;

@property(nonatomic ,assign)BOOL isSendCode;
@property(nonatomic,assign)BOOL isVerifyCodeSuccess;
@end

@implementation ForgetPasswordTwoViewController

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
    UIButton *back  = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [back setImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /****王朋***/
    self.checkCodeText.tintColor = [UIColor whiteColor];
    
    self.promLable.text = [NSString stringWithFormat:@"请输入%@****%@收到的短信校验码",[self.phone SubsLeft:3],[self.phone SubsRight:4]];
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_2.png"];
    [self.view insertSubview:bgImage atIndex:0];
    
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dbdbdb"]] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b6b6b6"]] forState:UIControlStateHighlighted];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.masksToBounds = YES;
    [self.nextBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];
    [self startTime];
    self.isVerifyCodeSuccess = YES;
}

- (void)hidKeyborad:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize :13] ;
                self.getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
           
                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize :13] ;
                [self.getCodeBtn setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
                
                self.getCodeBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

//获取验证码
-(void)getIdentifyCode{
    
    NSString *tel = self.phone;
    NSString *message=[NSString stringWithFormat:@"%@****%@",[tel SubsLeft:3],[tel SubsRight:4]];
    NSString *string1 = @"请输入";
    NSString *string2 = @"收到的短信验证码";
    NSString *alert1 = [string1 stringByAppendingString:message];
    NSString *alert2 = [alert1 stringByAppendingString:string2];
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:tel zone:@"86" result:^(SMS_SDKError *error) {
        if(!error){
            self.isSendCode = YES;
            //            showMessageCheckIdentify(@"提示！", alert2);
            
            
        }else{
            self.isSendCode = NO;
            forgetPasswordshowMessageCheckIdentify(@"提示！", @"发送失败，请重新获取！");
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
            self.isVerifyCodeSuccess = YES;
            //            [self.navigationController pushViewController:setPasswordView animated:YES];
              UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ForgetPasswordThreeViewController *vc = [registerView instantiateViewControllerWithIdentifier:@"forgetPasswordThree"];
             vc.title = @"忘记密码";
             vc.phone = self.phone;
            [self.navigationController pushViewController:vc animated:YES];
            //
            
            return ;
        }else if(state==0){
            self.isVerifyCodeSuccess = NO;
            forgetPasswordshowMessageCheckIdentify(@"提示！", @"验证失败！");
            
            return;
        }
    }];
    
}
//提示框
int forgetPasswordshowMessageCheckIdentify(NSString *title,NSString* message){
    
    UIAlertView *Alert = [[UIAlertView alloc]
                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Alert show];
    return 1;
}


- (IBAction)nextBtnClick {
    [self CommitIdentifyCode];
}
- (IBAction)getCodeClick {
    [self getIdentifyCode];
}
@end
