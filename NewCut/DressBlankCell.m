//
//  DressBlankCell.m
//  NewCut
//
//  Created by py on 15-7-16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "DressBlankCell.h"
#import "PYAllCommon.h"

@implementation DressBlankCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self) {
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 18)];
        line.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [self addSubview:line];
        
        //         UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, w, 1)];
        //         hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        //         [self addSubview:hline];
        
        //self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    }
    return self;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
