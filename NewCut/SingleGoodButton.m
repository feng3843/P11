//
//  SingleGoodButton.m
//  NewCut
//
//  Created by 夏雪 on 15/8/8.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "SingleGoodButton.h"

@implementation SingleGoodButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}


- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end
