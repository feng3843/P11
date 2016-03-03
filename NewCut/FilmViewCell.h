//
//  FilmViewCell.h
//  NewCut
//
//  Created by py on 15-7-29.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *filmImage;
@property(nonatomic,strong) UILabel *filmName;
@property(nonatomic,strong) UILabel *directorName;
@property(nonatomic,strong) UILabel *joinStarName;
@property(nonatomic,strong) UILabel *notice;

@end
