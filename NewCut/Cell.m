//
//  Cell.m
//  EGODemo
//
//  Created by DolBy on 13-5-31.
//  Copyright (c) 2013年 Duxinfeng. All rights reserved.
//

#import "Cell.h"
//#import "EGOImageView.h"

@implementation Cell
@synthesize imgView,filmName ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
        imgView.frame = CGRectMake(0, 0, w , 225);
        filmName.frame = CGRectMake(0, 0, 30 , 30);

        [self addSubview:imgView];
        [self addSubview:filmName];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)egoImageViewWithImg:(NSString *)imgURLStr
//{
//    self.egoImgView.imageURL = [NSURL URLWithString:imgURLStr];
//}
@end
