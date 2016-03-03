//
//  PopularStarsViewController.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularStarsCell.h"
#import "FilmStarsDetailViewController.h"

@interface PopularStarsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    
}


@property (strong, nonatomic) UITableView *popularStarsTableView;

@property (strong,nonatomic) NSArray *keys;
@property (strong,nonatomic) NSDictionary *mostConcernStar;
@property (strong,nonatomic) NSDictionary *fashionStar;
@property (strong,nonatomic) NSMutableArray *mostConcernList;
@property (strong,nonatomic) NSMutableArray *fashionList;

@property (strong,nonatomic) NSMutableArray *fashionContent;
@property (strong,nonatomic) FilmStarsDetailViewController *filmStarDetailView;

@end
