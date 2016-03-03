//
//  AllFilmTableViewController.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllFilmCell.h"
#import "MJRefresh.h"
#import "UIViewController+Puyun.h"
#import "FilmDetailViewController.h"

@interface AllFilmTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
  
    FilmDetailViewController *filmDetailView;

    
 }

@property (strong, nonatomic)  UITableView *AllFilmTable;

@property (strong, nonatomic)  UISearchBar *searchStars;

@property (strong,nonatomic) NSArray *rightTitle;


- (void) initImageArray;
@end
