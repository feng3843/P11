//
//  TitleBlankCell.m
//  NewCut
//
//  Created by py on 15-7-31.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "TitleBlankCell.h"
#import "PYAllCommon.h"

@implementation TitleBlankCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self) {
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 1)];
        line1.backgroundColor = [UIColor colorWithHexString:@"000000"];
        [self addSubview:line1];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(11, 12, 64, 16)];
        title.textColor = [UIColor colorWithHexString:@"000000"];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.text = @"热门评论";
        [self addSubview:title];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, w, 1)];
        line2.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:line2];
        
    }
    
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
