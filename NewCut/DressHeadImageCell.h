//
//  DressHeadImageCell.h
//  NewCut
//
//  Created by py on 15-7-15.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DressHeadImageCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *hortable;
    NSInteger porsection;
//    UIScrollView* scrollView;
//    UIView* scrollContentView;

}

@property (strong, nonatomic) NSMutableArray *DressImages;
//@property (nonatomic, strong) UIImageView* headerImageView;

@end
