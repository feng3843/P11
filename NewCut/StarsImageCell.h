//
//  StarsImageCell.h
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoAllImageBrowseDelegate.h"

@interface StarsImageCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
    UIScrollView* scrollView;
    UIView* scrollContentView;
    
}

@property (strong, nonatomic) NSMutableArray *starsImages;
@property (nonatomic, strong) UIImageView* headerImageView;

@property(nonatomic, assign) NSObject<GoAllImageBrowseDelegate>* delegate;  //这里用assign而不用retain是为了防止引起循环引用。

@end