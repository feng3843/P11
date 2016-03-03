//
//  GoodsViewController.h
//  NewCut
//
//  Created by MingleFu on 15/8/4.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertistingColumn.h"
#import "DressDetailViewController.h"
#import "MJRefresh.h"
#import "UIViewController+Puyun.h"
#import "GoodsViewController.h"
typedef enum {
    GoodsTypeBag,
    GoodsTypeShoes,
    GoodsTypePeijian,
    GoodsTypeAccessory,
    GoodsTypeDress
}GoodsType;

@interface GoodsViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    AdvertistingColumn *headView;
    NSMutableArray *bagContent;
    
}

@property(nonatomic,copy)NSString *type;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *bagImages;
@property (strong, nonatomic) NSArray *bagNames;
@property (strong,nonatomic) DressDetailViewController *dressDetailView;
@end
