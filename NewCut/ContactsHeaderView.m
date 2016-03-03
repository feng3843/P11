//
//  ContactsHeaderView.m
//  NewCut
//
//  Created by 夏雪 on 15/7/16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "ContactsHeaderView.h"

@implementation ContactsHeaderView

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
        
        UIImageView *bgImage = [[UIImageView alloc]init];
        bgImage.frame = self.bounds;
        bgImage.image = [UIImage imageNamed:@"bg_me.png"];
        [self addSubview:bgImage];
        
        CGFloat startH = 120;
        CGFloat startW = startH;
        CGFloat startX = 100;
        CGFloat startY = 57;
        UIImageView *startImage = [[UIImageView alloc]initWithFrame:CGRectMake(startX, startY, startH, startW)];

        startImage.image = [UIImage imageNamed:@"head_me.png"];
        [self addSubview:startImage];
        
        CGFloat startNameX  = 0;
        CGFloat startNameY = startY + startW + 18;
        CGFloat startNameW = width;
        CGFloat startNameH = 30;
        UILabel *startName = [[UILabel alloc]initWithFrame:CGRectMake(startNameX, startNameY , startNameW, startNameH)];
        startName.textAlignment = NSTextAlignmentCenter;
        startName.text = @"李易峰";
        startName.textColor = [UIColor whiteColor];
        [self addSubview:startName];
        
        
    }
    return self;
}

@end
