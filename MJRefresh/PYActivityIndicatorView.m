//
//  PYActivityIndicatorView.m
//  NewCut
//
//  Created by MingleFu on 15/8/5.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PYActivityIndicatorView.h"
#import "Masonry.h"

#define ROUND_IMAGE_VIEW @"roundImageView"

@interface PYActivityIndicatorView()
{
    UIImageView* imageView;
    UIImage* image;
}

@end

@implementation PYActivityIndicatorView

-(id)init
{
    if (self == [super init]) {
        if (!imageView) {
            imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:imageView];
        }
        if (image) {
            imageView.image = image;
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"loading"];
        }
//        imageView.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, 30, 30);
//        imageView.frame = self.frame;
        [self flushImage];
    }
    
    return self;
}

-(void)flushImage
{
    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
}

-(void)animatingImageView
{
    //旋转动画
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI_2];
    // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //匀速
    rotationAnimation.repeatCount = HUGE_VALF;
    //运行动画
    [imageView.layer addAnimation:rotationAnimation forKey:ROUND_IMAGE_VIEW];
}

-(void)startAnimating
{
    _animating = YES;
    imageView.alpha = 1.0;
    [self animatingImageView];
}

-(void)stopAnimating
{
    _animating = NO;
    imageView.alpha = 0.0;
    [imageView.layer removeAnimationForKey:ROUND_IMAGE_VIEW];
}

-(BOOL)isAnimating
{
    return _animating;
}

@end
