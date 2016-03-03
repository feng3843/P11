//
//  DressViewController.m
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DressViewController.h"
#import "PYAllCommon.h"
#import "GoodsCollectionCell.h"
#import "CMAPI.h"
#import "CMTool.h"
#import "SDImageView+SDWebCache.h"
#import "GoodDetailModel.h"
#import "CommodityDetailsView.h"
#import "MJExtension.h"
#define rateH [UIScreen mainScreen].bounds.size.height / 568
#define rateW fDeviceWidth / 320
@interface DressViewController ()
@property(nonatomic ,assign)int page;
@end

@implementation DressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"1";
}
@end