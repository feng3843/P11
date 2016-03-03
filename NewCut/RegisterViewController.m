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
//#import "CMTool.h"
#import "SVProgressHUD.h"

#import "MD5.h"
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
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_log in.png"];
    [self.view insertSubview:bgImage atIndex:0];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ff9c00"]] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"d28000"]] forState:UIControlStateHighlighted];
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.layer.masksToBounds = YES;
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];
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
    NSLog(@"%@",userName);
    NSString *passWord = self.pwdTextField.text;
    NSString *repassWord = self.confrimPwdTextField.text;

    
    
//    UIStoryboard *registerView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    identifyView = [registerView instantiateViewControllerWithIdentifier:@"IdentifyCode"];
//    self.LoadingView.hidden = NO;
    //[self.RegisterName becomeFirstResponder];//获取焦点弹出键盘
//    if([userName isEqualToString:@""] || ![CMTool validateTel:userName]){
        if([userName isEqualToString:@""] ){
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
        
//        NSDictionary *param = @{@"tel":userName};
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"Username"] = userName;
        param[@"tel"] = userName;
        param[@"password"] = [NSString stringWithMD5EncodedString:passWord];
        param[@"nickName"] = @"";
        param[@"userImage"] = @"";
        param[@"regDate"] = [NSDate date];
        NSLog(@"%@",param);
//        [HttpRequest postUrl:API_USER_ISEXIST Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error)
//        [HttpRequest post:@""  params:param success:^(id responseObj) {
//            id result = [responseObj objectForKey:@"code"];
//            NSString *strCode =  [NSString stringWithFormat:@"%@",result];
//            NSLog(@"%@",strCode);
//            [SVProgressHUD showInfoWithStatus:@"验证成功！"];
//            //                [self.navigationController pushViewController:identifyView animated:YES];
//            ////                identifyView.strTel = userName;
//            ////                identifyView.password = passWord;
//            return ;
//            
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
////            NSDictionary *dic=[detailDict valueForKey:@"result"];
////            if(!!dic&&dic.count>0)
////                result=[dic valueForKey:@"reason"];
////            
////            result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
////            
////            NSString *message ;
////            if([result isEqualToString:@"4012"]){
////                message = @"此手机号已被注册！";
////            }
////            
////            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
////            [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
////            [SVProgressHUD setInfoImage:nil];
////            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
////            [SVProgressHUD showInfoWithStatus:@"此手机号已被注册！"];
//            
//            return;
//            
//            
//        }];
    }
    
    
}
@end
