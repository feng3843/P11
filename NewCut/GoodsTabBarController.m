//
//  GoodsTabBarController.m
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodsTabBarController.h"
#import "CommonMacro.h"
#import "GoodsTabBar.h"

@interface GoodsTabBarController ()<UIScrollViewDelegate, GoodsTabBarDelegate>
{

    NSInteger       _currentIndex;              // current page index
    NSMutableArray  *_titles;                   // array of children view controller's title
    
    GoodsTabBar     *_goodsTabBar;                // NavTabBar: press item on it to exchange view
    UIScrollView    *_mainView;

}

@end

@implementation GoodsTabBarController
@synthesize backBtn;

- (id)initWithShowArrowButton:(BOOL)show
{
    self = [super init];
    if (self)
    {
        _showArrowButton = show;
    }
    return self;
}

-(id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    
    self = [super init];
    if (self)
    {
        _subViewControllers = subViewControllers;
    }
    return self;
    
}

-(id)initWithParentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        [self addParentController:viewController];
    }
    
    return self;
    
}

-(id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController showArrowButton:(BOOL)show
{
    
    self = [self initWithSubViewControllers:subControllers];
    
    _showArrowButton = show;
    [self addParentController:viewController];
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConfig];
    [self viewConfig];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
#pragma mark -
- (void)initConfig
{
    // Iinitialize value
    _currentIndex = 1;
    _goodsTabBarColor = _goodsTabBarColor ? _goodsTabBarColor : NavTabbarColor;
    
    // Load all title of children view controllers
    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    for (UIViewController *viewController in _subViewControllers)
    {
        [_titles addObject:viewController.title];
    }
}

- (void)viewInit
{
    //    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.tabBarController.tabBar.translucent = NO;
    //NAV_TAB_BAR_HEIGHT
    // Load NavTabBar and content view to show on window
    // _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(80, 30, SCREEN_WIDTH-40, 40) showArrowButton:_showArrowButton];
    //_navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, 20, SCREEN_WIDTH, 20)];
    //     _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(80, 20, SCREEN_WIDTH-40, 40) showArrowButton:_showArrowButton];
    //_goodsTabBar = [[GoodsTabBar alloc] initWithFrame:CGRectMake(80, 20, SCREEN_WIDTH-40, 40) showArrowButton:_showArrowButton];
    _goodsTabBar = [[GoodsTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, 36) showArrowButton:nil];
    
    _goodsTabBar.delegate = self;
    //_navTabBar.backgroundColor = _navTabBarColor;
    _goodsTabBar.backgroundColor = [UIColor whiteColor];
    //
    _goodsTabBar.lineColor = [UIColor whiteColor];
    _goodsTabBar.itemTitles = _titles;
    //    _goodsTabBar.arrowImage = _goodsTabBarArrowImage;
    [_goodsTabBar updateData];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _goodsTabBar.frame.origin.y + _goodsTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _goodsTabBar.frame.origin.y - _goodsTabBar.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    UIImageView* imgView=[[UIImageView alloc]init];
    UIImage* img=[[UIImage alloc]init];
    img=[UIImage imageNamed:@"back"];
    [imgView setImage:img];
    //[self.backBtn addSubview:imgView];
    //self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 25, 30, 30)];
    //[self.backBtn setBackgroundImage:[UIImage imageNamed:@"backsmall"] forState:UIControlStateNormal];
    //self.backBtn.titleLabel.text = @"返回";
    //self.backBtn.titleLabel.textColor = [UIColor blueColor];
    
    //self.backBtn.backgroundColor = [UIColor blueColor];
    //[self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:backBtn];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 25, 23, 23)];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back_gray"] forState:UIControlStateNormal];
    
    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_mainView];
    [self.view addSubview:_goodsTabBar];
    //[self.view addSubview:backBtn];
}

-(void)closeView{
    
    //[SVProgressHUD showInfoWithStatus:@"wwwwww"];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, DOT_COORDINATE, SCREEN_WIDTH, _mainView.frame.size.height);
        [_mainView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

#pragma mark - Public Methods
#pragma mark -
- (void)setNavTabbarColor:(UIColor *)navTabbarColor
{
    // prevent set [UIColor clear], because this set can take error display
    CGFloat red, green, blue, alpha;
    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
    {
        navTabbarColor = NavTabbarColor;
    }
    
    _goodsTabBarColor = navTabbarColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

#pragma mark - Scroll View Delegate Methods
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _goodsTabBar.currentItemIndex = _currentIndex;
    //subViewControllers;
    
}

#pragma mark - SCNavTabBarDelegate Methods
#pragma mark -
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, DOT_COORDINATE) animated:_scrollAnimation];
    //    for (UIViewController *viewController in _subViewControllers)
    //    {
    //    }
    
}


- (void)setIndex:(NSInteger)index
{
    _index = index;
    [self itemDidSelectedWithIndex:index];
}
- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height
{
    if (pop)
    {
        [UIView animateWithDuration:0.5f animations:^{
            _goodsTabBar.frame = CGRectMake(_goodsTabBar.frame.origin.x, _goodsTabBar.frame.origin.y, _goodsTabBar.frame.size.width, height + NAV_TAB_BAR_HEIGHT);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            _goodsTabBar.frame = CGRectMake(_goodsTabBar.frame.origin.x, _goodsTabBar.frame.origin.y, _goodsTabBar.frame.size.width, NAV_TAB_BAR_HEIGHT);
        }];
    }
    
    [_goodsTabBar refresh];
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

