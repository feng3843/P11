//
//  HomeCell.m
//  NewCut
//
//  Created by py on 15-7-11.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell
//@synthesize filmScroll;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)setUpCellWithArray:(NSArray *)array
{
    CGFloat xbase = 320;
    CGFloat width = 100;
    
    [self.filmScroll setScrollEnabled:YES];
    [self.filmScroll setShowsHorizontalScrollIndicator:NO];
    
   // UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.filmScroll.frame.size.width, filmScroll.frame.size.height)];
    
    //[self.filmScroll addSubview:imageView];
    for(int i = 0; i < [array count]; i++)
    {
        UIImage *image = [array objectAtIndex:i];
        //[imageView setImage:image];
        UIView *custom = [self createCustomViewWithImage: image];
        [self.filmScroll addSubview:custom];
        [custom setFrame:CGRectMake(i * 320, 0,320, 300)];
        xbase += 320;
        
        
    }

    [self.filmScroll setContentSize:CGSizeMake(xbase,300)];
    self.filmScroll.delegate = self;
    
}
//
-(UIView *)createCustomViewWithImage:(UIImage *)image
{
    
    UIView *custom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 300)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 225)];
    [imageView setImage:image];
    
    [custom addSubview:imageView];
    [custom setBackgroundColor:[UIColor whiteColor]];
    
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(handleSingleTap:)];
//    [custom addGestureRecognizer:singleFingerTap];
    
    return custom;
}

//The event handling method
//- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
//    NSLog(@"clicked");
//    
//    UIView *selectedView = (UIView *)recognizer.view;
//    
//    if([_cellDelegate respondsToSelector:@selector(cellSelected)])
//        [_cellDelegate cellSelected];
//    
//    //Do stuff here...
//}


@end
