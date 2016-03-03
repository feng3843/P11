//
//  MyCollectionGoodsTableViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionGoodsTableViewController.h"
#import "MyCollectionGoodsTableViewCell.h"
#import "UIColor+Extensions.h"
#import "DataBaseTool.h"
#import "GoodDetailModel.h"
#import "DressDetailViewController.h"
#import "CMDefault.h"
#import "SVProgressHUD.h"
@interface MyCollectionGoodsTableViewController ()
@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, assign) int currentPage;

@property(nonatomic ,weak)UIView *noNumView;
@end

@implementation MyCollectionGoodsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.currentPage = 0;
    [self newCollectGood];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =  [UIColor colorWithHexString:@"ededed"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    CGFloat rate = w / 320;
    self.tableView.rowHeight = 110 * rate;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self newCollectGood];
    [self setupRefresh];
    UIView *noNumView = [[UIView alloc]initWithFrame:CGRectMake(0, -20,self.view.frame.size.width , self.view.frame.size.height)];
    noNumView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    UILabel *lable = [[UILabel alloc]init];
    
    lable.frame = CGRectMake(0, 40,self.view.frame.size.width ,13);
    [noNumView addSubview:lable];
    lable.text = @"您还没有任何收藏哦";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorWithHexString:@"999999"];
    lable.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:noNumView];
    self.noNumView = noNumView;
    self.noNumView.hidden = YES;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    //    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //        [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //   2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_UP_TO_LOAD_MORE, @"");
    self.tableView.footerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_LOAD_MORE, @"");
    self.tableView.footerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING_MORE, @"");
}


#pragma mark 开始进入刷新状态

- (void)footerRereshing
{
    //    // 2.2秒后刷新表格UI
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        //        [self getFilmDetailInfo_Comment];
    //    });
    [self newCollectGood];
    [self.tableView footerEndRefreshing];
}


- (NSMutableArray *)goods
{
    if (!_goods) {
        self.goods = [[NSMutableArray alloc] init];
    }
    return _goods;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.goods.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"reuseIdentifier";
    MyCollectionGoodsTableViewCell *cell = (MyCollectionGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[MyCollectionGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
         cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    }
    GoodDetailModel *model = self.goods[indexPath.row];
    cell.good = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB ];
    }else{
        
        
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DressDetailViewController *dressDetailView = [View instantiateViewControllerWithIdentifier:@"dressDetail"];
    GoodDetailModel *model = self.goods[indexPath.row];
    dressDetailView.strID = model.goodId;
    [self.navigationController pushViewController:dressDetailView animated:YES];
    }
    
}
- (void)newCollectGood
{
    self.currentPage ++;
    if (self.currentPage == 1) {
    [self.goods removeAllObjects];
    }
    [self.goods addObjectsFromArray:[DataBaseTool collectGoods:self.currentPage]];
    if (self.goods.count <= 0) {
        self.noNumView.hidden = NO;
    }else
    {
        self.noNumView.hidden = YES;
    }

    [self.tableView reloadData];
}


@end
