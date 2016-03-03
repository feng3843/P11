//
//  FilmViewCell.m
//  NewCut
//
//  Created by py on 15-7-29.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FilmViewCell.h"
#import "PYAllCommon.h"

@implementation FilmViewCell
@synthesize filmName,filmImage,directorName,joinStarName,notice;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        filmImage=[[UIImageView alloc] initWithFrame:CGRectMake(16*h/568, 16*h/568, 50*h/568, 70*h/568)];
        
        filmName = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 17*h/568, 200*h/568, 16*h/568)];
        filmName.font = [UIFont systemFontOfSize:15*h/568];
        filmName.textColor = [UIColor colorWithHexString:@"000000"];
        
        directorName = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 39*h/568, 150*h/568, 15*h/568)];
        directorName.font = [UIFont systemFontOfSize:13*h/568];
        directorName.textColor = [UIColor colorWithHexString:@"666666"];

        joinStarName = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 55*h/568, 210*h/568, 15*h/568)];
        joinStarName.font = [UIFont systemFontOfSize:13*h/568];
        joinStarName.textColor = [UIColor colorWithHexString:@"666666"];
        
        notice = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 70*h/568, 100*h/568, 13*h/568)];
        notice.font = [UIFont systemFontOfSize:12*h/568];
        notice.textColor = [UIColor colorWithHexString:@"777777"];
        [self addSubview:filmImage];
        [self addSubview:filmName];
        [self addSubview:directorName];
        [self addSubview:joinStarName];
        [self addSubview:notice];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
