//
//  GoodsViewController.m
//  NewCut
//
//  Created by MingleFu on 15/8/4.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodsViewController.h"

#import "PYAllCommon.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "SDImageView+SDWebCache.h"
#import "GoodDetailModel.h"
#import "CommodityDetailsView.h"
#import "MJExtension.h"
#import "ADModel.h"
@interface GoodsViewController ()
@property(nonatomic ,assign)int page;
@property(nonatomic ,strong)NSMutableArray *imageArray;
@end

@implementation GoodsViewController
@synthesize bagImages,bagNames,dressDetailView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getImageList];
    /*
     ***广告栏
     */
//    NSArray *imgArray = [NSArray arrayWithObjects:@"18.jpg",@"19.jpg",@"20.jpg",@"21.jpg",@"22.jpg",@"23.jpg", @"24.jpg",@"25.jpg",nil];
//    
    headView = [[AdvertistingColumn alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 168 * rateH)];
    self.view.backgroundColor =[UIColor colorWithHexString:@"eaeaea"];
        headView.backgroundColor = [UIColor blueColor];
//    [headView setArray:imgArray];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, 168 *rateH);//头部
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight -100) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommodityDetailsView" bundle:nil] forCellWithReuseIdentifier:@"peiJianId"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    
    
    UIButton *backToTop = [[UIButton alloc]initWithFrame:CGRectMake((fDeviceWidth - 16 -36)*rateW, (fDeviceHeight - 150) *rateW, 36, 36)];
    
    [backToTop setBackgroundImage:[UIImage imageNamed:@"backtop"] forState:UIControlStateNormal];
    
    [backToTop addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backToTop];
    
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    
    bagContent = [[NSMutableArray alloc]init];
    
    [self setupRefresh];
    
    // Do any additional setup after loading the view.
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.collectionView.headerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_DOWN_TO_REFRESH, @"");
    self.collectionView.headerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_REFRESH, @"");
    self.collectionView.headerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING, @"");
    
    self.collectionView.footerPullToRefreshText = NSLocalizedString(DEFAULT_STR_PULL_UP_TO_LOAD_MORE, @"");
    self.collectionView.footerReleaseToRefreshText = NSLocalizedString(DEFAULT_STR_RELEASE_TO_LOAD_MORE, @"");
    self.collectionView.footerRefreshingText = NSLocalizedString(DEFAULT_STR_LOADING_MORE, @"");
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.page = 1;
  [self getGoodsListByTopic:self.type];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
    });
}

- (void)footerRereshing
{
    self.page ++ ;
 [self getGoodsListByTopic:self.type];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self reloadData];
    });
}

-(void)reloadData
{
    [self.collectionView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
}

//列表返回顶部
-(void)backToTop
{
    
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
}
//
//显示头部内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:
                                      UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [view addSubview:headView];//头部广告栏
    return view;
    
}

- (void)setType:(NSString *)type
{
    _type = type;
    [self getGoodsListByTopic:type];
}
//根据商品类别查询商品列表
-(void)getGoodsListByTopic:(NSString *)type
{
    if([type isEqualToString:@""]||self.page == 0)return;
    NSDictionary *params = @{
                             @"topicId":type,
                             @"p":@(self.page),
                             @"limit":@(5)
                             };
//    NSLog(@"%@",params);
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showErrorWithStatus:DEFAULT_NO_WEB];
    }else{
        
        [CMAPI postUrl:API_GOOD_GETALLPHOTOBYTOPIC Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                if(self.page == 1)
                {
                    [bagContent removeAllObjects];
                }
                
                [bagContent addObjectsFromArray:[GoodDetailModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"good"]]];
                
                
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


- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (void)getImageList
{
    
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
    }else{
        NSDictionary *param = @{@"name":@"商品"};
        [CMAPI postUrl:API_ADPHOTO Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            //NSString* strCode = [NSString stringWithFormat:@"%@",result];
            
            if(succeed){
                
                [self.imageArray removeAllObjects];
                [self.imageArray addObjectsFromArray:[ADModel objectArrayWithKeyValuesArray:[[detailDict objectForKey:@"result"] objectForKey:@"advertisement"]]];
                [headView setArray:self.imageArray];
                
            }else{
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



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return bagContent.count;
}


-(UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(18, 0, 0, 0);
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    CGSize size = CGSizeMake(fDeviceWidth, 290 *rateH);
    
    return size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    CommodityDetailsView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"peiJianId" forIndexPath:indexPath];
    GoodDetailModel *model = bagContent[indexPath.row];
    //    cell.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
    cell.good = model;
    
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
    
    UIStoryboard *View = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.dressDetailView = [View instantiateViewControllerWithIdentifier:@"dressDetail"];
    GoodDetailModel *model = bagContent[indexPath.row];
   self.dressDetailView.strID = model.goodId;
    
    [self.navigationController pushViewController:self.dressDetailView animated:YES];
    
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