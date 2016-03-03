//
//  HomeCell.h
//  NewCut
//
//  Created by py on 15-7-11.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>



@class HomeCellAction;
@protocol HomeCellDelegate <NSObject>
-(void)cellSelected;
@end

@interface HomeCell : UICollectionViewCell<UIScrollViewDelegate>
{
    CGFloat supW;
    CGFloat off;
    CGFloat diff;
}

@property (strong, nonatomic) IBOutlet UIScrollView *filmScroll;

-(void)setUpCellWithArray:(NSArray *)array;
@property (nonatomic,strong) id<HomeCellDelegate> cellDelegate;


@end
