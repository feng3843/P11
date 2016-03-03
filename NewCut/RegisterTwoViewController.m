//
//  RegisterTwoViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "UIColor+Extensions.h"
#import "UIImage+Extensions.h"
@interface RegisterTwoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

- (IBAction)finishBtnClick;
@end

@implementation RegisterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * bgImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImage.image = [UIImage imageNamed:@"bg_log in.png"];
    [self.view insertSubview:bgImage atIndex:0];
   
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ff9c00"]] forState:UIControlStateNormal];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"d28000"]] forState:UIControlStateHighlighted];
    self.finishBtn.layer.cornerRadius = 5;
    self.finishBtn.layer.masksToBounds = YES;
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
}
@end
