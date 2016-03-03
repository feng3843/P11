//
//  JoinFilmCell.h
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYHTableCell.h"

@interface JoinFilmCell : PYHTableCell<UITableViewDelegate,UITableViewDataSource>
{
//    UITableView *hortable;
//    NSInteger porsection;

}

@property (strong, nonatomic) NSMutableArray *filmImages;
@property (strong, nonatomic) NSMutableArray *filmName;
@property (strong, nonatomic) NSMutableArray *time;
@property (strong, nonatomic) NSMutableArray *filmId;

@end
