//
//  GoodsTabBarViewController.h
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessoryController.h"
#import "DressViewController.h"
#import "GoodsTabBarController.h"
#import "PeiJianViewController.h"
#import "ShoesViewController.h"
#import "BagViewController.h"
#import "MenuTabBarViewController.h"
#import "SurroundingMovieViewController.h"
@interface GoodsTabBarViewController : UIViewController

@property AccessoryController *accessoryView;
@property DressViewController *dressView;
@property PeiJianViewController *peiJianView;
@property ShoesViewController *shoesView;
@property BagViewController *bagView;
@property (nonatomic,strong) MenuTabBarViewController *menuView;
@property(nonatomic ,strong)SurroundingMovieViewController *surroundingMovie;
@property (strong,nonatomic) UIButton *backBtn;

@property(nonatomic ,assign)NSInteger index;
@end
