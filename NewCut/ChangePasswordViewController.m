//
//  ChangePasswordViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/15.
//  Copyright (c) 2015年 py. All rights reserved.
//  重置登录密码

#import "ChangePasswordViewController.h"
#import "UIColor+Extensions.h"

@interface ChangePasswordViewController ()

@property(nonatomic ,weak)UIView *centerView;
@end

@implementation ChangePasswordViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    // 设置控件
    [self setupView];
    
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
    int PwdFont = 13;
    int screenW = [UIScreen mainScreen].bounds.size.width;
    // 密码lable的宽度
    int PwdW = 95;
    int height = 44;
    int topH = 18 + 64;
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
    currentPwdText.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self.centerView addSubview:currentPwdText];
    
    UITextField *newPwdText = [[UITextField alloc]initWithFrame:CGRectMake(PwdW, height, (screenW - PwdW), height)];
    newPwdText.borderStyle = UITextBorderStyleNone;
    newPwdText.placeholder = @"新密码";
    newPwdText.font = [UIFont systemFontOfSize:PwdFont];
    newPwdText.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self.centerView addSubview:newPwdText];
    
    UITextField *confrimPwdText = [[UITextField alloc]initWithFrame:CGRectMake(PwdW, height * 2, (screenW - PwdW), height)];
    confrimPwdText.borderStyle = UITextBorderStyleNone;
    confrimPwdText.placeholder = @"新密码";
    confrimPwdText.font = [UIFont systemFontOfSize:PwdFont];
    confrimPwdText.textColor = [UIColor colorWithHexString:@"cccccc"];
    [self.centerView addSubview:confrimPwdText];
    
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
    [finishBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    finishBtn.backgroundColor = [UIColor colorWithHexString:@"ff9c00"];
    [self.view addSubview:finishBtn];
    [finishBtn addTarget:self action:@selector(finishBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}
/** 完成按钮点击事件*/
- (void)finishBtnDidClick
{
    
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

@end
