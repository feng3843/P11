//
//  ImageBrowseController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/31.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ImageBrowseController.h"
#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"

#import "ContactsNavViewController.h"
@interface ImageBrowseController ()
{
    BOOL preNaviHidden;
}
@property (nonatomic, strong) NSMutableArray *srcStringArray;

@property(nonatomic ,weak)UIScrollView *bgScrollView;
@end

@implementation ImageBrowseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *bgView = [[UIScrollView alloc]init];
    bgView.frame = self.view.frame;
    [self.view addSubview:bgView];
    self.bgScrollView = bgView;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"bt_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(16, 20, 23, 23);
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backBtn];
    
//    self.bgScrollView.contentOffset = CGPointMake(0, 20);
    self.view.backgroundColor =  [UIColor colorWithHexString:@"ededed"];
 
    self.srcStringArray = [NSMutableArray array];
    [self getAllImageView];
    
    preNaviHidden = self.navigationController.navigationBarHidden;
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"NO_LOGIN" object:nil];
//    self.bgScrollView.backgroundColor = [UIColor redColor];
}


- (void)login
{
    [self noLogin];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
//        self.bgScrollView.contentOffset = CGPointMake(0,20);
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = preNaviHidden;
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取所有图片
-(void)getAllImageView
{
    
    NSString *ID = self.ImageId;
    int Id = [ID intValue];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *url = @"";
    if (self.type == 0) {
        params[@"movieId"] = @(Id);
        url = API_MOVIE_GETALLPHOTOBYMOVIEID;
    }else if (self.type == 1)
    {
        params[@"starId"] = @(Id);
        url = API_MOVIE_GETALLPHOTOBYSTARID;
    }else if (self.type == 2)
    {
        params[@"GoodId"] = @(Id);
        url = API_MOVIE_GETALLPHOTOBYGOODID;
    }else
    {
        return;
    }
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:DEFAULT_NO_WEB];
        
    }else{
        
        [CMAPI postUrl:url Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
            
            id result = [detailDict objectForKey:@"code"];
            if(succeed){
                NSString *http = CMRES_BaseURL;
                
                [self.srcStringArray removeAllObjects];
                NSMutableDictionary *photoDic = [NSMutableDictionary dictionary];
                NSMutableArray *photoArray = [NSMutableArray array];
                if (self.type == 0) {
                    photoDic = [detailDict objectForKey:@"result"];
                    photoArray = [photoDic objectForKey:@"movie"];
                    for(int i=0;i<photoArray.count;i++){
                        
                        NSString *path = [photoArray[i] objectForKey:@"movieImagePath"];
                        NSString *path2 = [CMRES_BaseURL    stringByAppendingPathComponent:path];
                       [self.srcStringArray addObject:path2];
                        
                    }
                    
                }else if (self.type ==1)
                { photoDic = [detailDict objectForKey:@"result"];
                    photoArray = [photoDic objectForKey:@"star"];
                    for(int i=0;i<photoArray.count;i++){
                        
                        NSString *path = [photoArray[i] objectForKey:@"starImagePath"];
                        NSString *path2 = [CMRES_ImageURL    stringByAppendingPathComponent:path];
                        [self.srcStringArray addObject:path2];
                        
                    }
                    
                }else if (self.type == 2)
                {
                    photoDic = [detailDict objectForKey:@"result"];
                    photoArray = [photoDic objectForKey:@"good"];
                    for(int i=0;i<photoArray.count;i++){
                        
                        NSString *path = [photoArray[i] objectForKey:@"goodImagePath"];
                        NSString *path2 = [CMRES_BaseURL    stringByAppendingPathComponent:path];
                        [self.srcStringArray addObject:path2];
                        
                    }
                }
               
             
                SDPhotoGroup *photoGroup = [[SDPhotoGroup alloc] init];
                
                NSMutableArray *temp = [NSMutableArray array];
                [_srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
                    SDPhotoItem *item = [[SDPhotoItem alloc] init];
                    item.thumbnail_pic = src;
                    [temp addObject:item];
                }];
                
                photoGroup.photoItemArray = [temp copy];
             
//                self.bgScrollView.backgroundColor = [UIColor redColor];
          
                CGFloat count = 0.0f;
                if (self.srcStringArray.count % 3) {
                    count = self.srcStringArray.count / 3 + 2;
                }else
                {
                    count = self.srcStringArray.count / 3 + 1;
                }
                 photoGroup.frame = CGRectMake(0, -20, fDeviceWidth, count * 107.5 + 30);
                [self.bgScrollView addSubview:photoGroup];
                self.bgScrollView.contentSize = CGSizeMake(0,count * 107.5 + 30);
                self.bgScrollView.showsVerticalScrollIndicator = NO;
                
                
                
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




@end
