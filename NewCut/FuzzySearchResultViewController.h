//
//  FuzzySearchResultViewController.h
//  NewCut
//
//  Created by 夏雪 on 15/8/7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FuzzySearchResultViewControllerDelegate <NSObject>

@optional
- (void)scroll;
- (void)coverClick;
@end

@interface FuzzySearchResultViewController : UITableViewController
@property(nonatomic,copy)NSString *searchText;

@property(nonatomic ,weak)id<FuzzySearchResultViewControllerDelegate> delegate;
@end
