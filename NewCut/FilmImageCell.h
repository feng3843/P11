//
//  FilmImageCell.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "GoAllImageBrowseDelegate.h"

@interface FilmImageCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
    UIScrollView* scrollView;
    UIView* scrollContentView;
    
    
}

@property (strong, nonatomic) NSMutableArray *filmImages;
@property (strong, nonatomic) NSArray *images1;
@property (nonatomic, strong) UIImageView* headerImageView;

- (FilmImageCell*)initWithTableViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height;
- (FilmImageCell*)initWithScrollViewWithHeaderImage:(UIImage*)headerImage withOTCoverHeight:(CGFloat)height withScrollContentViewHeight:(CGFloat)height;
- (void)setHeaderImage:(UIImage *)headerImage;

@property(nonatomic, assign) NSObject<GoAllImageBrowseDelegate>* delegate;  //这里用assign而不用retain是为了防止引起循环引用。

@end

@interface UIImage (Blur)
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;

@end