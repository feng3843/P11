//
//  FuzzySearchViewController.h
//  NewCut
//
//  Created by uncommon on 2015/07/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FilmCell.h"
//#import "StarCell.m"
//#import "GoodCell.h"

@interface FuzzySearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{

    
    NSMutableArray *filmImageArray;
    NSMutableArray *starImageArray;
    NSMutableArray *goodImageArray;
    
    NSMutableArray *filmNameArray;
    NSMutableArray *starNameArray;
    NSMutableArray *goodNameArray;
    NSMutableArray *directorArray;
    NSMutableArray *noticeArray;
    NSMutableArray *nationArray;
    NSMutableArray *productArray;
    NSMutableArray *detailNameArray;
    NSMutableArray *likeArray;
    NSMutableArray *commentArray;
    NSMutableArray *joinStarArray;
    NSMutableArray *filmIdArray;
    NSMutableArray *starIdArray;
    NSMutableArray *goodIdArray;
    BOOL isSearch;
    NSMutableArray *goodRelatedArray;
    
}

@property (nonatomic,strong) UITextField *searchField;
@end
