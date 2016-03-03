//
//  HomeViewController.h
//  NewCut
//
//  Created by py on 15-7-7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmImageViewController.h"
#import "PopularStarsImageViewController.h"
//#import "HomeCell.h"
#import "StarsCell.h"
#import "InfoCell.h"
#import "FilmDetailViewController.h"
#import "FilmStarsDetailViewController.h"
#import "CMTool.h"


@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
     NSDictionary *filmInfo;
     NSMutableArray *filmPhoto;
     NSMutableArray *filmId;
     NSMutableArray *filmName;
     NSMutableArray *content;
    
    NSDictionary *starInfo;
    NSMutableArray *starPhoto;
    NSMutableArray *starId;
    NSMutableArray *starName;
    NSMutableArray *starContent;
    

}

@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic) NSInteger totalNum;

@property (strong, nonatomic) UITableView *hotFilmTableView;
@property (strong, nonatomic) UITableView *hotStarTableView;

@property (strong, nonatomic) NSArray *images1;
@property (strong, nonatomic) NSArray *images2;
//@property (strong,nonatomic) NSDictionary *dataSources;
@property (strong,nonatomic) NSArray *keys;

@property (strong,nonatomic) FilmDetailViewController *filmDetail;
@property (strong,nonatomic) FilmStarsDetailViewController *filmStarsDetail;
@property(nonatomic,strong) NSArray *imgUrlArr;
@property(nonatomic,strong) NSArray *nameArr;
@property (strong,nonatomic) NSMutableArray *filmImage;
@property (strong,nonatomic) NSMutableArray *starImage;
@property (strong,nonatomic) NSMutableArray *hotFilmList;
@property (strong,nonatomic) NSMutableArray *hotStarList;

@end
