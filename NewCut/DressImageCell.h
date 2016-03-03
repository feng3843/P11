//
//  DressImageCell.h
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoAllImageBrowseDelegate.h"
#import "SDImageView+SDWebCache.h"

@interface DressImageCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *hortable;
    NSInteger porsection;
    UIScrollView* scrollView;
    UIView* scrollContentView;

}

@property (strong, nonatomic) NSMutableArray *DressImages;
@property (nonatomic, strong) UIImageView* DressImageView;

@property(nonatomic, assign) NSObject<GoAllImageBrowseDelegate>* delegate;  //这里用assign而不用retain是为了防止引起循环引用。

@end
