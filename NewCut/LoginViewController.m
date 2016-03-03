//
//  LoginViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;


- (IBAction)loginBtnDidClick;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_log in.png"];
    [self.view insertSubview:bgImage atIndex:0];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ff9c00"]] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"d28000"]] forState:UIControlStateHighlighted];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    // 添加手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidKeyborad:)];
    [self.view addGestureRecognizer:tapGesture];
    [self.PwdTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)hidKeyborad:(id)sender {
    [self.view endEditing:YES];
}
//监听输入框事件
-(void)textFieldDidChange:(UITextField*) TextField{
    
   
    if(![self.phoneTextField.text isEqualToString:@""] && ![self.PwdTextField.text isEqualToString:@""]){
        
//        self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"d28000"];
        self.loginBtn.userInteractionEnabled = YES;
    }else{
        
//        self.loginBtn.backgroundColor = [UIColor colorWithHexString:@"ff9c00"];
        self.loginBtn.userInteractionEnabled = NO;
    }
    
}
//限制输入框的内容的大小
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [self.phoneTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneTextField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
//            [SVProgressHUD showInfoWithStatus:@"手机号最多11位！"];
            
            return NO;
        }
    }
    return YES;
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

- (IBAction)loginBtnDidClick {
}
@end
