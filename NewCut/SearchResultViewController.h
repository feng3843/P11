//
//  SearchResultViewController.h
//  NewCut
//
//  Created by 夏雪 on 15/8/5.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchResultViewControllerDelegate <NSObject>

@optional
- (void)scroll;
- (void)coverClick;
@end
@interface SearchResultViewController : UITableViewController
@property (nonatomic, copy) NSString *searchText;

@property(nonatomic ,weak)id<SearchResultViewControllerDelegate> delegate;
@end
