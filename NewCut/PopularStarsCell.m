//
//  PopularStarsCell.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PopularStarsCell.h"
#import "PYAllCommon.h"

@implementation PopularStarsCell
@synthesize starCountry,starImage,starName,starProduction;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        starImage=[[UIImageView alloc] initWithFrame:CGRectMake(16*h/568, 16*h/568, 60*h/568, 80*h/568)];
        
        starName = [[UILabel alloc] initWithFrame:CGRectMake(91*h/568,26*h/568, 60*h/568, 20*h/568)];
        starName.font = [UIFont boldSystemFontOfSize:15*h/568];
        starName.textColor = [UIColor colorWithHexString:@"000000"];
        
        //directorName = [[UILabel alloc] initWithFrame:CGRectMake(90, 39, 150, 15)];
        //directorName.font = [UIFont systemFontOfSize:13];
        //directorName.textColor = [UIColor colorWithHexString:@"666666"];
        
        //noticeLab = [[UILabel alloc] init];
        //noticeLab.font = [UIFont systemFontOfSize:12];
       // noticeLab.textColor = [UIColor colorWithHexString:@"777777"];
        [self addSubview:starImage];
        [self addSubview:starName];
       // [self addSubview:directorName];
        //[self addSubview:StartingLab];
       // [self addSubview:noticeLab];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
