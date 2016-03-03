//
//  FilmImageViewController.h
//  NewCut
//
//  Created by py on 15-7-7.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilmImageViewController;
@protocol FilmImageViewControllerDelegate <UIScrollViewDelegate>

@optional
- (void)selectionDidUpdateForPicker:(FilmImageViewController *)picker;

@end

@interface FilmImageViewController : UIScrollView

@property (nonatomic, weak) id<FilmImageViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *selectedImageIndexes;

- (void)setImages:(NSArray *)images;

@end

