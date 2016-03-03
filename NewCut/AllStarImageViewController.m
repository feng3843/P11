//
//  AllStarImageViewController.m
//  NewCut
//
//  Created by py on 15-7-28.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "AllStarImageViewController.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"

@interface AllStarImageViewController ()

@end

@implementation AllStarImageViewController
@synthesize AllStarImage,starID;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 30, 23, 23)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    
    //backBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    [AllStarImage registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    starPhotoDic = [[NSDictionary alloc]init];
    starPhotoArray = [[NSMutableArray alloc]init];
    starImageArray = [[NSMutableArray alloc]init];

    [self.AllStarImage reloadData];
    [self getAllStarImageView];
    // Do any additional setup after loading the view.
}

-(void)closeView{
    
    //[SVProgressHUD showInfoWithStatus:@"wwwwww"];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

//获取所有图片
-(void)getAllStarImageView
{
    
    NSString *ID = self.starID;
    int Id = [ID intValue];
    
    NSDictionary *params = @{
                             @"starId":@(Id)
                             };
    
    
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showErrorWithStatus:DEFAULT_NO_WEB];
        
    }else{
        
        [CMAPI postUrl:API_MOVIE_GETALLPHOTOBYSTARID Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                
                starPhotoDic = [detailDict objectForKey:@"result"];
                starPhotoArray = [starPhotoDic objectForKey:@"star"];
                
                for(int i=0;i<starPhotoArray.count;i++){
                    
                    NSString *path = [starPhotoArray[i] objectForKey:@"starImagePath"];
                    NSString *url = [CMRES_BaseURL stringByAppendingString:path];
                    [starImageArray addObject:url];
                    NSLog(@"%@",@"ffdfrggggggg");
                    NSLog(@"%@",url);
                    NSLog(@"%@",@"ffdfrggggggg");
                    
                }
                
                [self.AllStarImage reloadData];
                
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
    return starImageArray.count;
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
    UILabel *clothName;
    static NSString *CellIdentifier = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    // cell.backgroundColor = [UIColor whiteColor];
    [cell sizeToFit];
    
    clothImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 105, 105)];
   
    NSString *url = [starImageArray objectAtIndex:indexPath.row];
    // NSString *newUrl = [CMRES_BaseURL stringByAppendingString:url];
    NSURL *filmurl=[NSURL URLWithString:url];
    [clothImageView setImageWithURL:filmurl refreshCache:NO placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_JUZHAO]];
    
    
    //[clothImageView setImage:[DressImages objectAtIndex:indexPath.row]];
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
