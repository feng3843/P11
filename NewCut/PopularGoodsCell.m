//
//  PopularGoodsCell.m
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "PopularGoodsCell.h"
#import "PYAllCommon.h"
#import "SDImageView+SDWebCache.h"
/***王朋***/
#define HEIGHT 194
#define LEFT DEFAULT_LEFT
#define TOP 38
#define BOTTOM 19

#define TABLE_HEIGHT (HEIGHT - TOP - BOTTOM)
#define TABLE_WIDTH (SCREEN_WIDTH - LEFT)

#define IMAGE_HEIGHT TABLE_HEIGHT
#define IMAGE_WIDTH TABLE_HEIGHT

#define BLANK 4


#define NAME @"热门潮搭"
#define NOTICATION @"good"


@implementation PopularGoodsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.strName = NAME;
        self.strNotification = NOTICATION;
        self.type = PYHTableCellGoods;
    }
    
    return self;
}

@end
