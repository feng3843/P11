//
//  PopularFilmTableViewController.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularFilmCell.h"
#import "CurrentFilmCell.h"
#import "FilmDetailViewController.h"

@interface PopularFilmTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

     
}

@property (strong, nonatomic)  UITableView *CareFilmTable;
//@property (strong, nonatomic) IBOutlet UITableView *CurrentFilmTable;

//@property (strong,nonatomic) NSArray *popularfilmsImage;
//@property (strong,nonatomic) NSArray *popularfilmsName;
//@property (strong,nonatomic) NSArray *directorsName;
//@property (strong,nonatomic) NSArray *starsName;
//@property (strong,nonatomic) NSArray *notice;
//@property (strong,nonatomic) NSArray *titleArray;
//@property (strong,nonatomic) NSArray *currentFilmname;
//
//@property (strong,nonatomic) NSArray *currentStarsName;

//@property (strong,nonatomic) NSArray *currentDirectorsName;
//@property (strong,nonatomic) NSArray *currentNotice;
//@property (strong,nonatomic) NSArray *currentfilmsImage;

@property (strong,nonatomic) NSArray *dataArray;
@property (strong,nonatomic) NSArray *keys;
@property (strong,nonatomic) NSDictionary *dataSources;
//@property (strong,nonatomic) NSDictionary *nameDataSources;
//@property (strong,nonatomic) NSDictionary *directorDataSources;
//@property (strong,nonatomic) NSDictionary *starsDataSources;
//@property (strong,nonatomic) NSDictionary *noticeDataSources;
@property (strong,nonatomic) FilmDetailViewController *filmDetailView;
@property (strong,nonatomic) NSMutableArray *content;
@property (nonatomic,retain) NSMutableArray *filmNameDataList;
@property (nonatomic,retain) NSMutableArray *TimeList;
@property (nonatomic,retain) NSMutableArray *starList;
@property (nonatomic,strong) NSMutableArray *filmList;
@property (nonatomic,strong) NSMutableArray *ImageArray;
@property (nonatomic,strong) NSMutableArray *urlArray;
@property (strong,nonatomic) NSMutableArray *thisWeekContent;
@property (strong,nonatomic) NSDictionary *thisWeekDataSource;
@property (strong,nonatomic) NSMutableArray *thisWeekFilmList;
@property (strong,nonatomic) NSMutableArray *thisWeekFilmNameList;
@property (strong,nonatomic) NSMutableArray *thisWeekStarList;


@end
