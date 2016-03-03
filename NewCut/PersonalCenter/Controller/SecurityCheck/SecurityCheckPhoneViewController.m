//
//  SecurityCheckPhoneViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "SecurityCheckPhoneViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "CMTool.h"
#import "CMData.h"
#import "SVProgressHUD.h"
#import "SecurityCheckViewController.h"
#import "NSString+Extensions.h"
#import <SMS_SDK/SMS_SDK.h>
#import "DataBaseTool.h"
@interface SecurityCheckPhoneViewController ()

@property(nonatomic ,weak)UIButton *nextBtn;

@property(nonatomic ,weak)UITextField *checkCodeText;
@property(nonatomic ,assign)BOOL isSendCode;
@end

@implementation SecurityCheckPhoneViewController

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdgeNone;
    if ([CMData getLoginType]) {
        [SVProgressHUD showInfoWithStatus:@"第三方登录不能修改手机号"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    }
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    self.navigationController.navigationBar.translucent = NO;
    

    // 设置控件
    [self setupView];
    self.title = @"修改手机号";
    // 设置按钮不可以点击
    self.nextBtn.enabled = NO;
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
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    int topH = 0;
    UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 25 + topH, screenW - 16, 11)];
    promptLable.text = @"请输入你需要绑定的新手机号";
    promptLable.textColor = [UIColor colorWithHexString:@"999999"];
    promptLable.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:promptLable];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 46 + topH, screenW, 44)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:bgView];
    
    // 第一个分割线
    UIView *oneDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    oneDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [bgView addSubview:oneDividingLine];
    
    UILabel *checkCodeLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 68, 44)];
    checkCodeLable.text = @"新手机号";
    checkCodeLable.textColor = [UIColor colorWithHexString:@"666666"];
    checkCodeLable.font = [UIFont systemFontOfSize:13];
    
    [bgView addSubview:checkCodeLable];
    
    UITextField *checkCodeText = [[UITextField alloc]initWithFrame:CGRectMake(95, 0, screenW - 95 , 44)];
    checkCodeText.placeholder = @"请输入手机号";
    checkCodeText.font = [UIFont systemFontOfSize:13];
    checkCodeText.textColor = [UIColor colorWithHexString:@"666666"];
    
    [checkCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:checkCodeText];
    self.checkCodeText = checkCodeText;
    /***王朋***/
    self.checkCodeText.tintColor = [UIColor blackColor];
    
    checkCodeText.keyboardType = UIKeyboardTypeNumberPad;
     // 第二个分割线
    UIView *twoDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44, screenW, 0.5)];
    twoDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [bgView addSubview:twoDividingLine];
    
    CGFloat nextBtnY = CGRectGetMaxY(bgView.frame) + 18;
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(16, nextBtnY, screenW - 16 * 2, 41);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.layer.masksToBounds = YES;
    self.nextBtn = nextBtn;
   [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"919191"]] forState:UIControlStateNormal];
    
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"717171"]] forState:UIControlStateHighlighted];
    
    [nextBtn addTarget:self action:@selector(nextBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidChange:(UITextField*) TextField{
    NSString* checkCodeText=self.checkCodeText.text;
    if(checkCodeText.length>0&&[CMTool validateTel:checkCodeText])//这里进行手机号判断
    {
        if([checkCodeText isEqualToString:[DataBaseTool getUserPhone]])
        {
            //弹出提示
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
            [SVProgressHUD setInfoImage:nil];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD showInfoWithStatus:@"手机号码不能与当前号码相同!"];
        }
        else
        {
            self.nextBtn.enabled=YES;
        }
    }
    else
    {
        self.nextBtn.enabled=NO;
    }
}

- (void)nextBtnDidClick
{
    [self getIdentifyCode];
    
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
//            showMessageIdentify(@"提示！", alert2);
            SecurityCheckViewController *vc = [[SecurityCheckViewController alloc]init];
            vc.phone = self.checkCodeText.text;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            self.isSendCode = NO;
            showMessageIdentify(@"提示！", @"发送失败，请重新获取！");
        }
    }];
    

}

//提示框
int showMessageIdentify(NSString *title,NSString* message){
    
    UIAlertView *Alert = [[UIAlertView alloc]
                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Alert show];
    return 1;
}


@end
