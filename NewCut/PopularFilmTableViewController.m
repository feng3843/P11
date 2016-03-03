//
//  PopularFilmTableViewController.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

#import "PopularFilmTableViewController.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "PopularFilmCell.h"
#import "SDImageView+SDWebCache.h"
#import "FilmDetailModel.h"
#import "MyCollectionFilmTableViewCell.h"
@interface PopularFilmTableViewController ()

@end

@implementation PopularFilmTableViewController
@synthesize CareFilmTable,dataArray,keys,filmDetailView,dataSources,content,filmList,filmNameDataList,TimeList,starList,thisWeekContent,thisWeekDataSource,thisWeekFilmList,thisWeekFilmNameList,thisWeekStarList;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    
    keys = [[NSArray alloc] initWithObjects:@"最受关注", @"本周上映", nil];
    self.CareFilmTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h - 64)];
    
    dataSources = [[NSDictionary alloc]init];
//    content = [[NSMutableArray alloc]init];
    filmList = [[NSMutableArray alloc]init];
 
    thisWeekFilmList = [[NSMutableArray alloc]init];
    
    CareFilmTable.dataSource = self;
    CareFilmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    CareFilmTable.delegate = self;
    CareFilmTable.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:CareFilmTable];
    [self reloadData];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:line];
    
    [self getMostConcernFilmList];

}


-(void)getMostConcernFilmList
{
    
    if(![CMTool isConnectionAvailable]){
    
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        
        NSDictionary *params = @{
                                 @"type":@"最受关注",
                                 @"order":@(0),
                                 @"limit":@(5),
                                 };
        [CMAPI postUrl:API_MOVIE_PAGE_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
         
            id result = [detailDict objectForKey:@"code"];
//            NSLog(@"%@",detailDict);
            if(succeed){
          [filmList addObjectsFromArray: [FilmDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"mostPopularMovie"]]];
                
        [thisWeekFilmList addObjectsFromArray: [FilmDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"weekMovie"]]];
                
//                [content addObjectsFromArray:filmList];
//                [content addObjectsFromArray:thisWeekFilmList];
              
                [self reloadData];

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

-(void)getOutThisWeekFilmList
{
    
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        [CMAPI postUrl:API_MOVIE_GETHOST_GETOUTTHISWEEK Param:nil Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                thisWeekDataSource = [detailDict objectForKey:@"result"];
                thisWeekContent = [thisWeekDataSource objectForKey:@"movie"];
                
                for (int i=0; i< thisWeekContent.count; i++) {
                    NSString *filmName = [thisWeekContent[i] objectForKey:@"movieName"];
                    NSString *filmYear = [thisWeekContent[i] objectForKey:@"movieYear"];
                    NSString *filmDirector = [thisWeekContent[i] objectForKey:@"director"];
                    NSString *joinStar = [thisWeekContent[i] objectForKey:@"stars"];
                    NSString *Path = [thisWeekContent[i] objectForKey:@"moviePhoto"];
                    NSString *newUrl = [CMRES_BaseURL stringByAppendingString:Path];
                    
                    [thisWeekFilmNameList addObject:filmName];
                    [thisWeekStarList addObject:joinStar];
                    //[TimeList addObject:filmYear];
                    //[starList addObject:joinStar];
                    
                }
                
                [self.thisWeekFilmList insertObjects:thisWeekContent atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, thisWeekContent.count)]];
                [self reloadData];
                
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

-(void)reloadData
{
    [self.CareFilmTable reloadData];
    //[self flushLoadingMoreFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//指定某个分区有多少行，默认位1
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n ;
    if(section == 0){
    
        n = [filmList count];
    }else if (section == 1){
    
        n = [thisWeekFilmList count];
    }
    
    return n;
   
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
  
    return 110 * (w/CELL_CONTENT_WIDTH);
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return [keys objectAtIndex:section];

}

//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(section == 0){
//        return 30;
//    
//    }
//    return 20;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat rate = w / CELL_CONTENT_WIDTH;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 36 *rate)];
    //ededed
    headView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(16 *rate, 0, 65 *rate, 36 *rate)];
    title.textColor = [UIColor colorWithHexString:@"666666"];
    title.font = [UIFont systemFontOfSize:16];
    if(section == 0){
        title.text = @"最受关注";
        
    }else{
        
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 304, 0.5)];
//        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [headView addSubview:line];
        title.text = @"本周上映";
    }
    
    [headView addSubview:title];
    return headView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}


// 指定有多少个分区，默认是一个
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [keys count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    MyCollectionFilmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MyCollectionFilmTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
    }
    if(indexPath.section == 0){
        FilmDetailModel *model = filmList[indexPath.row];
        cell.film = model;
        
    }else{
        FilmDetailModel *model = thisWeekFilmList[indexPath.row];
        cell.film = model;
    }
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//
    FilmDetailModel *model = [[FilmDetailModel alloc]init];
    if(indexPath.section == 0){
     model = filmList[indexPath.row];
   }else{
     model = thisWeekFilmList[indexPath.row];
  }
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   filmDetailView = [View instantiateViewControllerWithIdentifier:@"filmDetailViewId"];
    filmDetailView.strID = model.movieId;
    
    [self.navigationController pushViewController:filmDetailView animated:YES];

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
