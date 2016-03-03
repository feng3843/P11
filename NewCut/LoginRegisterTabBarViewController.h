//
//  LoginRegisterTabBarViewController.h
//  NewCut
//
//  Created by 夏雪 on 15/7/17.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllFilmTableViewController.h"
#import "PopularFilmTableViewController.h"
@interface LoginRegisterTabBarViewController : UIViewController
@property AllFilmTableViewController *allFilmView;
@property PopularFilmTableViewController *favoriteFilmView;
@end
