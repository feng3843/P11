//
//  AllFilmCell.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllFilmCell : UITableViewCell
{
    UIImageView *_filmImage;

}

@property (nonatomic, readonly)UIImageView *filmImage;
@property UILabel *filmName;
@property UILabel *directorName;
@property UILabel *StartingLab;
@property UILabel *noticeLab;
@property UILabel *title;
@property UILabel *likeCount;

@end
