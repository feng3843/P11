//
//  AllStarsCell.h
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllStarsCell : UITableViewCell
{

    UIImageView *_starImage;
}

@property (nonatomic, readonly)UIImageView *starImage;
@property UILabel *starName;
@property UILabel *starCountry;
@property UILabel *starProduction;

@end
