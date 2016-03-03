//
//  PYActivityIndicatorView.h
//  NewCut
//
//  Created by MingleFu on 15/8/5.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMG_LOADING @"loading"

@interface PYActivityIndicatorView : UIView <NSCoding>
{
    BOOL _animating;
}

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
