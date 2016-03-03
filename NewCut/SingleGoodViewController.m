//
//  SingleGoodViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/8/8.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "SingleGoodViewController.h"
#import "UIView+AutoLayout.h"
#import "UIColor+Extensions.h"
#import "SingleGoodButton.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "SingleGoodModel.h"
#import "GoodsTabBarViewController.h"
#import "ADModel.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface SingleGoodViewController ()

@property(nonatomic ,weak)AdvertistingColumn *imageScroll;
@property(nonatomic ,strong)NSMutableArray *imageArray;
@end

@implementation SingleGoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    UIImage *image2 = [UIImage imageNamed:@"bg.png"];
//    
//    [self.navigationController.navigationBar setBackgroundImage:image2
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:image2];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] init]];
//    self.navigationItem.leftBarButtonItem = backItem;
   // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    headView = [[AdvertistingColumn alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 228)];
    
    [self setupView];
    [self getImageList];
}

- (void)setupView
{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:titleView];
    [titleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [titleView autoSetDimension:ALDimensionHeight toSize:64];
    
    UIImage *image = [UIImage imageNamed:@"title.png"];
    UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(104,31,   image.size.width * 0.5,image.size.height  * 0.5)];

    [titleImage setImage:image];
    [titleView addSubview:titleImage];
    UIView *divideView = [[UIView alloc]init];
    divideView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:divideView];
    [divideView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [divideView autoSetDimension:ALDimensionHeight toSize:0.5];
    
    
    UIView *imageScore = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), CGRectGetHeight(headView.frame))];
    self.imageScroll = headView;
    //    imageScore.backgroundColor = [UIColor redColor];
    [imageScore addSubview:self.imageScroll];
    [self.view addSubview:imageScore];
    [imageScore autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [imageScore autoSetDimension:ALDimensionHeight toSize:228];
    
    UIView *divideView2 = [[UIView alloc]init];
    divideView2.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:divideView2];
    [divideView2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore];
    [divideView2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    [divideView2 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
    [divideView2 autoSetDimension:ALDimensionHeight toSize:0.5 ];
    
    //服装
    SingleGoodButton *clothingBtn = [[SingleGoodButton alloc]init];
    [clothingBtn addTarget:self action:@selector(btnClick:)
          forControlEvents:UIControlEventTouchDown];
    clothingBtn.tag = 0;
    [clothingBtn setImage:[UIImage imageNamed:@"clothing.png"] forState:UIControlStateNormal];
    [clothingBtn setTitle:@"服装" forState:UIControlStateNormal];
     clothingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12 * rateH];
    clothingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [clothingBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [self.view addSubview:clothingBtn];
    [clothingBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:22.5 * rateW];
    [clothingBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore withOffset:22.5 * rateH];
    [clothingBtn autoSetDimension:ALDimensionWidth toSize:58 * rateW];
    [clothingBtn autoSetDimension:ALDimensionHeight toSize:94 * rateH];
    
    // 包包
    SingleGoodButton *packageBtn = [[SingleGoodButton alloc]init];
    [packageBtn addTarget:self action:@selector(btnClick:)
         forControlEvents:UIControlEventTouchDown];
    packageBtn.tag = 1;
    [packageBtn setImage:[UIImage imageNamed:@"package.png"] forState:UIControlStateNormal];
    [packageBtn setTitle:@"包包" forState:UIControlStateNormal];
    packageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12 * rateH ];
    packageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [packageBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [self.view addSubview:packageBtn];
    [packageBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:clothingBtn withOffset:45.5 * rateW];
    [packageBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore withOffset:22.5 * rateW];
    [packageBtn autoSetDimension:ALDimensionWidth toSize:58 * rateW];
    [packageBtn autoSetDimension:ALDimensionHeight toSize:94 * rateH];
    // 配件
    SingleGoodButton *partsBtn = [[SingleGoodButton alloc]init];
      partsBtn.tag = 2;
    [partsBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [partsBtn setImage:[UIImage imageNamed:@"parts.png"] forState:UIControlStateNormal];
  
    [partsBtn setTitle:@"配件" forState:UIControlStateNormal];
    partsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12 * rateH];
    partsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [partsBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [self.view addSubview:partsBtn];
    [partsBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:packageBtn withOffset:45 * rateW];
    [partsBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore withOffset:22.5 * rateW];
    [partsBtn autoSetDimension:ALDimensionWidth toSize:58 * rateW];
    [partsBtn autoSetDimension:ALDimensionHeight toSize:94 * rateH];
//    clothingBtn.backgroundColor = [UIColor redColor];
   // 鞋子
    SingleGoodButton *shoesBtn = [[SingleGoodButton alloc]init];
    [shoesBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [shoesBtn setImage:[UIImage imageNamed:@"shoes.png"] forState:UIControlStateNormal];
    shoesBtn.tag = 3;
    [shoesBtn setTitle:@"鞋子" forState:UIControlStateNormal];
    shoesBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12 * rateH];
    shoesBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [shoesBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [self.view addSubview:shoesBtn];
    [shoesBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view
        withOffset:22.5 * rateW];
    [shoesBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore withOffset:128];
    [shoesBtn autoSetDimension:ALDimensionWidth toSize:58 * rateW];
    [shoesBtn autoSetDimension:ALDimensionHeight toSize:94 * rateH];

    // 饰品
    SingleGoodButton *ornamentsBtn = [[SingleGoodButton alloc]init];
    ornamentsBtn.tag = 4;
    [ornamentsBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [ornamentsBtn setImage:[UIImage imageNamed:@"ornaments.png"] forState:UIControlStateNormal];
    [ornamentsBtn setTitle:@"饰品" forState:UIControlStateNormal];
    ornamentsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12 * rateH];
    ornamentsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [ornamentsBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [self.view addSubview:ornamentsBtn];
    [ornamentsBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:shoesBtn withOffset:45.5 * rateW];
    [ornamentsBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore withOffset:128];
    [ornamentsBtn autoSetDimension:ALDimensionWidth toSize:58 * rateW];
    [ornamentsBtn autoSetDimension:ALDimensionHeight toSize:94 * rateH];
    
    // 电影周边
    SingleGoodButton *movieBtn = [[SingleGoodButton alloc]init];
    movieBtn.tag = 5;
    [movieBtn addTarget:self action:@selector(btnClick:)
       forControlEvents:UIControlEventTouchDown];
    [movieBtn setImage:[UIImage imageNamed:@"filmperiphery.png"] forState:UIControlStateNormal];
    [movieBtn setTitle:@"周边" forState:UIControlStateNormal];
    movieBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12 * rateH];
    movieBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [movieBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [self.view addSubview:movieBtn];
    [movieBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:ornamentsBtn withOffset:45 * rateW];
    [movieBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageScore withOffset:128];
    [movieBtn autoSetDimension:ALDimensionWidth toSize:58 * rateW];
    [movieBtn autoSetDimension:ALDimensionHeight toSize:94 * rateH];
    
    
}


- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)setupImage
{
    [self.imageScroll setArray:self.imageArray];
}

- (void)getImageList
{
    
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        NSDictionary *param = @{@"name":@"单品"};
        [CMAPI postUrl:API_ADPHOTO Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            //NSString* strCode = [NSString stringWithFormat:@"%@",result];
            
            if(succeed){
                
                [self.imageArray removeAllObjects];
                [self.imageArray addObjectsFromArray:[ADModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"advertisement"]]];
                  [self setupImage];
             
            }else{
                //如果失败，弹出提示
                
                NSDictionary *dic=[detailDict valueForKey:@"result"];
                if(!!dic&&dic.count>0)
                    result=[dic valueForKey:@"reason"];
                
                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
                
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
                [SVProgressHUD setInfoImage:nil];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD showInfoWithStatus:result];
            }
        }];
    }
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIImage *image2 = [UIImage imageNamed:@""];
    [self.navigationController.navigationBar setBackgroundImage:image2
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image2];
//        self.hidesBottomBarWhenPushed = YES;

    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0f, 244 * 0.5, 47 * 0.5)];//初始化图片视图控件
//    imageView.contentMode = UIViewContentModeScaleAspectFit;    UIImage *image = [UIImage imageNamed:@"title.png"];//初始化图像视图
//    [imageView setImage:image];
//    self.navigationItem.titleView = imageView;

    self.navigationController.navigationBarHidden = YES;
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//        UIScreenEdgePanGestureRecognizer *left2rightSwipe = [[UIScreenEdgePanGestureRecognizer alloc]
//                                                             initWithTarget:self
//                                                             action:@selector(handleSwipeGesture:)]
//        ;
//        [left2rightSwipe setDelegate:self];
//        [left2rightSwipe setEdges:UIRectEdgeLeft];
//        [self.view addGestureRecognizer:left2rightSwipe];
//    }
//
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClick:(SingleGoodButton *)btn
{
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodsTabBarViewController * goodsTabBar= [View instantiateViewControllerWithIdentifier:@"goodsViewId"];
    // goodsTabBar.tabBarController.tabBarItem
    goodsTabBar.index = btn.tag;
    [self.navigationController pushViewController:goodsTabBar animated:YES];
}

@end
