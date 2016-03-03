//
//  SearchViewController.m
//  NewCut
//
//  Created by py on 15-7-8.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "SearchViewController.h"
#import "CMAPI.h"
#import "PYAllCommon.h"
#import "FuzzySearchViewController.h"
#import "FuzzySearchResultViewController.h"
#import "UIImage+Extensions.h"
@interface SearchViewController ()<FuzzySearchResultViewControllerDelegate,UIGestureRecognizerDelegate>


/** @brief 影视库 */

@property (strong, nonatomic) IBOutlet UIButton *btnMovies;
/** @brief 影星库 */
@property (weak, nonatomic) IBOutlet UIButton *btnStars;
/** @brief 明星衣橱 */
@property (weak, nonatomic) IBOutlet UIButton *btnArmoire;
@property (strong, nonatomic) UIImageView *searchMovie;
@property (strong, nonatomic) UIImageView *searchStar;
@property (strong, nonatomic) UIImageView *searchCloth;
//@property (strong, nonatomic) IBOutlet UIButton *btnMovies;
//@property (strong, nonatomic) IBOutlet UIButton *btnStars;
//@property (strong, nonatomic) IBOutlet UIButton *btnArmoire;


@property(nonatomic ,weak)UIButton *cancleBtn;
@property(nonatomic ,weak)UIButton *cover;

@property(nonatomic ,assign) BOOL isScroll;

@property(nonatomic ,weak)FuzzySearchResultViewController *searchResult;
@end

@implementation SearchViewController
@synthesize searchBarInTop,searchField;
//@synthesize clothBtn,goodsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpForDismissKeyboard) name:@"hide" object:nil];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 第一个分割线
    UIView *oneDividingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenW, 0.5)];
    oneDividingLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:oneDividingLine];
    
    CGRect frame = CGRectMake(100* rateW ,140 *rateH ,320,0);
    CGSize size = [UIImage imageNamed:@"DynamicSearch.gif"].size;
    frame.size = CGSizeMake(size.width  , size.height);
    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"DynamicSearch" ofType:@"gif"]];
    // view生成
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.backgroundColor = [UIColor clearColor];
    webView.paginationMode = UIWebPaginationModeLeftToRight;
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//          [self.view addSubview:webView];
       [self.view insertSubview:webView belowSubview:self.btnMovies];
//
    CGRect bagframe = CGRectMake(20 *rateW ,295 *rateH ,0,0);
    CGSize bagsize = [UIImage imageNamed:@"bag.gif"].size;
    bagframe.size = CGSizeMake(bagsize.width , bagsize.height);
    // 读取gif图片数据
    NSData *baggif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bag" ofType:@"gif"]];
    // view生成
    UIWebView *bagwebView = [[UIWebView alloc] initWithFrame:bagframe];
    bagwebView.backgroundColor = [UIColor clearColor];
      bagwebView.paginationMode = UIWebPaginationModeLeftToRight;
    bagwebView.userInteractionEnabled = NO;//用户不可交互
    [bagwebView loadData:baggif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
  
        [self.view addSubview:bagwebView];
//    [self.view insertSubview:bagwebView belowSubview:self.btnStars];
//
    CGRect maframe = CGRectMake(190 *rateW,299 *rateH,0,0);
    CGSize masize = [UIImage imageNamed:@"malilian.gif"].size;
    maframe.size = CGSizeMake(masize.width , masize.height );
    // 读取gif图片数据
    NSData *maggif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"malilian" ofType:@"gif"]];
    // view生成
    UIWebView *mawebView = [[UIWebView alloc] initWithFrame:maframe];
    mawebView.backgroundColor = [UIColor clearColor];
    mawebView.userInteractionEnabled = NO;//用户不可交互
      mawebView.paginationMode = UIWebPaginationModeTopToBottom;
    [mawebView loadData:maggif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    [self.view insertSubview:mawebView belowSubview:self.btnArmoire];
    [self.view addSubview:mawebView];
    
    
    [self createSearchBar];
    [self styleInit];
    
    self.isScroll = NO;

   

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (FuzzySearchResultViewController *)searchResult
{
    if (_searchResult == nil) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = [UIScreen mainScreen].bounds.size.height;
        FuzzySearchResultViewController *search =  [[FuzzySearchResultViewController alloc]init];
        search.view.frame = CGRectMake(0, 64, w, h - 64);
        [self addChildViewController:search];
        _searchResult = search;
        _searchResult.delegate = self;
        [self.view addSubview:search.view];
    }
    return  _searchResult;
}
- (void)scroll
{
    self.isScroll = YES;
    [searchField resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [_btnMovies becomeFirstResponder];
}

-(void)createSearchBar{
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    searchField = [[UITextField alloc] initWithFrame:CGRectMake(16.0, 27, w - 16*2, 30)];
    searchField.delegate = self;
    searchField.returnKeyType = UIReturnKeySearch;
//    /***王朋***/
    searchField.tintColor = [UIColor blackColor];
        searchField.background = [UIImage resizedImage:@"text.png"];
    [searchField setBorderStyle:UITextBorderStyleNone];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, 20, 40);
//    bgView.backgroundColor = [UIColor redColor];
    UIImageView *searchImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_small.png"]];
    searchImage.frame = CGRectMake(5, 12.5, 15, 15);
    [bgView addSubview:searchImage];
    
    searchField.leftView = bgView;
    searchField.leftViewMode = UITextFieldViewModeAlways;
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 13, 15, 15)];
//    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_small.png"] forState:UIControlStateNormal];
//    [searchField addSubview:searchBtn];
//
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(w - 40 -16, 27, 40, 30);
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchDown];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"bababa"] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.cancleBtn = cancleBtn;
    [self.view addSubview:cancleBtn];
