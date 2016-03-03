//
//  AllStarSearchResultViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/8/6.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "AllStarSearchResultViewController.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "CMAPI.h"
#import "StarDetailModel.h"
#import "UIColor+Extensions.h"
#import "MyCollectionStartTableViewCell.h"
#import "FilmStarsDetailViewController.h"
#import "PYAllCommon.h"

@interface AllStarSearchResultViewController ()
@property (nonatomic, strong) NSMutableArray *resultCities;

@end

@implementation AllStarSearchResultViewController

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
    
                [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
            }else{
                NSDictionary *params = @{
                                         @"key":searchText,
                                         @"type":@(2),
                                         @"limit":@(5),
                                         };
                [CMAPI postUrl:API_MOVIE_FUZZY_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
    
                    id result = [detailDict objectForKey:@"code"];
                    if(succeed){
                        [self.resultCities removeAllObjects];
                         NSArray *array = [StarDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"star"]];
                        StarDetailModel *model = [array lastObject];
                        if (![model.starId isEqualToString:@""]) {
                            [self.resultCities addObjectsFromArray:array];
                        }
                        [self.tableView  reloadData];
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
    // 明星
    MyCollectionStartTableViewCell *cell = (MyCollectionStartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[MyCollectionStartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor =   [UIColor colorWithHexString:@"ededed"];
        
    }
    StarDetailModel *model = self.resultCities[indexPath.row];
    cell.star = model;
    return cell;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"共有%ld个搜索结果", self.resultCities.count];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StarDetailModel *model = self.resultCities[indexPath.row];
    NSString *Id = model.starId;
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilmStarsDetailViewController *filmStarDetailView = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
    filmStarDetailView.strID = Id;
 
    [self.navigationController pushViewController:filmStarDetailView animated:YES];
    [self.delegate coverClick];

}


@end
