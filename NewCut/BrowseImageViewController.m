//
//  BrowseImageViewController.m
//  NewCut
//
//  Created by uncommon on 2015/07/22.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "BrowseImageViewController.h"

@interface BrowseImageViewController ()

@property (nonatomic) NSMutableArray *arrayMutable;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollection;

@end

@implementation BrowseImageViewController

#pragma mark- init

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.arrayMutable)
    {
        self.arrayMutable = [NSMutableArray arrayWithCapacity:20];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [self initPhotoInfo];
}

/** @brief 初始化照片信息 */
-(void)initPhotoInfo{
    [self.arrayMutable removeAllObjects];
    [self searchCart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//查找数据,把查到的数据显示在界面上
- (void)searchCart
{
//    while (sqlite3_step(statement) == SQLITE_ROW) {
//            notFound = NO;
//            //char *Id=(char *)sqlite3_column_text(statement, 0);
//            char *ImagePath=(char *)sqlite3_column_text(statement, 1);
//            
//            NSString* strImagePath=[NSString stringWithFormat:@"%s",ImagePath];
//            // 是否是本地图片?
//            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init] ;
//            [lib assetForURL:[NSURL URLWithString:strImagePath] resultBlock:^(ALAsset *asset)
//             {
//                 // 使用asset来获取本地图片
//                 ALAssetRepresentation *assetRep = [asset defaultRepresentation];
//                 CGImageRef imgRef = [assetRep fullResolutionImage];
//                 UIImage* avatarImage = [UIImage imageWithCGImage:imgRef
//                                                            scale:assetRep.scale
//                                                      orientation:(UIImageOrientation)assetRep.orientation];
//                 
//                 [self.arrayMutable addObject:avatarImage];
//                 [self reloadData];
//             }
//                failureBlock:^(NSError *error)
//             {
//                 // 访问库文件被拒绝,则直接使用默认图片
//                 
//             }
//             ];
//            
//        }
    
    
}

//-(void)listAddress
//{
//    NSString* userId = [CMData getUserID];
//    
//    if (!userId) {
//        return;
//    }
//    
//    // 获取参数
//    NSMutableDictionary *params =[self getParam4AddressList];
//    
//    //[CMAPI postUrl:API_LIST_ADDRESS Param:@{@"userId":userId} Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//    [CMAPI postUrl:API_LIST_ADDRESS Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//        if (succeed)
//        {
//            [self.arrayMutable removeAllObjects];
//            NSDictionary* result = [detailDict objectForKey:RESULT];
//            NSArray* array = [result objectForKey:LIST];
//            PYAddress* address;
//            for (NSDictionary* dic in array) {
//                address = [[PYAddress alloc] init];
//                address.strId = [dic objectForKey:@"id"];
//                address.strUserId = [dic objectForKey:@"userId"];
//                address.strAddress = [dic objectForKey:@"address"];
//                address.strName = [dic objectForKey:@"name"];
//                address.strPhoneNum = [dic objectForKey:@"tel"];
//                address.strPostCode = [dic objectForKey:@"post"];
//                address.strCity = [dic objectForKey:@"city"];
//                [self.arrayMutable addObject:address];
//            }
//            [self reloadData];
//        }
//    }];
//}

/**
 * @brief 获取参数
 *
 * @param
 */
-(NSMutableDictionary *)getParam4AddressList{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
    // 用户ID
//    [params setValue:[CMData getUserID] forKey:@"userId"];
//    // token
//    [params setValue:[CMData getToken] forKey:@"token"];
    
    return params;
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
