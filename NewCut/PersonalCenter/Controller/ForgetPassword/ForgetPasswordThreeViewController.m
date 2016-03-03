//
//  ForgetPasswordThreeViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/27.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ForgetPasswordThreeViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
#import "CMData.h"
#import "CMAPI.h"
#import "SVProgressHUD.h"
#import "MD5.h"
#import "CMTool.h"

#import "PYAllCommon.h"

@interface ForgetPasswordThreeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
/** 新密码*/
@property(nonatomic ,weak) IBOutlet UITextField *newpwdText;
/** 确认密码*/
@property(nonatomic ,weak)IBOutlet UITextField *confrimPwdText;
- (IBAction)finishBtnClick;

@end

@implementation ForgetPasswordThreeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIButton *back  = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [back setImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /****王朋***/
    self.newpwdText.tintColor = [UIColor whiteColor];
    self.confrimPwdText.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_2.png"];
    [self.view insertSubview:bgImage atIndex:0];
    
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dbdbdb"]] forState:UIControlStateNormal];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"b6b6b6"]] forState:UIControlStateHighlighted];
    self.finishBtn.layer.cornerRadius = 5;
    self.finishBtn.layer.masksToBounds = YES;
    [self.finishBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
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

- (IBAction)finishBtnClick {
    [self.view endEditing:YES];
    
    NSString *newPwd = [NSString stringWithMD5EncodedString:self.newpwdText.text];
    NSString *confirmPwd = [NSString stringWithMD5EncodedString:self.confrimPwdText.text];
    if(![newPwd isEqualToString:confirmPwd]){
        [SVProgressHUD showInfoWithStatus:@"新密码与确认密码不相同"];
    }else if([self.newpwdText.text length] <6   ){
        [SVProgressHUD showInfoWithStatus:@"密码不能少于6位"];
        
    }else if([self.newpwdText.text length] >20 ){
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
                              @"tel":self.phone,
                              @"newPwd":newPwd,
                               };
     
        [CMAPI getUrl:API_USER_RESETPWD Param:param Settings:settings completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            NSString* result=@"";
            
            if(succeed)
            {
                NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                [userDefaults setValue:[NSString stringWithMD5EncodedString:newPwd] forKey:@"pwd"];
                //弹出提示成功
                result=@"密码重置成功";
                
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
