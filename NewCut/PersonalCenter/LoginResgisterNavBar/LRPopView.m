//
//  LRPopView.m
//  NewCut
//
//  Created by 夏雪 on 15/7/27.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "LRPopView.h"
#import "CommonMacro.h"

@implementation LRPopView
#pragma mark - Private Methods
#pragma mark -
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
//        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
//        NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
         NSNumber *width = [NSNumber numberWithFloat:28.0];
        [widths addObject:width];
    }
    
    return widths;
}

- (void)updateSubViewsWithItemWidths:(NSArray *)itemWidths;
{
    CGFloat buttonX = DOT_COORDINATE;
    CGFloat buttonY = DOT_COORDINATE;
    for (NSInteger index = 0; index < [itemWidths count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.frame = CGRectMake(buttonX, buttonY, [itemWidths[index] floatValue], ITEM_HEIGHT);
//        button.backgroundColor = [UIColor redColor];
        [button setTitle:_itemNames[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        buttonX += [itemWidths[index] floatValue];
        
        @try {
            if ((buttonX + [itemWidths[index + 1] floatValue]) >= SCREEN_WIDTH)
            {
                buttonX = DOT_COORDINATE;
                buttonY += ITEM_HEIGHT;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
}

- (void)itemPressed:(UIButton *)button
{
    [_delegate itemPressedWithIndex:button.tag];
}

#pragma mark - Public Methods
#pragma marl -
- (void)setItemNames:(NSArray *)itemNames
{
    _itemNames = itemNames;
    
    NSArray *itemWidths = [self getButtonsWidthWithTitles:itemNames];
    [self updateSubViewsWithItemWidths:itemWidths];
}

@end

