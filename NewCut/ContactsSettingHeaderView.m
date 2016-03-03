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
        CGFloat bgImageX = 115.5;
        CGFloat bgImageY = 50;
        CGFloat bgImageWH = width - bgImageX * 2;
        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(bgImageX, bgImageY, bgImageWH, bgImageWH)];
        bgImage.image = [UIImage imageNamed:@"LOGO.png"];
        [self addSubview:bgImage];
//        CGFloat newOutY = CGRectGetMaxY(bgImage.frame) + 13;
//        
        
    }
    return self;
}


@end
