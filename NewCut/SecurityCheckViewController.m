//
//  SecurityCheckViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/16.
//  Copyright (c) 2015年 py. All rights reserved.
//  安全校验

#import "SecurityCheckViewController.h"
#import "UIColor+Extensions.h"
@interface SecurityCheckViewController ()

@property(nonatomic ,weak)UIButton *nextBtn;
@end

@implementation SecurityCheckViewController

//@synthesize checkIdentifyCode;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    // 设置控件
    [self setupView];
    self.title = @"安全校验";
    
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
    int topH = 64;
    UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(16, 25 + topH, screenW - 16, 11)];
    promptLable.text = @"请输入134***6756收到的短信校验码";
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
    
    UIView *middleDividingLine = [[UIView alloc]initWithFrame:CGRectMake(screenW - 89, (44 - 13)* 0.5, 1, 13)];
    middleDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [bgView addSubview:middleDividingLine];
    
    CGFloat repeatX = CGRectGetMaxX(middleDividingLine.frame);
    UILabel *repeatLable = [[UILabel alloc]initWithFrame:CGRectMake(repeatX, 0, 89 - 16, 44)];
    repeatLable.text = @"50秒后重发";
    repeatLable.font = [UIFont systemFontOfSize:13];
    repeatLable.textColor = [UIColor colorWithHexString:@"cccccc"];
    repeatLable.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:repeatLable];
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
    nextBtn.backgroundColor = [UIColor colorWithHexString:@"ff9c00"];
//    [nextBtn addTarget:self action:@selector(getIdentifyCode) forControlEvents:UIControlEventTouchUpInside];
    
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

////验证码有效时间
//-(void)startTime{
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
//    __block int timeout = 50; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize :w *15/414] ;
//                self.getCodeBtn.userInteractionEnabled = YES;
//            });
//        }else{
//            
//            int seconds = timeout;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
//                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
//                self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize :w *15/414] ;
//                self.getCodeBtn.userInteractionEnabled = NO;
//                
//            });
//            timeout--;
//            
//        }
//    });
//    dispatch_resume(_timer);
//    
//}
//
//- (void)setUpForDismissKeyboard {
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//    UITapGestureRecognizer *singleTapGR =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(tapAnywhereToDismissKeyboard:)];
//    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
//    [nc addObserverForName:UIKeyboardWillShowNotification
//                    object:nil
//                     queue:mainQuene
//                usingBlock:^(NSNotification *note){
//                    [self.view addGestureRecognizer:singleTapGR];
//                }];
//    [nc addObserverForName:UIKeyboardWillHideNotification
//                    object:nil
//                     queue:mainQuene
//                usingBlock:^(NSNotification *note){
//                    [self.view removeGestureRecognizer:singleTapGR];
//                }];
//}
//
//- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
//    //此method会将self.view里所有的subview的first responder都resign掉
//    [self.view endEditing:YES];
//}
//
//
////获取验证码
//-(void)getIdentifyCode{
//    
//    NSString *tel = self.strTel;
//    NSString *message=[NSString stringWithFormat:@"%@****%@",[tel SubsLeft:3],[tel SubsRight:4]];
//    NSString *string1 = @"请输入";
//    NSString *string2 = @"收到的短信验证码";
//    NSString *alert1 = [string1 stringByAppendingString:message];
//    NSString *alert2 = [alert1 stringByAppendingString:string2];
//    
//    [SMS_SDK getVerificationCodeBySMSWithPhone:tel zone:@"86" result:^(SMS_SDKError *error) {
//        if(!error){
//            self.isSendCode = YES;
//            showMessageIdentify(@"提示！", alert2);
//            
//        }else{
//            self.isSendCode = NO;
//            showMessageIdentify(@"提示！", @"发送失败，请重新获取！");
//        }
//    }];
//    
//    [self startTime];
//    
//}
//
////提示框
//int showMessageIdentify(NSString *title,NSString* message){
//    
//    UIAlertView *Alert = [[UIAlertView alloc]
//                          initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [Alert show];
//    return 1;
//}
//
//
//-(void)gotoGestureView{
//    // UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    // gesPasswordView = [registerView instantiateViewControllerWithIdentifier:@"GestureCodeViewId"];
//    
//    self.btnOK.backgroundColor = [UIColor colorWithHexString:@"184ca2"];
//    self.btnOK.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//    NSString *IdentifyCode = self.codeText.text;
//    gestureView = [[MJViewController alloc] init];
//    gestureView.strTel = self.strTel;
//    // forgetView = [[ForgetMJPasswordViewController alloc] init];
//    //forgetView.strTel = self.strTel;
//    NSString *userName = self.strTel;
//    
//    NSString *passWord = self.password;
//    
//    NSDictionary *params = @{@"tel":userName,
//                             @"password":passWord
//                             };
//    
//    //    [CMAPI postUrl:API_REGISTER Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//    //        id result = [detailDict objectForKey:@"code"];
//    //        NSString* strCode = [NSString stringWithFormat:@"%@",result];
//    //        self.LoadingView.hidden = NO;
//    //        if(succeed){
//    //
//    //            [SVProgressHUD showInfoWithStatus:@"注册成功！"];
//    //            [self.navigationController pushViewController:gestureView animated:YES];
//    //            gestureView.title = @"绘制手势密码";
//    //            self.LoadingView.hidden = YES;
//    //            return ;
//    //
//    //        }else{
//    //            self.LoadingView.hidden = YES;
//    //            NSDictionary *dic=[detailDict valueForKey:@"result"];
//    //            if(!!dic&&dic.count>0)
//    //                result=[dic valueForKey:@"reason"];
//    //
//    //            result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//    //
//    //            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    //            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//    //            [SVProgressHUD setInfoImage:nil];
//    //            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    //            [SVProgressHUD showInfoWithStatus: result];
//    //
//    //        }
//    //    }];
//    
//    //[self.navigationController pushViewController:gestureView animated:YES];
//    //gestureView = [registerView instantiateViewControllerWithIdentifier:@"IdentifyCode"];
//    if(IdentifyCode.length!=4){
//        showMessageIdentify(@"提示！", @"验证码为4位！");
//        return;
//    }else{
//        [SMS_SDK commitVerifyCode:IdentifyCode result:^(enum SMS_ResponseState state) {
//            if(state==1){
//                self.isVerifyCodeSuccess = YES;
//                [SVProgressHUD showInfoWithStatus:@"验证成功！"];
//                [CMAPI postUrl:API_REGISTER Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//                    id result = [detailDict objectForKey:@"code"];
//                    NSString* strCode = [NSString stringWithFormat:@"%@",result];
//                    
//                    if(succeed){
//                        
//                        [SVProgressHUD showInfoWithStatus:@"注册成功！"];
//                        [self.navigationController pushViewController:gestureView animated:YES];
//                        gestureView.title = @"绘制手势密码";
//                        return ;
//                        
//                    }else{
//                        NSDictionary *dic=[detailDict valueForKey:@"result"];
//                        if(!!dic&&dic.count>0)
//                            result=[dic valueForKey:@"reason"];
//                        
//                        result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                        
//                        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                        [SVProgressHUD setInfoImage:nil];
//                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                        [SVProgressHUD showInfoWithStatus:result];
//                        
//                    }
//                }];
//                return ;
//                
//            }else if (state==0){
//                self.isVerifyCodeSuccess = NO;
//                [SVProgressHUD showInfoWithStatus:@"验证失败！"];
//            }
//        }];
//        
//    }
//    
//}

@end
