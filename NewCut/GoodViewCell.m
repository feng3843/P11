//
//  GoodViewCell.m
//  NewCut
//
//  Created by py on 15-7-29.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "GoodViewCell.h"
#import "PYAllCommon.h"

@implementation GoodViewCell
@synthesize goodsImage,goodsName,detailName,likeCount,commentCount,title1,title2;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        goodsImage=[[UIImageView alloc] initWithFrame:CGRectMake(16*h/568, 16*h/568, 50*h/568, 70*h/568)];
        
        goodsName = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 17*h/568, 200*h/568, 16*h/568)];
        goodsName.font = [UIFont systemFontOfSize:15*h/568];
        goodsName.textColor = [UIColor colorWithHexString:@"000000"];
        
        detailName = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 39*h/568, 150*h/568, 15*h/568)];
        detailName.font = [UIFont systemFontOfSize:13*h/568];
        detailName.textColor = [UIColor colorWithHexString:@"666666"];
        
        likeCount = [[UILabel alloc] initWithFrame:CGRectMake(120*h/568, 55*h/568, 70*h/568, 15*h/568)];
        likeCount.font = [UIFont systemFontOfSize:12*h/568];
        likeCount.textColor = [UIColor colorWithHexString:@"777777"];
        
        commentCount = [[UILabel alloc] initWithFrame:CGRectMake(190*h/568, 55*h/568, 70*h/568, 15*h/568)];
        commentCount.font = [UIFont systemFontOfSize:12*h/568];
        commentCount.textColor = [UIColor colorWithHexString:@"777777"];
        
        title1 = [[UILabel alloc] initWithFrame:CGRectMake(90*h/568, 55*h/568, 70*h/568, 15*h/568)];
        title1.font = [UIFont systemFontOfSize:12*h/568];
        title1.textColor = [UIColor colorWithHexString:@"777777"];
        title1.text = @"喜欢";
        
        title2 = [[UILabel alloc] initWithFrame:CGRectMake(160*h/568, 55*h/568, 70*h/568, 15*h/568)];
        title2.font = [UIFont systemFontOfSize:12*h/568];
        title2.textColor = [UIColor colorWithHexString:@"777777"];
        title2.text = @"评论";
        
        [self addSubview:goodsImage];
        [self addSubview:goodsName];
        [self addSubview:likeCount];
        [self addSubview:detailName];
        [self addSubview:commentCount];
        [self addSubview:title1];
        [self addSubview:title2];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
