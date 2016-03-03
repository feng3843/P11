//
//  FuzzySearchTableViewCell.h
//  NewCut
//
//  Created by uncommon on 2015/07/21.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchListInfo.h"

@interface FuzzySearchTableViewCell : UITableViewCell

//异步加载图片用到的变量
//@property NSURLResponse* response;
//@property NSMutableData* data;

/** @brief 查询类型 */
@property SearchListInfo* searchListInfo;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewMy;

@property (weak, nonatomic) IBOutlet UILabel *lblMovieName;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieWantSeeNum;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieWantSee2;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieDirector;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieToStar;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseDate;

@property (weak, nonatomic) IBOutlet UILabel *lblStarName;
@property (weak, nonatomic) IBOutlet UILabel *lblStarNationality;
@property (weak, nonatomic) IBOutlet UILabel *lblStarRepresentativeWorks;

@property (weak, nonatomic) IBOutlet UILabel *lblGoodName;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodLoveNum1;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodLoveNum;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodCommentNum1;
@property (weak, nonatomic) IBOutlet UILabel *lblGoodCommentNum;

@end
