//
//  SearchResultViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/8/5.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "SearchResultViewController.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "CMAPI.h"
#import "FilmDetailModel.h"
#import "UIColor+Extensions.h"
#import "MyCollectionFilmTableViewCell.h"
#import "FilmDetailViewController.h"
@interface SearchResultViewController ()
@property (nonatomic, strong) NSMutableArray *resultCities;


@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w =[UIScreen mainScreen].bounds.size.width;
    CGFloat rate = w / 320;
    self.tableView.rowHeight = 110 *rate;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSMutableArray *)resultCities
{
    if (_resultCities == nil) {
        _resultCities = [NSMutableArray array];
    }
    return _resultCities;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    searchText = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(searchText.length <=0 && [searchText isEqualToString:@""]){
    
        }else{
    
            if(![CMTool isConnectionAvailable]){
    
                [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
            }else{
               NSDictionary *params = @{
                                         @"key":searchText,
                                         @"type":@(1),
                                         @"limit":@(5),
                                         };
                [CMAPI postUrl:API_MOVIE_FUZZY_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
    
                    id result = [detailDict objectForKey:@"code"];
                    if(succeed){
    
                    [self.resultCities removeAllObjects];
                     NSArray *array = [FilmDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"movie"]];
                        FilmDetailModel *model = [array lastObject];
                        if (![model.movieId isEqualToString:@""]) {
                            [self.resultCities addObjectsFromArray:array];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(scroll)]) {
        [self.delegate scroll];
    }
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"reuseIdentifier";
    MyCollectionFilmTableViewCell *cell = (MyCollectionFilmTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[MyCollectionFilmTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    }
    FilmDetailModel *model = self.resultCities[indexPath.row];
    cell.film = model;
    
    return cell;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"共有%ld个搜索结果", self.resultCities.count];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilmDetailModel *model = self.resultCities[indexPath.row];
    
    NSString *filmId = model.movieId;
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilmDetailViewController *filmDetailView = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
    filmDetailView.strID = filmId;
    //    [self presentViewController:filmDetailView animated:YES completion:nil];
    [self.navigationController pushViewController:filmDetailView animated:YES];
    [self.delegate coverClick];

}

@end
