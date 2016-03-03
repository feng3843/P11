//
//  MyCollectionStartTableViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionStartTableViewController.h"
#import "MyCollectionStartTableViewCell.h"
#import "UIColor+Extensions.h"
#import "DataBaseTool.h"
#import "StarDetailModel.h"
#import "FilmStarsDetailViewController.h"
#import "CMDefault.h"
#import "SVProgressHUD.h"
@interface MyCollectionStartTableViewController ()

@property (nonatomic, strong) NSMutableArray *starts;
@property (nonatomic, assign) int currentPage;

@property(nonatomic ,weak)UIView *noNumView;
@end

@implementation MyCollectionStartTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.currentPage = 0;
    [self newCollectStart];
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
    
//    [self newCollectStart];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    [self newCollectStart];
    [self.tableView footerEndRefreshing];
}


- (void)dealloc
{
    [self.tableView removeFooter];
}


- (NSMutableArray *)starts
{
    if (!_starts) {
        self.starts = [[NSMutableArray alloc] init];
    }
    return _starts;
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
    return self.starts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"reuseIdentifier";
  // 明星
        MyCollectionStartTableViewCell *cell = (MyCollectionStartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
    
                cell = [[MyCollectionStartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.backgroundColor =   [UIColor colorWithHexString:@"ededed"];
    
            }
    StarDetailModel *model = self.starts[indexPath.row];
    cell.star = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB ];
    }else{
    StarDetailModel *model = self.starts[indexPath.row];
    
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   FilmStarsDetailViewController  * filmStarDetailView = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
    filmStarDetailView.strID = model.starId;
    [self.navigationController pushViewController:filmStarDetailView animated:YES];
    }
    
}

- (void)newCollectStart
{
    self.currentPage ++;
    if (self.currentPage == 1) {
      [self.starts removeAllObjects];
    }
    [self.starts addObjectsFromArray:[DataBaseTool collectStarts:self.currentPage]];
    if (self.starts.count <= 0) {
         self.noNumView.hidden = NO;
    }else
    {
        self.noNumView.hidden = YES;
    }

    [self.tableView reloadData];
}

@end
