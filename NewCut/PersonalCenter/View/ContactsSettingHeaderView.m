//
//  ContactsSettingHeaderView.m
//  NewCut
//
//  Created by 夏雪 on 15/7/20.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ContactsSettingHeaderView.h"

@implementation ContactsSettingHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = self.bounds.size.width;
        CGFloat bgImageWH = 90;
        CGFloat bgImageX = (width - bgImageWH ) * 0.5;
        CGFloat bgImageY = 50;
       
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(bgImageX, bgImageY, bgImageWH, bgImageWH)];
        bgImage.image = [UIImage imageNamed:@"shezhilogo.png"];
        [self addSubview:bgImage];
    
//        CGFloat newOutW = 96;
//        CGFloat newOutY = CGRectGetMaxY(bgImage.frame) + 13;
//        CGFloat newOutX = (width - newOutW ) * 0.5;
//;
//      
//        CGFloat newOutH = 20;
//        UIImageView *newOutImage = [[UIImageView alloc]initWithFrame:CGRectMake(newOutX, newOutY, newOutW, newOutH)];
//        newOutImage.image = [UIImage imageNamed:@"new cut.png"];
//        [self addSubview:newOutImage];
        
        
//
        
    }
    return self;
}


@end
