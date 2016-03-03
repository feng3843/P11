//
//  AllStarSearchResultViewController.h
//  NewCut
//
//  Created by 夏雪 on 15/8/6.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AllStarSearchResultViewControllerDelegate <NSObject>

@optional
- (void)scroll;
- (void)coverClick;
@end
@interface AllStarSearchResultViewController : UITableViewController
@property (nonatomic, copy) NSString *searchText;
@property(nonatomic ,weak)id<AllStarSearchResultViewControllerDelegate> delegate;
@end
