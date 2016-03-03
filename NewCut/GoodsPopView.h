//
//  GoodsPopView.h
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsPopViewDelegate <NSObject>

@optional

- (void)viewHeight:(CGFloat)height;
- (void)itemPressedWithIndex:(NSInteger)index;

@end

@interface GoodsPopView : UIView

@property (nonatomic, weak)     id      <GoodsPopViewDelegate>delegate;
@property (nonatomic, strong)   NSArray *itemNames;

@end
