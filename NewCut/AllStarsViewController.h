//
//  AllStarsViewController.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllStarsCell.h"
#import "MJRefresh.h"
#import "UIViewController+Puyun.h"
#import "FilmStarsDetailViewController.h"

@interface AllStarsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    FilmStarsDetailViewController *filmStarDetailView;
    
    
}

@property (strong, nonatomic) UITableView *AllStarsTableView;
@property (strong,nonatomic) NSArray *rightTitle;
@property (strong,nonatomic) UISearchBar *searchStars;


//-(void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;


@end
