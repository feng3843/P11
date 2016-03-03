//
//  MCTabBar.h
//  NewCut
//
//  Created by 夏雪 on 15/7/27.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCTabBarDelegate <NSObject>

@optional

/**
 *  When NavTabBar Item Is Pressed Call Back
 *
 *  @param index - pressed item's index
 */
- (void)itemDidSelectedWithIndex:(NSInteger)index;

/**
 *  When Arrow Pressed Will Call Back
 *
 *  @param pop    - is needed pop menu
 *  @param height - menu height
 */
- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height;

@end

@interface MCTabBar : UIView

@property (nonatomic, weak)     id          <MCTabBarDelegate>delegate;

@property (nonatomic, assign)   NSInteger   currentItemIndex;           // current selected item's index
@property (nonatomic, strong)   NSArray     *itemTitles;                // all items' title

@property (nonatomic, strong)   UIColor     *lineColor;                 // set the underscore color
@property (nonatomic, strong)   UIImage     *arrowImage;                // set arrow button's image

/**
 *  Initialize Methods
 *
 *  @param frame - SCNavTabBar frame
 *  @param show  - is show Arrow Butto
 *
 *  @return Instance
 */
- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show;

/**
 *  Update Item Data
 */
- (void)updateData;

/**
 *  Refresh All Subview
 */
- (void)refresh;


@end

