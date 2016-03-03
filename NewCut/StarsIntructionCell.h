//
//  StarsIntructionCell.h
//  NewCut
//
//  Created by py on 15-7-14.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarsModel;
@interface StarsIntructionCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
    UITextView *fileText;
}

@property StarsModel* model;

@property(nonatomic,strong)NSString *instructImage;
@property(nonatomic,strong) UIImageView *starImage;
@property(nonatomic,strong) NSString *starsIntruction;


@end
