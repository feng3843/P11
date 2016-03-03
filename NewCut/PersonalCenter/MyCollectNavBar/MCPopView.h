//
//  MCPopView.h
//  NewCut
//
//  Created by 夏雪 on 15/7/27.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCPopViewDelegate <NSObject>

@optional

- (void)viewHeight:(CGFloat)height;
- (void)itemPressedWithIndex:(NSInteger)index;

@end

@interface MCPopView : UIView

@property (nonatomic, weak)     id      <MCPopViewDelegate>delegate;
@property (nonatomic, strong)   NSArray *itemNames;

@end