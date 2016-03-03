//
//  BlankCell.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "BlankCell.h"
#import "PYAllCommon.h"

@implementation BlankCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     CGFloat w=[UIScreen mainScreen].bounds.size.width;
    /**王朋***********/
     if (self) {
         if (self.type == BlankCellTypeSingleUp || self.type == BlankCellTypeDouble) {
             
             UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 1)];
             line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
             [self addSubview:line];
         }
         if (self.type == BlankCellTypeSingleDown || self.type == BlankCellTypeDouble) {
             
             UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(0, 17.5, w, 0.5)];
             hline.backgroundColor = [UIColor colorWithHexString:@"bababa"];
             [self addSubview:hline];
         }
         self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
     }
    return self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
