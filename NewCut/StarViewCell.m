//
//  StarViewCell.m
//  NewCut
//
//  Created by py on 15-7-29.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarViewCell.h"
#import "PYAllCommon.h"

@implementation StarViewCell
@synthesize starName,starImage,nation,product;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        starImage=[[UIImageView alloc] initWithFrame:CGRectMake(16*h/568, 16*h/568, 50*h/568, 70*h/568)];
        
        starName = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 17*h/568, 200*h/568, 16*h/568)];
        starName.font = [UIFont systemFontOfSize:15*h/568];
        starName.textColor = [UIColor colorWithHexString:@"000000"];
        
        nation = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 39*h/568, 150*h/568, 15*h/568)];
        nation.font = [UIFont systemFontOfSize:13*h/568];
        nation.textColor = [UIColor colorWithHexString:@"666666"];
        
        product = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 55*h/568, 200*h/568, 15*h/568)];
        product.font = [UIFont systemFontOfSize:12*h/568];
        product.textColor = [UIColor colorWithHexString:@"777777"];
        [self addSubview:starImage];
        [self addSubview:starName];
        [self addSubview:nation];
        [self addSubview:nation];
        [self addSubview:product];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
