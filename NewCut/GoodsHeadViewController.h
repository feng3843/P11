//
//  GoodsHeadViewController.h
//  NewCut
//
//  Created by py on 15-8-5.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsHeadViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *headTableView;
@property (nonatomic,strong) NSMutableArray *headImageArray;
@property (strong, nonatomic) NSArray *DressImages;
@end
