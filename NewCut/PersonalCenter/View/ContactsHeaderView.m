//
//  ContactsHeaderView.m
//  NewCut
//
//  Created by 夏雪 on 15/7/16.
//  Copyright (c) 2015年 py. All rights reserved.
//   

#import "ContactsHeaderView.h"
#import "UIImage+Extensions.h"
#import "DataBaseTool.h"
#import "CMData.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "SDImageView+SDWebCache.h"
#define userImagePath  @"MyImage"
@interface ContactsHeaderView ()

@property(nonatomic ,weak)UIImageView *headImage;

@property(nonatomic ,weak)UILabel *startName;
@end
@implementation ContactsHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
      CGFloat width = self.bounds.size.width;
        
        UIImageView *bgImage = [[UIImageView alloc]init];
        bgImage.frame = self.bounds;
        bgImage.image = [UIImage imageNamed:@"bg_me2.png"];
        [self addSubview:bgImage];
        
        CGFloat startH = 120;
        CGFloat startW = startH;
        CGFloat startX = (width - startH ) * 0.5;
        CGFloat startY = 57 + 20;
        UIImageView *startImage = [[UIImageView alloc]initWithFrame:CGRectMake(startX, startY, startH, startW)];

//        startImage.image = [UIImage imageNamed:@"head_me.png"];
         self.headImage = startImage;
        startImage.layer.cornerRadius = 60;
        startImage.layer.masksToBounds = YES;
        [self changeUserImage];
        [self addSubview:startImage];
        
        CGFloat startNameX  = 0;
        CGFloat startNameY = startY + startW + 18;
        CGFloat startNameW = width;
        CGFloat startNameH = 30;
        UILabel *startName = [[UILabel alloc]initWithFrame:CGRectMake(startNameX, startNameY , startNameW, startNameH)];
        startName.textAlignment = NSTextAlignmentCenter;
        self.startName = startName;
        [self changeStartName];
//        startName.text = @"李易峰";
        startName.textColor = [UIColor whiteColor];
        [self addSubview:startName];
        self.startName = startName;
        
        CGFloat startBtnX = startX ;
        CGFloat startBtnY = startY;
        CGFloat startBtnW = startW;
        CGFloat startBtnH =  startH + startNameH + 18;
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame = CGRectMake(startBtnX, startBtnY, startBtnW, startBtnH);
//        startBtn.backgroundColor = [UIColor redColor];
        [self addSubview:startBtn];
        [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat setUpY = 35 ;
        CGFloat setUpX = width - 21 -16;
        UIImageView *setUpImage = [[UIImageView alloc]initWithFrame:CGRectMake(setUpX, setUpY, 21, 21)];
        setUpImage.image = [UIImage imageNamed:@"shezhi.png"];
        [self addSubview:setUpImage];
        
        CGFloat setUpBtnY = 30;
        CGFloat setUpBtnX = width - 70 -16;
        UIButton *setUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        setUpBtn.frame = CGRectMake(setUpBtnX, setUpBtnY, 70, 70);
#warning 按钮事件
//        setUpBtn.backgroundColor = [UIColor redColor];
        [self addSubview:setUpBtn];
        [setUpBtn addTarget:self action:@selector(setUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserImage) name:@"CHANGE_USERIMAGE" object:nil];
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"CHANGE_USERNICKNAME" object:nil];
  
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"CANCEL_LOGOUT" object:nil];
        }
    
     
    return self;
}
- (void)logout
{
      self.headImage.image = [UIImage imageNamed:@"head_me.png"];
      self.startName.text = @"请先登录或注册";
}

/** 昵称改变*/
- (void)changeNickName:(NSNotification *)notification
{
    self.startName.text = notification.userInfo[@"nickName"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 头像改变了*/
- (void)changeUserImage
{
    NSString *fileName = [DataBaseTool getuserImage];
    NSString *path = [CMRES_ImageURL stringByAppendingPathComponent:fileName];
//    
//    if ([fileName isEqualToString:@""]) {
//         self.headImage.image = [UIImage imageNamed:@"head_me.png"];
//        return;
//    }
////    [CMTool setImageUrl:path ByImageName:fileName InImageView:self.headImage ImageCate:@"head_me.png" completed:^(UIImage *image, NSString *strImageName) {
////       
////    }];
    [self.headImage setImageWithURL:[NSURL URLWithString:path] refreshCache:YES placeholderImage:[UIImage imageNamed:@"head_me.png"]];
    
}

- (void)changeStartName
{
    if ([[CMData getToken] isEqualToString:@""]) {
        self.startName.text = @"请先登录或注册";
    }
    else if ([[DataBaseTool getNickName] isEqualToString:@""])
    {
        self.startName.text = @"请修改昵称";

    }else
    {
         self.startName.text = [DataBaseTool getNickName];
    }

}
- (void)setUpBtnClick
{
    [CMAPI checkWeb:^{
        if ([self.delegate respondsToSelector:@selector(setUpBtnDidClick)]) {
            [self.delegate setUpBtnDidClick];
        }
    }];
}
- (void)startBtnClick
{
    [CMAPI checkWeb:^{
        if ([self.delegate respondsToSelector:@selector(startBtnDidClick)]) {
            [self.delegate startBtnDidClick];
        }
    }];
}

@end
