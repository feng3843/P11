//
//  StarsCell.h
//  NewCut
//
//  Created by py on 15-7-11.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StarsCell : UITableViewCell
{
   // UITableView *hortable;
    //NSInteger porsection;
}

@property (strong, nonatomic) NSArray *images2;
@property (strong, nonatomic) NSArray *images1;
@property (strong, nonatomic) NSArray *name;
@property (strong,nonatomic) NSDictionary *starInfo;
@property (strong,nonatomic) NSMutableArray *starPhoto;
@property (strong,nonatomic) NSMutableArray *starId;
@property (strong,nonatomic) NSMutableArray *starName;
@property (strong,nonatomic) NSMutableArray *content;
@property (strong,nonatomic) UIImageView *starImageView;
@property (strong,nonatomic) UILabel *starNameLab;

-(void)getStarPhoto;
@end
