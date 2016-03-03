//
//  FilmDetailCell.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//  

#import <UIKit/UIKit.h>

@class MovieModel;
@interface FilmDetailCell : UITableViewCell
{
    //UILabel *movieName;
    //UITableView *hortable;
    //NSString *filmName;
    NSInteger porsection;
}

@property (nonatomic,strong) MovieModel* model;

//@property(nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) UILabel *movieName;
@property (nonatomic,strong) UILabel *movieType;
@property (nonatomic,strong) UILabel *time;
@end
