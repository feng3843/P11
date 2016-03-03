//
//  StarBlankCell.m
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "StarBlankCell.h"
#import "PYAllCommon.h"

@implementation StarBlankCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self) {
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 18)];
        line.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [self addSubview:line];
        
        UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, w, 1)];
        hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:hline];
        
        
    }
    
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
