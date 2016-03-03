//
//  LineBlankCell.m
//  NewCut
//
//  Created by py on 15-7-31.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "LineBlankCell.h"
#import "PYAllCommon.h"

@implementation LineBlankCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self) {
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 1)];
        line1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        [self addSubview:line1];
        
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
