//
//  MyCollectionImageViewController.m
//  NewCut
//
//  Created by 夏雪 on 15/7/31.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "MyCollectionImageViewController.h"
#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "PYAllCommon.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "DataBaseTool.h"
@interface MyCollectionImageViewController ()
@property (nonatomic, strong) NSMutableArray *srcStringArray;
@property (nonatomic, assign) int currentPage;
@property(nonatomic ,weak)UIScrollView *bgScrollView;

@property(nonatomic ,weak)UIView *noNumView;
@end

@implementation MyCollectionImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *bgView = [[UIScrollView alloc]init];
    bgView.frame = self.view.frame;
    [self.view addSubview:bgView];
    self.bgScrollView = bgView;
    
    self.view.backgroundColor =  [UIColor colorWithHexString:@"ededed"];
    
    self.srcStringArray = [NSMutableArray array];
    
    
    UIView *noNumView = [[UIView alloc]initWithFrame:CGRectMake(0, -20,self.view.frame.size.width , self.view.frame.size.height)];
    noNumView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    UILabel *lable = [[UILabel alloc]init];
    
    lable.frame = CGRectMake(0, 40,self.view.frame.size.width ,13);
    [noNumView addSubview:lable];
    lable.text = @"您还没有任何收藏哦";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorWithHexString:@"999999"];
    lable.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:noNumView];
    self.noNumView = noNumView;
    self.noNumView.hidden = YES;
    [self newCollectImage];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newCollectImage
{
    self.currentPage ++;
  
    [self.srcStringArray addObjectsFromArray: [DataBaseTool collectImages:self.currentPage]];

     SDPhotoGroup *photoGroup = [[SDPhotoGroup alloc] init];
                
     NSMutableArray *temp = [NSMutableArray array];
     [_srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
         SDPhotoItem *item = [[SDPhotoItem alloc] init];
         item.thumbnail_pic = src;
         [temp addObject:item];
        }];
                
       photoGroup.photoItemArray = [temp copy];
   
                //                self.bgScrollView.backgroundColor = [UIColor redColor];
        [self.bgScrollView addSubview:photoGroup];
    
    if (self.srcStringArray.count <= 0) {
        self.noNumView.hidden = NO;
        
    }else
    {
        self.noNumView.hidden = YES;
    }
    
    CGFloat count = 0.0f;
    if (self.srcStringArray.count % 3) {
        count = self.srcStringArray.count / 3 + 2;
    }else
    {
        count = self.srcStringArray.count / 3 + 1;
    }
     photoGroup.frame = CGRectMake(0, 0, fDeviceWidth, count * 107.5);
    self.bgScrollView.contentSize = CGSizeMake(0,count * 107.5 + 10);
    self.bgScrollView.showsVerticalScrollIndicator = NO;
//    self.bgScrollView.backgroundColor = [UIColor redColor];
 }

@end
