//
//  FourBlankCell.m
//  NewCut
//
//  Created by py on 15-7-30.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "FourBlankCell.h"
#import "PYAllCommon.h"

@implementation FourBlankCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    if (self)
    {
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 0.5)];
        line1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:line1];
        
         /****王朋****注释掉横线，鸟人影评和捕手点评下划线消失*/
//        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, w, 1)];
//        line2.backgroundColor = [UIColor colorWithHexString:@"bababa"];
//        [self addSubview:line2];
    }
    
    return self;
}

-(void)setType:(CommentCellType *)type
{
    _type = type;
    NSString* strType;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(11, 12, 64, 15)];
    title.textColor = [UIColor colorWithHexString:@"000000"];
    title.font = [UIFont boldSystemFontOfSize:15];
    if (_type == CommentCellTypeAdmin) {
        
        strType = @"鸟人影评";
    }
    else if (_type == CommentCellTypeAdminGood) {
        strType = @"鸟人点评";
    }
    else if (_type == CommentCellTypeOthers) {
        strType = @"捕手点评";
    }
    
    title.text = strType;
    [self addSubview:title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