//    
//    searchField.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    searchField.placeholder = @"搜索喜欢的商品 影视 明星";
    searchField.font = [UIFont systemFontOfSize:13];
    searchField.textColor = [UIColor colorWithHexString:@"000000"];
    [searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:searchField];
    

    
    UIButton *cover = [[UIButton alloc]init];
    cover.frame = CGRectMake(0, 64 , w, h - 64);
    self.cover = cover;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
}

-(void)styleInit{
    //“影视库”按钮样式
//    [_btnMovies.layer setCornerRadius:8.0];
//    
//    //“影星库”按钮样式
//    [_btnStars.layer setCornerRadius:8.0];
//    
//    //“明星衣橱”按钮样式
//    [_btnArmoire.layer setCornerRadius:8.0];
    
//    [self.searchMovie setFrame:CGRectMake(0, 60, self.view.bounds.size.width, 150)];
//    [self.searchStar setFrame:CGRectMake(0, 220, self.view.bounds.size.width, 150)];
//    [self.searchCloth setFrame:CGRectMake(0, 380, self.view.bounds.size.width, 150)];
    
}


#pragma mark- 查询控件


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        searchField.frame = CGRectMake(16.0, 27, w - 16 *2 -45, 30);
        self.cover.alpha = 0.5;
        self.tabBarController.tabBar.hidden = YES;
//        searchField.background = [[UIImage alloc]init];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!self.isScroll) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        [UIView animateWithDuration:0.25 animations:^{
            searchField.frame = CGRectMake(16.0, 27, w - 16 *2, 30);
            self.cover.alpha = 0;
        }];
        self.searchResult.view.hidden = YES;
        
        searchField.text = nil;
        self.tabBarController.tabBar.hidden = NO;
//         searchField.background = [[UIImage alloc]init];
        
    }else
    {
        self.isScroll = NO;
    }
   
}

//监听输入框事件
-(void)textFieldDidChange:(UITextField*) TextField{
    
    
    if(![searchField.text isEqualToString:@""] && ![searchField.text isEqualToString:@""]){
        self.searchResult.view.hidden = NO;
        
        self.searchResult.searchText = TextField.text;
       }else{
            self.searchResult.view.hidden = YES;
     }    
}
 /*  点击遮盖
 */
- (void)coverClick {
      self.isScroll = NO;
    [searchField resignFirstResponder];
  
}
/**
 * 点击取消
 */
- (void)cancleBtnClick
{
   

    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.25 animations:^{
         searchField.frame = CGRectMake(16.0, 27, w - 16 *2, 30);
        self.cover.alpha = 0;
    }];
    self.searchResult.view.hidden = YES;
    self.isScroll = NO;
    searchField.text = nil;
    self.tabBarController.tabBar.hidden = NO;
     [searchField resignFirstResponder];
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
