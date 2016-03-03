//
//  LRScrollView.m
//  NewCut
//
//  Created by MingleFu on 15/8/11.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "LRScrollView.h"

@implementation LRScrollView


-(BOOL)isDecelerating
{
    return NO;
}

//-(BOOL)isDragging
//{
//    return YES;
//}

//-(BOOL)isTracking
//{
//    return YES;
//}

//- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
//{
//    NSLog(@"用户点击了scroll上的视图%@,是否开始滚动scroll",view);
//    //返回yes 是不滚动 scroll 返回no 是滚动scroll
//    if([view isKindOfClass:[UIButton class]])
//    {
//        return NO;
//    }
//    return YES;
//}

//-(BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    return YES;
//}

@end
