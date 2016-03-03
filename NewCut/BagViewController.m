//
//  BagViewController.m
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "BagViewController.h"
#import "PYAllCommon.h"
#import "CMTool.h"
#import "CMAPI.h"
#import "SDImageView+SDWebCache.h"
#import "GoodDetailModel.h"
#import "CommodityDetailsView.h"
#import "MJExtension.h"
#define rateH [UIScreen mainScreen].bounds.size.height / 568
#define rateW fDeviceWidth / 320
@interface BagViewController ()
@property(nonatomic ,assign)int page;
@end

@implementation BagViewController
@synthesize bagImages,bagNames,dressDetailView;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.type = @"5";
}
@end