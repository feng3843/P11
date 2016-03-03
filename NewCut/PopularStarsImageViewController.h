//
//  PopularStarsImageViewController.h
//  NewCut
//
//  Created by py on 15-7-7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopularStarsImageViewController;
@protocol PopularStarsImageViewControllerDelegate <UIScrollViewDelegate>

@optional
- (void)selectionStarsDidUpdateForPicker:(PopularStarsImageViewController *)picker;

@end

@interface PopularStarsImageViewController : UIScrollView

@property (nonatomic, weak) id<PopularStarsImageViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *selectedImageIndexes;
- (void)setImages:(NSArray *)images;
@end
