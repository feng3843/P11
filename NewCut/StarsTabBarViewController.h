//
//  StarsTabBarViewController.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllStarsViewController.h"
#import "PopularStarsViewController.h"

@interface StarsTabBarViewController : UIViewController


@property (strong,nonatomic) UIButton *backBtn;

@property AllStarsViewController *allStarsView;
@property PopularStarsViewController *favoriteStarsView;

@end
