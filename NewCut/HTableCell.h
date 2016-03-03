//
//  PopularGoodsCell.h
//  NewCut
//
//  Created by py on 15-7-12.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTableCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
    CGFloat angle;
}

@property (strong, nonatomic) NSMutableArray *goodImages;
@property (strong, nonatomic) NSMutableArray *goodsId;

@end
