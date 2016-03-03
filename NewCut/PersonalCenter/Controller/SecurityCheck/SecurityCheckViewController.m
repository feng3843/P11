//
//  SecurityCheckViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/16.
//  Copyright (c) 2015年 py. All rights reserved.
//  安全校验

#import "SecurityCheckViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "NSString+Extensions.h"
#import <SMS_SDK/SMS_SDK.h>
#import "CMAPI.h"
#import "CMData.h"
#import "SVProgressHUD.h"
#import "DataBaseTool.h"

#import "ContactsNavViewController.h"
#import "PYAllCommon.h"

@interface SecurityCheckViewController ()

@property(nonatomic ,weak)UIButton *nextBtn;

/** 输入的验证码*/
@property(nonatomic ,weak)UITextField *checkCodeText;
/** 提示框*/
@property(nonatomic ,weak)UILabel *promptLable;

@property(nonatomic ,weak)UIButton *getCodeBtn;
@property(nonatomic ,assign)BOOL isSendCode;
@property(nonatomic,assign)BOOL isVerifyCodeSuccess;
@end

@implementation SecurityCheckViewController

//@synthesize checkIdentifyCode;

- (void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 设置控件
    [self setupView];
    self.title = @"修改手机号";
    
    /***王朋****/
    self.checkCodeText.tintColor = [UIColor blackColor];
    
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
/** 设置View*/
- (void)setupView
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    int topH = 0;
    UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 25 + topH, screenW - 16, 11)];
    
    promptLable.text = [NSString stringWithFormat:@"请输入%@****%@收到的短信校验码",[self.phone SubsLeft:3],[self.phone SubsRight:4]];
    promptLable.textColor = [UIColor colorWithHexString:@"999999"];
    promptLable.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:promptLable];
    self.promptLable = promptLable;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 46 + topH, screenW, 44)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:bgView];
    
    // 第一个分割线
    UIView *oneDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenW, 0.5)];
    oneDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [bgView addSubview:oneDividingLine];
    
    UILabel *checkCodeLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 68, 44)];
    checkCodeLable.text = @"校验码";
    checkCodeLable.textColor = [UIColor colorWithHexString:@"666666"];
    checkCodeLable.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:checkCodeLable];
    
    UITextField *checkCodeText = [[UITextField alloc]initWithFrame:CGRectMake(68, 0, screenW - 89 - 68, 44)];
    checkCodeText.placeholder = @"短信校验码";
    checkCodeText.font = [UIFont systemFontOfSize:13];
    checkCodeText.textColor = [UIColor colorWithHexString:@"cccccc"];
    [checkCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:checkCodeText];
    self.checkCodeText = checkCodeText;
    checkCodeText.keyboardType = UIKeyboardTypePhonePad;

    UIView *middleDividingLine = [[UIView alloc]initWithFrame:CGRectMake(screenW - 89, (44 - 13)* 0.5, 1, 13)];
    middleDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [bgView addSubview:middleDividingLine];
    
    CGFloat getCodeBtnX = CGRectGetMaxX(middleDividingLine.frame);
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.frame = CGRectMake(getCodeBtnX, 0, 89 - 16, 44);
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize :13] ;
    [getCodeBtn setTitleColor:[UIColor colorWithHexString:@"cccccc"] forState:UIControlStateNormal];
//    [getCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
   [getCodeBtn setTitle:@"50秒后重发" forState:UIControlStateNormal];
    getCodeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.getCodeBtn = getCodeBtn;
    [self.getCodeBtn addTarget:self action:@selector(getIdentifyCode) forControlEvents:UIControlEventTouchUpInside];
//    self.getCodeBtn.userInteractionEnabled = NO;
    [bgView addSubview:getCodeBtn];
    
    // 第二个分割线
    UIView *twoDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44, screenW, 0.5)];
    twoDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [bgView addSubview:twoDividingLine];
    
    CGFloat nextBtnY = CGRectGetMaxY(bgView.frame) + 18;
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(16, nextBtnY, screenW - 16 * 2, 41);
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.layer.masksToBounds = YES;
    self.nextBtn = nextBtn;
   
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"919191"]] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"717171"]] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(CommitIdentifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextBtn];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidChange:(UITextField*) TextField{
    
    if(![TextField.text isEqualToString:@""]){
        
        self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"184ca2"];
        self.nextBtn.userInteractionEnabled = YES;
    }else{
        
        self.nextBtn.backgroundColor = [UIColor grayColor];
        self.nextBtn.userInteractionEnabled = NO;
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
                [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize :13] ;
                self.getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
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
            showMessageCheckIdentify(@"提示！", @"发送失败，请重新获取！");
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
           [self changePhone];
            return ;
        }else if(state==0){
            self.isVerifyCodeSuccess = NO;
            showMessageCheckIdentify(@"提示！", @"验证失败！");
            
            return;
        }
    }];
    
}
//提示框
int showMessageCheckIdentify(NSString *title,NSString* message){
    
    UIAlertView *Alert = [[UIAlertView alloc]
                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [Alert show];
    return 1;
}

/** 远程服务器改手机号*/
- (void)changePhone
{
   
    NSString *token = [CMData getToken];
   NSDictionary *param = @{@"token":token,
                            @"newTel":self.phone
                            };
    NSLog(@"%@",param);
    [CMAPI postUrl:API_USER_UNWRAPTEL Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        //        //do something
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCEL_LOADING" object:nil];
        
        id result = [detailDict objectForKey:@"code"];
        if(succeed)
        {
            [CMData setUserName:self.phone];
            [DataBaseTool updateUserPhone];
             showMessageCheckIdentify(@"提示！", @"修改手机号成功！");
            [self logout];
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
            [SVProgressHUD showInfoWithStatus:@"手机号修改不成功！"];
            [CMData setToken: @""];
            
            
        }
    }];
    
}

- (void)logout{
    
    
    NSString *token = [CMData getToken];
    
    NSDictionary *param = @{@"token":token
                            };
    NSLog(@"%@",param);
    [CMAPI postUrl:API_USER_LOGOUT Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
        //        //do something
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"CANCEL_LOADING" object:nil];
        
        id result = [detailDict objectForKey:@"code"];
        if(succeed)
        {
//            [SVProgressHUD showInfoWithStatus:@"退出成功！"];
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
@end
