//
//  PopularStarsViewController.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PopularStarsViewController.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "StarDetailModel.h"
#import "MyCollectionStartTableViewCell.h"
@interface PopularStarsViewController ()

@end

@implementation PopularStarsViewController

@synthesize popularStarsTableView,keys,filmStarDetailView,mostConcernStar,fashionStar,fashionContent,mostConcernList,fashionList;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    keys = [[NSArray alloc] initWithObjects:@"最受关注", @"时尚新秀", nil];
    
    self.popularStarsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h - 64)];
    mostConcernStar = [[NSDictionary alloc]init];
    fashionStar = [[NSDictionary alloc]init];

    fashionContent = [[NSMutableArray alloc]init];
    mostConcernList = [[NSMutableArray alloc]init];
    fashionList = [[NSMutableArray alloc]init];

    popularStarsTableView.delegate = self;
    popularStarsTableView.dataSource = self;
    popularStarsTableView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:popularStarsTableView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:line];
    
    [self reloadData];
    [self getMostConcernStarList];

    //PopularStarsTableView.
    // Do any additional setup after loading the view.
}

-(void)getMostConcernStarList{
    
    if(![CMTool isConnectionAvailable]){
    
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        NSDictionary *params = @{
                                 @"type":@"最受关注",
                                 @"order":@(0),
                                 @"limit":@(5),
                                 };
        [CMAPI postUrl:API_STAR_PAGE_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
          
                
                [fashionList addObjectsFromArray: [StarDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"mostPopularStar"]]];
                
                [fashionContent addObjectsFromArray: [StarDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"Fashionistas"]]];
//                
//              
//                [mostConcernList addObjectsFromArray:fashionList];
//                [mostConcernList addObjectsFromArray:fashionContent];
                
                
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

-(void)getFashionStarList
{
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        
        NSDictionary *params = @{
                                 @"type":@"最受关注",
                                 @"order":@(0),
                                 @"limit":@(5),
                                 };
        [CMAPI postUrl:API_STAR_PAGE_SEARCH Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                fashionStar = [detailDict objectForKey:@"result"];
                fashionContent = [fashionStar objectForKey:@"star"];
                for(int i=0;i<fashionContent.count;i++){
                    
                    
                    
                }
                
                [self.fashionList insertObjects:fashionContent atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, fashionContent.count)]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//指定某个分区有多少行，默认位1
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n ;
    if(section == 0){
        
        n = [fashionList count];
    }else if (section == 1){
        
        n = [fashionContent count];
    }
    
    return n;
}

-(void)reloadData
{
    [self.popularStarsTableView reloadData];
    //[self flushLoadingMoreFrame];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [keys objectAtIndex:section];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    return 110 * (w/320);

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [keys count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    return 40 * (w/320);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 40*h/568)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(16*h/568, 0*h/568, 65*h/568, 40*h/568)];
    title.textColor = [UIColor colorWithHexString:@"666666"];
    title.font = [UIFont systemFontOfSize:16*h/568];
    if(section == 0){
        
        title.text = @"最受关注";
       
    
    }else{
    
//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(16*h/568, 0, 304*h/568, 0.5)];
//        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [headView addSubview:line];
        title.text = @"时尚新秀";
    }
    
    [headView addSubview:title];
    return headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    MyCollectionStartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MyCollectionStartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    if(indexPath.section == 0){
        StarDetailModel *model = fashionList[indexPath.row];
        cell.star = model;
        
    }else{
        StarDetailModel *model = fashionContent[indexPath.row];
        cell.star = model;
    }
   
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(indexPath.section == 0){
        StarDetailModel *model = fashionList[indexPath.row];
        filmStarDetailView = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
        filmStarDetailView.strID = model.starId;
        [self.navigationController pushViewController:filmStarDetailView animated:YES];
        
    }else{
        StarDetailModel *model = fashionContent[indexPath.row];
        filmStarDetailView = [View instantiateViewControllerWithIdentifier:@"FilmStarDetail"];
        filmStarDetailView.strID = model.starId;
        [self.navigationController pushViewController:filmStarDetailView animated:YES];
    }



    
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
