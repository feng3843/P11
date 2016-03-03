//
//  FuzzySearchResultViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/8/7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FuzzySearchResultViewController.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "CMAPI.h"
#import "UIColor+Extensions.h"
#import "FilmDetailModel.h"
#import "GoodDetailModel.h"
#import "StarDetailModel.h"
#import "MyCollectionFilmTableViewCell.h"
#import "MyCollectionGoodsTableViewCell.h"
#import "MyCollectionStartTableViewCell.h"
#import "FilmDetailViewController.h"
#import "FilmStarsDetailViewController.h"
#import "DressDetailViewController.h"
#import "PYAllCommon.h"

@interface FuzzySearchResultViewController ()
@property (nonatomic, strong) NSMutableArray *startResult;
@property (nonatomic, strong) NSMutableArray *goodResult;
@property (nonatomic, strong) NSMutableArray *movieResult;
@property (nonatomic, strong) NSMutableArray *resultList;
@end

@implementation FuzzySearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w =[UIScreen mainScreen].bounds.size.width;
    CGFloat rate = w / 320;
    self.tableView.rowHeight = 110 *rate;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)startResult
{
    if (_startResult == nil) {
        _startResult = [NSMutableArray array];
    }
    return _startResult;
}

- (NSMutableArray *)goodResult
{
    if (_goodResult == nil) {
        _goodResult = [NSMutableArray array];
    }
    return _goodResult;
}

- (NSMutableArray *)movieResult
{
    if (_movieResult == nil) {
        _movieResult = [NSMutableArray array];
    }
    return _movieResult;
}
- (NSMutableArray *)resultList
{
    if (_resultList == nil) {
        _resultList = [NSMutableArray array];
    }
    return _resultList;
}



- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    searchText = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(searchText.length <=0 && [searchText isEqualToString:@""]){
        
    }else{
        
        if(![CMTool isConnectionAvailable]){
            [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        }else{
            NSDictionary *params = @{
                                     @"key":searchText,
                                     @"type":@(0),
                                     @"limit":@(5),
                                     };
            [CMAPI postUrl:API_MOVIE_FUZZY_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
                
                id result = [detailDict objectForKey:@"code"];
                if(succeed){
                    [self.startResult removeAllObjects];
                    [self.movieResult removeAllObjects];
                    [self.goodResult removeAllObjects];
                    [self.resultList removeAllObjects];
                    NSLog(@"%@",detailDict);
                    // 电影
                    NSArray *movieArray = [FilmDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"movie"]];
                    
                    FilmDetailModel *fileModel = [movieArray lastObject];
                    if (![fileModel.movieId isEqualToString:@""]) {
                        [self.movieResult addObjectsFromArray:movieArray];
                    }
                    // 明星
                    NSArray *starArray = [StarDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"star"]];
                    StarDetailModel *starModel = [starArray lastObject];
                    if (![starModel.starId isEqualToString:@""]) {
                        [self.startResult addObjectsFromArray:starArray];
                    }
                    // 商品
                    NSArray *goodArray = [GoodDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"good"]];
                    GoodDetailModel *goodModel = [goodArray lastObject];
                    if (![goodModel.goodId isEqualToString:@""]) {
                        [self.goodResult addObjectsFromArray:goodArray];
                    }
                    if (self.movieResult.count>0) {
                        [self.resultList addObjectsFromArray:self.movieResult];
                    }
                    if (self.startResult.count>0) {
                        [self.resultList addObjectsFromArray:self.startResult];
                    }
                    if (self.goodResult.count>0) {
                        [self.resultList addObjectsFromArray:self.goodResult];

                    }
                    
                    [self.tableView reloadData];
                    
                  }else{
                    
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
    
    
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.resultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
 
    NSObject *object = self.resultList[indexPath.row];
    if ([object isKindOfClass:[FilmDetailModel class]]) {
        static NSString *cellId = @"filmId";
        MyCollectionFilmTableViewCell *cell = (MyCollectionFilmTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            
            cell = [[MyCollectionFilmTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColor =   [UIColor colorWithHexString:@"ededed"];
            
        }
        FilmDetailModel *modle = self.resultList[indexPath.row];
        cell.film = modle;
        return cell;
     }
    else if ([object isKindOfClass:[StarDetailModel class]]) {

        static NSString *starId = @"starId";
        MyCollectionStartTableViewCell *cell = (MyCollectionStartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:starId];
        if (cell == nil) {
            
            cell = [[MyCollectionStartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:starId];
            cell.backgroundColor =   [UIColor colorWithHexString:@"ededed"];
            
        }
        StarDetailModel *model = self.resultList[indexPath.row];
        cell.star = model;
        return cell;
    }else if ([object isKindOfClass:[GoodDetailModel class]])
    {
        static NSString *goodId = @"goodId";
        MyCollectionGoodsTableViewCell *cell = (MyCollectionGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:goodId];
        if (cell == nil) {
            
            cell = [[MyCollectionGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodId];
            cell.backgroundColor =   [UIColor colorWithHexString:@"ededed"];
            
        }
        GoodDetailModel *model = self.resultList[indexPath.row];
        cell.good = model;
        return cell;
    }
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scroll)]) {
        [self.delegate scroll];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *object = self.resultList[indexPath.row];
    if ([object isKindOfClass:[FilmDetailModel class]]) {
        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FilmDetailViewController *vc = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
        FilmDetailModel *modle = self.resultList[indexPath.row];
        vc.strID = modle.movieId;
        [self.navigationController pushViewController:vc animated:YES];
        [self.delegate coverClick];
        
    }else if ([object isKindOfClass:[StarDetailModel class]]) {
        
        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FilmStarsDetailViewController *vc = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
        StarDetailModel *modle = self.resultList[indexPath.row];
        vc.strID =modle.starId;
        [self.navigationController pushViewController:vc animated:YES];
       [self.delegate coverClick];
    }else if ([object isKindOfClass:[GoodDetailModel class]]) {
 
        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DressDetailViewController *vc = [View instantiateViewControllerWithIdentifier:@"dressDetail"];
        GoodDetailModel *modle = self.resultList[indexPath.row];
        vc.strID =modle.goodId;
        [self.navigationController pushViewController:vc animated:YES];
        [self.delegate coverClick];
    }

    
}



@end
