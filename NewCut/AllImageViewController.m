//
//  AllImageViewController.m
//  NewCut
//
//  Created by py on 15-7-28.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "AllImageViewController.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"

@interface AllImageViewController ()

@end

@implementation AllImageViewController
@synthesize  AllImageView,filmId;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    CGFloat h=[UIScreen mainScreen].bounds.size.height;
//    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 30, 23, 23)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    
    //backBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    //AllImageView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, w, h) collectionViewLayout:flowLayout];
   // AllImageView.delegate = self;
    //AllImageView.dataSource = self;
    //AllImageView.showsVerticalScrollIndicator = NO;
   // AllImageView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [AllImageView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   // [self.view addSubview:AllImageView];
    
    DressImages = @[[UIImage imageNamed:@"11.jpg"],
                    [UIImage imageNamed:@"12.jpg"],
                    [UIImage imageNamed:@"13.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"15.jpg"],[UIImage imageNamed:@"16.jpg"]];
    
    filmPhotoDic = [[NSDictionary alloc]init];
    filmPhotoArray = [[NSMutableArray alloc]init];
    filmImageArray = [[NSMutableArray alloc]init];
    
    [self.AllImageView reloadData];
    [self getAllImageView];

    // Do any additional setup after loading the view.
}

//获取所有图片
-(void)getAllImageView
{
    
    NSString *ID = self.filmId;
    int Id = [ID intValue];
    
    NSDictionary *params = @{
                             @"movieId":@(Id)
                             };

    
    if(![CMTool isConnectionAvailable]){
    
        [SVProgressHUD showErrorWithStatus:DEFAULT_NO_WEB];
        
    }else{
    
        [CMAPI postUrl:API_MOVIE_GETALLPHOTOBYMOVIEID Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
            
                filmPhotoDic = [detailDict objectForKey:@"result"];
                filmPhotoArray = [filmPhotoDic objectForKey:@"movie"];
                
                for(int i=0;i<filmPhotoArray.count;i++){
                    
                    NSString *path = [filmPhotoArray[i] objectForKey:@"movieImagePath"];
                    NSString *url = [CMRES_BaseURL stringByAppendingString:path];
                    [filmImageArray addObject:url];
                
                }
                
                [self.AllImageView reloadData];
                
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

-(void)closeView{
    
    //[SVProgressHUD showInfoWithStatus:@"wwwwww"];
    [self dismissViewControllerAnimated:NO completion:nil];
   
    
}

//滑动事件处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint point=scrollView.contentOffset;
    if(point.y>0)
    {
        //[loadMoreTableFooterView loadMoreScrollViewDidScroll:scrollView];
        //backToTop.hidden = YES;
        
    }
    if(point.y<0)
    {
        //[egoRefreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
        //backToTop.hidden = NO;
        
    }
}

//
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    if(!self.islock)
//    {
//        CGPoint point=scrollView.contentOffset;
//        if(point.y>0)
//        {
//            //[loadMoreTableFooterView loadMoreScrollViewDidEndDragging:scrollView];
//        }
//        if(point.y<0)
//        {
//            //[egoRefreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
//        }
//        if(isRefreshing||isLoadMoreing)
//            self.islock=YES;
//    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return filmImageArray.count;
}

-(UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(0, 0, 2.5, 2.5);//上，左，下，右
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize size = CGSizeMake(105, 105);
    
    return size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImageView *clothImageView ;
    static NSString *CellIdentifier = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   // cell.backgroundColor = [UIColor whiteColor];
    [cell sizeToFit];
    
    clothImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 105, 105)];
    
     NSString *url = [filmImageArray objectAtIndex:indexPath.row];
    // NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
     NSURL *filmurl=[NSURL URLWithString:url];
    [clothImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_JUZHAO]];
    [cell addSubview:clothImageView];
    
    return cell;
}

//定义每个cell的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

//UICollectionView被选择中调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    self.dressDetailView = [View instantiateViewControllerWithIdentifier:@"dressDetail"];
//    
    
}

//返回这个cell是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
