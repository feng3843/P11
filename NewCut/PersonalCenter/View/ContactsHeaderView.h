//
//  ContactsHeaderView.h
//  NewCut
//
//  Created by 夏雪 on 15/7/16.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactsHeaderViewDelegate <NSObject>

@optional
- (void)setUpBtnDidClick;

- (void)startBtnDidClick;

@end
@interface ContactsHeaderView : UIView

@property(nonatomic ,weak)id<ContactsHeaderViewDelegate> delegate;
@end
