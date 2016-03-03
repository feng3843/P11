//
//  AllStarsCell.m
//  NewCut
//
//  Created by py on 15-7-9.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "AllStarsCell.h"

@implementation AllStarsCell
@synthesize starImage = _starImage;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _starImage=[[UIImageView alloc] initWithFrame:CGRectMake(16*h/568, 15*h/568, 60*h/568, 80*h/568)];
        [self addSubview:_starImage];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
