//
//  AllStarsViewController.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

#import "AllStarsViewController.h"
#import "PYAllCommon.h"
#include "ChineseInclude.h"
#include "PinYinForObjc.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "StarDetailModel.h"
#import "MyCollectionStartTableViewCell.h"
#import "AllStarSearchResultViewController.h"
@interface AllStarsViewController ()<AllStarSearchResultViewControllerDelegate>

@property (assign,nonatomic) BOOL ISFrist;
@property (nonatomic) UILocalizedIndexedCollation *collation;
@property(nonatomic ,strong)NSMutableArray *searchStarList;
@property(nonatomic ,strong)NSMutableArray *itemFilmList;
@property (assign,nonatomic) int order;
@property(nonatomic ,weak)UIButton *cover;

@property(nonatomic ,weak)AllStarSearchResultViewController *searchResult;

@property(nonatomic ,assign) BOOL isScroll;
@property(nonatomic ,assign) BOOL isAToZ;
@end

@implementation AllStarsViewController
@synthesize AllStarsTableView,rightTitle,searchStars;

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self setUpForDismissKeyboard];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    self.automaticallyAdjustsScrollViewInsets = false;
    AllStarsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, w, h - 108)];
    UISearchBar *search = [[UISearchBar alloc]init];
    search.placeholder = @"搜索";
    search.delegate = self;
    search.frame = CGRectMake(0, 0, w, 44);
    [self.view addSubview:search];
    self.searchStars = search;
     //[self.menuTabBar setFrame:CGRectMake(0, 524*h/568, w, 44*h/568)];
    rightTitle = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G",@"H", @"I", @"J",@"K", @"L", @"M",@"N", @"O", @"P", @"Q", @"R", @"S",@"T",@"U", @"V", @"W", @"X", @"Y",@"Z",@"#", nil];
 
    AllStarsTableView.delegate = self;
    AllStarsTableView.dataSource = self;
    AllStarsTableView.sectionIndexColor = [UIColor colorWithHexString:@"b5b5b5"];
    AllStarsTableView.sectionIndexBackgroundColor = [UIColor colorWithHexString:@"ededed"];

    AllStarsTableView.backgroundColor = [UIColor
                                    colorWithHexString:@"ededed"];
    AllStarsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:AllStarsTableView];
//

    UIButton *cover = [[UIButton alloc]init];
    cover.frame = CGRectMake(0, 44 , w, h - 108);
    self.cover = cover;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    
    [self setupRefresh];
    self.isScroll = NO;
    self.isAToZ = NO;
}
- (AllStarSearchResultViewController *)searchResult
{
    if (_searchResult == nil) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = [UIScreen mainScreen].bounds.size.height;
        AllStarSearchResultViewController *search =  [[AllStarSearchResultViewController alloc]init];
        search.view.frame = CGRectMake(0, 44, w, h - 110);
        [self addChildViewController:search];
        _searchResult = search;
        _searchResult.delegate = self;
        [self.view addSubview:search.view];
    }
    return  _searchResult;
}


- (NSMutableArray *)searchStarList
{
    if (_searchStarList == nil) {
        _searchStarList = [NSMutableArray array];
    }
    return _searchStarList;
}
- (NSMutableArray *)itemFilmList
{
    if (_itemFilmList == nil) {
        _itemFilmList = [NSMutableArray array];
    }
    return _itemFilmList;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.AllStarsTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.AllStarsTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.AllStarsTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.AllStarsTableView.headerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_DOWN_TO_REFRESH, @"");
    self.AllStarsTableView.headerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_REFRESH, @"");
    self.AllStarsTableView.headerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING, @"");
    
    self.AllStarsTableView.footerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_UP_TO_LOAD_MORE, @"");
    self.AllStarsTableView.footerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_LOAD_MORE, @"");
    self.AllStarsTableView.footerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING_MORE, @"");
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.order = 2;
    [self loadNewData];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
    });
}

- (void)footerRereshing
{
    self.order = 1;
    [self loadNewData];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
    });
}


-(void)reloadData
{
    [self.AllStarsTableView reloadData];
      [self.AllStarsTableView headerEndRefreshing];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.AllStarsTableView footerEndRefreshing];
}

- (void)loadNewData
{
     if (self.searchStarList.count) {
        if (self.order == 1) {
            StarDetailModel *model = [self.searchStarList lastObject];
            [self getStartListBYLetter:model.hanyupinyin :self.order];
        }else if (self.order == 2)
        {
            StarDetailModel *model = [self.searchStarList firstObject];
            [self getStartListBYLetter:model.hanyupinyin :self.order];
        }
    }else
    {
         self.ISFrist = YES;
         [self getStartListBYLetter:@"A" :self.order];
    
    }
    
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
    [searchStars resignFirstResponder];
    searchStars.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 搜索框代理方法
/**
 *  键盘弹出:搜索框开始编辑文字
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    
    // 1.显示搜索框右边的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 2.显示遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.5;
    }];
}

/**
 *  键盘退下:搜索框结束编辑文字
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    if (!self.isScroll) {

    // 1.隐藏搜索框右边的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    // 2.隐藏遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.0;
    }];
    
    // 3.移除搜索结果
    self.searchResult.view.hidden = YES;
    searchBar.text = nil;
    }else
    {
        self.isScroll = NO;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

/**
 *  搜索框里面的文字变化的时候调用
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.searchResult.view.hidden = NO;
        self.searchResult.searchText = searchText;
    } else {
        self.searchResult.view.hidden = YES;
    }
}

/**
 *  点击遮盖
 */
- (void)coverClick {
    [searchStars resignFirstResponder];
}
- (void)scroll
{
    self.isScroll = YES;
    [searchStars resignFirstResponder];
}
//列表方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.searchStarList.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//   
//    return rightTitle.count;
    return 1;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 110;

}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView {
    
    return rightTitle;
}

//点击右侧索引表项时调用

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSString *type = rightTitle[index];
    self.isAToZ = YES;
    [self getStartListBYLetter:type:1];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
    });
    return index;
}

-(void)getStartListBYLetter:(NSString *)type:(int)order
{
    

    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        NSDictionary *params = @{
                                 @"type":type,
                                 @"order":@(order),
                                 @"limit":@(5),
                                 };
        
        [CMAPI postUrl:API_STAR_PAGE_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                 NSArray *array = [StarDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"movie"]];
                if (order == 2 || self.isAToZ == YES) {
                    if (array.count > 0) {
                        [self.searchStarList removeAllObjects];
                        self.isAToZ = NO;
                    }
                    
                }
              [self.searchStarList addObjectsFromArray:array];
              
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{  return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"reuseIdentifier";
    // 明星
    MyCollectionStartTableViewCell *cell = (MyCollectionStartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[MyCollectionStartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor =   [UIColor colorWithHexString:@"ededed"];
        
    }
    if(self.searchStarList.count > indexPath.row)
    {
    StarDetailModel *model = self.searchStarList[indexPath.row];
    cell.star = model;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StarDetailModel *model = self.searchStarList[indexPath.row];
    NSString *Id = model.starId;
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    filmStarDetailView = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
    filmStarDetailView.strID = Id;

    [self.navigationController pushViewController:filmStarDetailView animated:YES];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
