//
//  FimTabBarViewController.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "AllFilmTableViewController.h"
#import "PopularFilmTableViewController.h"
#import "SearchViewController.h"

@interface FimTabBarViewController : UIViewController

@property (strong,nonatomic) UIButton *backBtn;

@property AllFilmTableViewController *allFilmView;
@property PopularFilmTableViewController *favoriteFilmView;

//@property SearchViewController *searchView;
//@property (strong, nonatomic) IBOutlet UIButton *backBtn;
//@property (strong, nonatomic) IBOutlet UIButton *backBtn;


@end
