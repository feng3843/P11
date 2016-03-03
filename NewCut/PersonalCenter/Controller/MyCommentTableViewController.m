//
//  MyCommentTableViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/20.
//  Copyright (c) 2015年 py. All rights reserved.
//  我的收藏

#import "MyCommentTableViewController.h"
#import "MyCommentTableViewCell.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "CMAPI.h"
#import "UIColor+Extensions.h"
#import "CMData.h"
#import "UserCommentModel.h"
#import "MJExtension.h"
#import "UserCommentModel.h"
#import "FilmDetailViewController.h"
#import "DressDetailViewController.h"
#import "CMDefault.h"
@interface MyCommentTableViewController ()
@property(nonatomic ,strong)NSMutableArray *commentArray;

@property(nonatomic ,assign)int page;
@end

@implementation MyCommentTableViewController
- (void)viewWillAppear:(BOOL)animated
{
       [super viewWillAppear:animated];
    UIImage *image = [UIImage imageNamed:@""];
    
    [self.navigationController.navigationBar setBackgroundImage:image
     
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:image];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
 
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    self.tableView.rowHeight = 70;
    self.page = 1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getCommentList];
    [self setupRefresh];
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
    self.page ++ ;
    [self getCommentList];
    if (self.commentArray.count <= 0) {
       
            [SVProgressHUD showInfoWithStatus:@"您还没有任何收藏哦"];
        
    }
    [self.tableView footerEndRefreshing];
}



- (NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

-(void)getCommentList
{
   
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB ];
    }else{
        
        NSDictionary *params = @{@"token":[CMData getToken],
                               @"userId":[CMData getUserId],
                               @"limit":@(20),
                               @"p":@(self.page)};
        [CMAPI postUrl:API_USER_COMMENT Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
       
            if(succeed)
            {
                [self.commentArray addObjectsFromArray:[UserCommentModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"movie"]]];
//                NSLog(@"%@",detailDict);
                [self.tableView reloadData];
            }
            else
            {

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellId = @"reuseIdentifier";
    MyCommentTableViewCell *cell = (MyCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[MyCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }

    UserCommentModel *model = self.commentArray[indexPath.row];
    cell.comment = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB ];
    }else{
     UserCommentModel *model = self.commentArray[indexPath.row];
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([model.typeName isEqualToString:@"电影"]) {
        FilmDetailViewController *vc = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
        vc.strID = model.movieGoodId;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
       
        DressDetailViewController *vc = [View instantiateViewControllerWithIdentifier:@"dressDetail"];
        vc.strID = model.movieGoodId;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}


@end
