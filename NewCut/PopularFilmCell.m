//
//  PopularFilmCell.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PopularFilmCell.h"

@implementation PopularFilmCell
@synthesize filmName,filmImage,directorName,StartingLab,noticeLab,title,likeCount;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        filmImage=[[UIImageView alloc] initWithFrame:CGRectMake(16*h/568, 16*h/568, 60*h/568, 80*h/568)];
        
        filmName = [[UILabel alloc] initWithFrame:CGRectMake(91*h/568, 16*h/568, 200*h/568, 16*h/568)];
        filmName.font = [UIFont systemFontOfSize:15*h/568];
        filmName.textColor = [UIColor colorWithHexString:@"000000"];
        
        directorName = [[UILabel alloc] initWithFrame:CGRectMake(91*h/568, 38*h/568, 150*h/568, 15*h/568)];
        directorName.font = [UIFont systemFontOfSize:13*h/568];
        directorName.textColor = [UIColor colorWithHexString:@"666666"];
        
        noticeLab = [[UILabel alloc] init];
        noticeLab.font = [UIFont systemFontOfSize:12*h/568];
        noticeLab.textColor = [UIColor colorWithHexString:@"777777"];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(274*h/568, 20*h/568, 30*h/568, 10*h/568)];
        title.font = [UIFont systemFontOfSize:10*h/568];
        title.textColor = [UIColor colorWithHexString:@"ff9c00"];
        title.text = @"人想看";
        
        likeCount = [[UILabel alloc] initWithFrame:CGRectMake(225*h/568, 13*h/568, 110*h/568, 22*h/568)];
        likeCount.font = [UIFont fontWithName:@"Helvetica Neue 55roman" size:22];
        likeCount.textColor = [UIColor colorWithHexString:@"ff9c00"];
        likeCount.text = @"17865";
        
        
        //[self addSubview:title];
       // [self addSubview:likeCount];
        [self addSubview:filmImage];
        [self addSubview:filmName];
        [self addSubview:directorName];
        //[self addSubview:StartingLab];
        [self addSubview:noticeLab];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
