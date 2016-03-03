//
//  PopularGoodsCell.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovieModel.h"
#import "StarsModel.h"
#import "HotGoodsModel.h"
#import "CommentModel.h"

typedef enum
{
    PYHTableCellStar,
    PYHTableCellGoods,
    PYHTableCellMovie
}PYHTableCellType;

@protocol PYHTableCellDelagate <NSObject>

-(void)loadNewData:(NSInteger)page Type:(PYHTableCellType)type;
-(void)loadOldData:(NSInteger)page Type:(PYHTableCellType)type;
-(void)jump2Detail:(NSString*)index Type:(PYHTableCellType)type;

@end

@interface PYHTableCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
    CGFloat angle;
}

@property NSString* strName;
@property NSString* strNotification;

@property (nonatomic) NSString* count;

@property (nonatomic) NSMutableArray* arrayModel;


@property id<PYHTableCellDelagate> delegate;
@property PYHTableCellType type;
@property NSInteger page;

@end
