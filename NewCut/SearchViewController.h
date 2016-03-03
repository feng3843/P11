//
//  SearchViewController.h
//  NewCut
//
//  Created by py on 15-7-8.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsTabBarViewController.h"

@interface SearchViewController : UIViewController<UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UISearchBar *searchBarInTop;
@property (nonatomic,strong) UITextField *searchField;
@end
